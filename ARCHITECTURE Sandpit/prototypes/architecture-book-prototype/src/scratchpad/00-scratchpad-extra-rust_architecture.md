# A Composable, Decoupled, and Cohesive Architecture

Below is a proposed refactoring and architectural outline for the given code. The goal is to allow for easier scalability, extension, and maintenance by breaking the concerns apart into self-contained modules (or components) that have well-defined boundaries. These are composable in a category-theoretic sense, providing decoupling and pluggability.

    Note: The code samples below are illustrative. They demonstrate how to separate concerns while still making it straightforward to integrate everything at runtime.

## High-Level Concept

The code can be divided into four main sections:

    Domain (Core Types and Logic) Encapsulates the business rules and data structures (e.g., file states, counters, etc.).
    
    Infrastructure (Watcher) Handles external resources and IO, like notify_debouncer_full or RecommendedWatcher.
    
    Application State (Coordinator) Holds the assembled state (e.g., the AppState) and orchestrates interactions between domain logic and infrastructure events.
   
    Presentation (UI Rendering) Renders the data from the domain state, tailored for a terminal-based UI (via ratatui).

By isolating the domain from both the UI and the watcher, we can easily substitute different watchers or UI toolkits.
Module-by-Module Outline

### 1. Domain Module

Create a module, for instance domain.rs, that contains only the data structures and pure (or mostly pure) logic:

```
// domain.rs

use std::time::Instant;
use std::path::PathBuf;
use std::collections::HashMap;

#[derive(Debug, Clone)]
pub struct FileState {
    pub count: u32,
    pub last_modified: Instant,
    pub created: bool,
    pub exists: bool,
}

#[derive(Default)]
pub struct AppState {
    pub files: HashMap<PathBuf, FileState>,
    pub deleted: HashMap<PathBuf, Instant>,
}

impl AppState {
    pub fn update_file(&mut self, path: &PathBuf, is_create: bool) {
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

    pub fn mark_deleted(&mut self, path: &PathBuf) {
        if let Some(entry) = self.files.get_mut(path) {
            entry.exists = false;
            self.deleted.insert(path.clone(), Instant::now());
        }
    }
}
```
    Emphasis: Notice that this module is purely about the state and logic around file tracking. No concurrency, no watchers, and no UI details appear here.

### 2. Infrastructure (Watcher) Module

This module deals with the details of how watchers produce events. For example, create a trait called FileWatcher that can be implemented for any file-watching library. This trait will stream events, which we can forward onto the application state:

```
// watcher.rs

use std::path::PathBuf;
use tokio::sync::mpsc::{UnboundedSender, UnboundedReceiver};
use notify::{RecommendedWatcher, Config, Event, RecursiveMode, Watcher, Error as NotifyError};

#[derive(Debug)]
pub enum WatchEvent {
    Created(PathBuf),
    Modified(PathBuf),
    Removed(PathBuf),
    // Potentially more variants if needed
}

pub trait FileWatcher {
    fn watch(&mut self, path: &PathBuf) -> Result<(), NotifyError>;
    fn receiver(&mut self) -> UnboundedReceiver<WatchEvent>;
}

pub struct NotifyFileWatcher {
    watcher: RecommendedWatcher,
    rx: UnboundedReceiver<WatchEvent>,
}

impl NotifyFileWatcher {
    pub fn new() -> Result<(Self, UnboundedSender<WatchEvent>), NotifyError> {
        let (tx, rx) = tokio::sync::mpsc::unbounded_channel();
        
        // Build a recommended watcher
        let watcher = RecommendedWatcher::new(
            move |res: Result<Event, notify::Error>| {
                if let Ok(event) = res {
                    for path in event.paths {
                        let _ = match event.kind {
                            notify::EventKind::Create(_) => tx.send(WatchEvent::Created(path)),
                            notify::EventKind::Modify(_) => tx.send(WatchEvent::Modified(path)),
                            notify::EventKind::Remove(_) => tx.send(WatchEvent::Removed(path)),
                            _ => Ok(()),
                        };
                    }
                }
            },
            Config::default(),
        )?;

        Ok((Self { watcher, rx }, tx))
    }
}

impl FileWatcher for NotifyFileWatcher {
    fn watch(&mut self, path: &PathBuf) -> Result<(), NotifyError> {
        self.watcher.watch(path, RecursiveMode::Recursive)
    }

    fn receiver(&mut self) -> UnboundedReceiver<WatchEvent> {
        // Return the MPSC receiver so we can consume events
        std::mem::replace(&mut self.rx, tokio::sync::mpsc::unbounded_channel().1)
    }
}
```
    Emphasis: This approach abstracts away the underlying details of notify. If in the future you decide to replace the watcher library, you only need to swap out the contents of this module and keep the same trait. This is pluggable design in action.

### 3. Application State and Coordinator

This module (or section of code) ties together the domain logic in AppState with the infrastructure events from the watcher. It also coordinates concurrency and ensures messages are fed into the domain properly:

```
// coordinator.rs

use crate::domain::AppState;
use crate::watcher::{FileWatcher, WatchEvent};
use std::path::PathBuf;
use tokio::sync::RwLock;
use std::sync::Arc;
use anyhow::{Result, Context};
use std::time::Duration;

pub struct AppCoordinator<W: FileWatcher> {
    pub state: Arc<RwLock<AppState>>,
    pub watcher: W,
}

impl<W: FileWatcher> AppCoordinator<W> {
    pub fn new(state: Arc<RwLock<AppState>>, watcher: W) -> Self {
        Self { state, watcher }
    }

    pub async fn run(&mut self, watch_path: PathBuf) -> Result<()> {
        // Validation logic
        let watch_path = watch_path
            .canonicalize()
            .context("Failed to resolve watch path")?;

        if !watch_path.exists() {
            anyhow::bail!("Path does not exist: {}", watch_path.display());
        }

        if !watch_path.is_dir() {
            anyhow::bail!("Path is not a directory: {}", watch_path.display());
        }

        self.watcher
            .watch(&watch_path)
            .with_context(|| format!("Failed to watch path: {}", watch_path.display()))?;

        // Acquire the watcher's event stream
        let mut rx = self.watcher.receiver();

        // Spin up a tokio task that listens for file events and updates state
        let state_clone = self.state.clone();
        tokio::spawn(async move {
            while let Some(event) = rx.recv().await {
                let mut state = state_clone.write().await;
                match event {
                    WatchEvent::Created(path) => state.update_file(&path, true),
                    WatchEvent::Modified(path) => state.update_file(&path, false),
                    WatchEvent::Removed(path) => state.mark_deleted(&path),
                }
            }
        });

        Ok(())
    }
}
```

    Emphasis: The business rules are completely separated from how events are delivered.
    
This AppCoordinator sets up the watcher, validates the path, and spawns the background handling.


### 4. Presentation (UI Rendering)

Finally, we have the terminal UI code that queries our AppState and draws widgets. This is purely about how to visualize the data:

```
// ui.rs

use crate::domain::AppState;
use ratatui::{
    backend::Backend,
    Frame,
    style::{Color, Modifier, Style},
    text::{Line, Span},
    widgets::{Block, Borders, List, ListItem},
};
use std::time::Instant;

pub fn draw_ui<B: Backend>(frame: &mut Frame<B>, state: &AppState) {
    let now = Instant::now();
    let mut items = Vec::new();

    // Current files
    for (path, file_state) in &state.files {
        if !file_state.exists {
            continue;
        }

        let age = now.duration_since(file_state.last_modified).as_secs_f32();
        let blink = age < 1.0;
        let created_style = if file_state.created {
            Style::new().fg(Color::Green)
        } else {
            Style::new().fg(Color::Gray)
        };

        let line = Line::from(vec![
            Span::styled(format!("[{:03}] ", file_state.count), Style::new().fg(Color::Yellow)),
            Span::styled(
                path.display().to_string(),
                created_style.add_modifier(
                    if blink {
                        Modifier::SLOW_BLINK
                    } else {
                        Modifier::empty()
                    }
                ),
            ),
            Span::styled(format!(" ({:.1}s)", age), Style::new().fg(Color::Blue)),
        ]);

        items.push(ListItem::new(line));
    }

    // Recently deleted
    for (path, deleted_time) in &state.deleted {
        let age = now.duration_since(*deleted_time).as_secs_f32();
        if age < 100.0 {
            items.push(ListItem::new(Line::from(
                Span::styled(
                    format!("[DEL] {} ({:.1}s ago)", path.display(), age),
                    Style::new().bg(Color::Red).fg(Color::Black)
                )
            )));
        }
    }

    let list = List::new(items)
        .block(Block::default().title(" File Changes ").borders(Borders::ALL))
        .highlight_style(Style::new().add_modifier(Modifier::BOLD));

    frame.render_widget(list, frame.area());
}
```

### The Main Entry Point

Now, in the main.rs (or binary crate) file, we piece it all together:

```
// main.rs

mod domain;
mod watcher;
mod coordinator;
mod ui;

use anyhow::Result;
use crossterm::{
    execute,
    terminal::{disable_raw_mode, enable_raw_mode, EnterAlternateScreen, LeaveAlternateScreen},
    event::{self, DisableMouseCapture, EnableMouseCapture, Event, KeyCode},
};
use domain::AppState; // from our new module
use watcher::NotifyFileWatcher;
use coordinator::AppCoordinator;
use ratatui::{backend::CrosstermBackend, Terminal};
use std::path::PathBuf;
use std::io::stdout;
use std::time::Duration;
use tokio::sync::RwLock;
use std::sync::Arc;
use shellexpand::tilde;

#[tokio::main]
async fn main() -> Result<()> {
    // 1) Parse command line
    let args: Vec<String> = std::env::args().collect();
    let watch_path = match args.get(1) {
        Some(path) => PathBuf::from(tilde(path).to_string()),
        None => std::env::current_dir()?,
    };

    // 2) Setup raw mode, alternate screen
    enable_raw_mode()?;
    let mut stdout = stdout();
    execute!(stdout, EnterAlternateScreen, EnableMouseCapture)?;

    let backend = CrosstermBackend::new(stdout);
    let mut terminal = Terminal::new(backend)?;

    // 3) Create domain state
    let state = Arc::new(RwLock::new(AppState::default()));

    // 4) Create watcher
    let (mut watcher, _tx) = NotifyFileWatcher::new()?;

    // 5) Coordinator to connect them
    let mut coordinator = AppCoordinator::new(state.clone(), watcher);
    coordinator.run(watch_path).await?;

    // 6) UI loop
    loop {
        let read_state = state.read().await;
        terminal.draw(|f| ui::draw_ui(f, &read_state))?;

        if event::poll(Duration::from_millis(100))? {
            match event::read()? {
                Event::Key(key) if key.code == KeyCode::Char('q') || key.code == KeyCode::Esc => {
                    break;
                }
                _ => {}
            }
        }
    }

    // 7) Cleanup
    disable_raw_mode()?;
    execute!(
        terminal.backend_mut(),
        LeaveAlternateScreen,
        DisableMouseCapture
    )?;

    Ok(())
}
```

    Emphasis: Notice how each piece is now in its own module, making changes or swaps of watchers or UI libraries much easier.

## Category-Theoretic Perspective

Conceptually, you can view each module as a functor mapping from its domain (domain logic, infrastructure, UI) to a new structure of behaviors or events. The watchers produce events, the coordinator interprets them (like a natural transformation from IO events → domain state changes), and the UI transforms the domain state into visual elements. Each transformation is composable and independently testable.

This decoupling aligns with the category-theoretic idea that each module is an object in a category, and the morphisms (functions or transformations) connect them without needing to break boundaries.
Conclusion

With this design:

    Components are pluggable: Choose any watcher that implements the FileWatcher trait.
    
    Unnecessary dependencies are removed from each layer.
    
    Cohesion is increased by keeping related logic together while ensuring decoupling between modules.    

    Key takeaway: Always aim for minimal, focused modules with clear responsibilities and explicit interactions, creating an architecture that scales elegantly and can be more easily maintained and extended.
