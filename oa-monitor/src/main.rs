use anyhow::{Context, Result};
use shellexpand::tilde;
use crossterm::{
    event::{self, DisableMouseCapture, EnableMouseCapture, Event, KeyCode},
    execute,
    terminal::{disable_raw_mode, enable_raw_mode, EnterAlternateScreen, LeaveAlternateScreen},
};
use notify_debouncer_full::notify;
use notify::{Config, EventKind, RecommendedWatcher, Watcher};
use ratatui::{
    backend::CrosstermBackend,
    prelude::*,
    style::{Color, Modifier, Style},
    text::{Line, Span},
    widgets::{Block, Borders, List, ListItem},
    Terminal,
};
use std::{
    collections::HashMap,
    path::PathBuf,
    sync::Arc,
    time::{Duration, Instant},
};
use tokio::sync::{mpsc, RwLock};

#[derive(Debug, Clone)]
struct FileState {
    count: u32,
    last_modified: Instant,
    created: bool,
    exists: bool,
}

#[derive(Default)]
struct AppState {
    files: HashMap<PathBuf, FileState>,
    deleted: HashMap<PathBuf, Instant>,
}

impl AppState {
    async fn update_file(&mut self, path: PathBuf, is_create: bool) {
        let entry = self.files.entry(path.clone()).or_insert(FileState {
            count: 0,
            last_modified: Instant::now(),
            created: is_create,
            exists: true,
        });

        entry.count += 1;
        entry.last_modified = Instant::now();
        entry.created &= is_create;
        entry.exists = true;
    }

    async fn mark_deleted(&mut self, path: PathBuf) {
        if let Some(entry) = self.files.get_mut(&path) {
            entry.exists = false;
            self.deleted.insert(path, Instant::now());
        }
    }
}

async fn run_app(watch_path: PathBuf) -> Result<()> {
    enable_raw_mode()?;
    let mut stdout = std::io::stdout();
    execute!(stdout, EnterAlternateScreen, EnableMouseCapture)?;
    let backend = CrosstermBackend::new(stdout);
    let mut terminal = Terminal::new(backend)?;

    let state = Arc::new(RwLock::new(AppState::default()));
    let (tx, mut rx) = mpsc::unbounded_channel();

    // Configure watcher with proper error handling
    let mut watcher = RecommendedWatcher::new(
        move |res: Result<notify::Event, notify::Error>| {
            match res {
                Ok(event) => {
                    if let Err(e) = tx.send(event) {
                        eprintln!("Error sending event: {}", e);
                    }
                }
                Err(e) => eprintln!("Watcher error: {}", e),
            }
        },
        Config::default(),
    )?;
  // Validate and canonicalize path
    let watch_path = watch_path.canonicalize()
        .context("Failed to resolve watch path")?;

    if !watch_path.exists() {
        anyhow::bail!("Path does not exist: {}", watch_path.display());
    }

    if !watch_path.is_dir() {
        anyhow::bail!("Path is not a directory: {}", watch_path.display());
    }

    // Update watcher setup
    watcher.watch(&watch_path, notify::RecursiveMode::Recursive)
        .with_context(|| format!("Failed to watch path: {}", watch_path.display()))?;

    let state_clone = state.clone();
    tokio::spawn(async move {
        while let Some(event) = rx.recv().await {
            let mut state = state_clone.write().await;
            for path in event.paths {
                match event.kind {
                    EventKind::Create(_) => state.update_file(path, true).await,
                    EventKind::Modify(_) => state.update_file(path, false).await,
                    EventKind::Remove(_) => state.mark_deleted(path).await,
                    _ => {}
                }
            }
        }
    });

    loop {
        let state = state.read().await;
        terminal.draw(|f| ui(f, &state))?;

        if event::poll(Duration::from_millis(100))? {
            match event::read()? {
                Event::Key(key) if key.code == KeyCode::Char('q') || key.code == KeyCode::Esc => break,
                _ => {}
            }
        }
    }

    disable_raw_mode()?;
    execute!(
        terminal.backend_mut(),
        LeaveAlternateScreen,
        DisableMouseCapture
    )?;
    Ok(())
}

// UI function remains the same as previous example

fn ui(frame: &mut Frame, state: &AppState) {
    let now = Instant::now();
    let mut items = Vec::new();

    // Current files
    for (path, file) in &state.files {
        if !file.exists {
            continue;
        }

        let age = now.duration_since(file.last_modified).as_secs_f32();
        let blink = age < 1.0;
        let created_style = if file.created {
            Style::new().fg(Color::Green)
        } else {
            Style::new().fg(Color::Gray)
        };

        let line = Line::from(vec![
            Span::styled(
                format!("[{:03}] ", file.count),
                Style::new().fg(Color::Yellow),
            ),
            Span::styled(
                path.display().to_string(),
                created_style.add_modifier(if blink { Modifier::SLOW_BLINK } else { Modifier::empty() }),
            ),
            Span::styled(
                format!(" ({:.1}s)", age),
                Style::new().fg(Color::Blue),
            ),
        ]);

        items.push(ListItem::new(line));
    }

    // Recently deleted files
    for (path, deleted_time) in &state.deleted {
        let age = now.duration_since(*deleted_time).as_secs_f32();
        if age < 100.0 {
            items.push(ListItem::new(
                Line::from(Span::styled(
                    format!("[DEL] {} ({:.1}s ago)", path.display(), age),
                    Style::new().bg(Color::Red).fg(Color::Black),
                ))
            ));
        }
    }

    let list = List::new(items)
        .block(Block::default().title(" File Changes ").borders(Borders::ALL))
        .highlight_style(Style::new().add_modifier(Modifier::BOLD));

    frame.render_widget(list, frame.area());
}

#[tokio::main]
async fn main() -> Result<()> {
    // Parse command line arguments
    let args: Vec<String> = std::env::args().collect();
    
    // Expand ~ in paths and handle no-arg case
    let watch_path = match args.get(1) {
        Some(path) => PathBuf::from(tilde(path).to_string()),
        None => std::env::current_dir()?,
    };

    run_app(watch_path).await
}
