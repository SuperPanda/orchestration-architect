
Added a oa-monitor tool to show changes in orchestration-architect-prototypes.git and added to the `$HOME/.local/bin` and added it to path`

---

### **1. Pure Bash Implementation**

```bash
#!/bin/bash
# [«filesystem-cinema»]⇒
# Monitor directory changes using tree

# Configuration
SNAPSHOT_DIR="./fs_snapshots"
INTERVAL=1  # Seconds between snapshots
TARGET_DIR="."  # Directory to monitor

# Setup
mkdir -p "$SNAPSHOT_DIR"
rm -f "$SNAPSHOT_DIR"/*.tree

# Capture initial state
tree -a -h --noreport "$TARGET_DIR" > "$SNAPSHOT_DIR/start.tree"

# Run monitoring in background
(
    while true; do
        TIMESTAMP=$(date +%s)
        tree -a -h --noreport "$TARGET_DIR" > "$SNAPSHOT_DIR/${TIMESTAMP}.tree"
        sleep "$INTERVAL"
    done
) &

# Run Ansible (replace with your command)
ANSIBLE_PID=$!
ansible-playbook site.yml &
wait $ANSIBLE_PID

# Final snapshot
tree -a -h --noreport "$TARGET_DIR" > "$SNAPSHOT_DIR/end.tree"

# Generate diffs
generate_diffs() {
    PREV_FILE=""
    for FILE in "$SNAPSHOT_DIR"/*.tree; do
        if [ -n "$PREV_FILE" ]; then
            DIFF_NAME=$(basename "${PREV_FILE%.tree}-${FILE##*/}")
            diff -y --suppress-common-lines "$PREV_FILE" "$FILE" > "$SNAPSHOT_DIR/diff_${DIFF_NAME}"
        fi
        PREV_FILE="$FILE"
    done
}
generate_diffs

# Create ASCII cinema replay
create_replay() {
    FRAME=0
    for FILE in "$SNAPSHOT_DIR"/*.tree; do
        clear
        echo "=== FRAME $FRAME ==="
        cat "$FILE"
        sleep 0.5
        ((FRAME++))
    done
}
create_replay
```

### **2. Key Features**

1. **Snapshot Management**  
   - Stores timestamped `tree` outputs
   - Example filename: `1659321234.tree`
   - Maintains initial (`start.tree`) and final (`end.tree`) states

2. **Diff Analysis**  
   Generates side-by-side comparisons:
   ```bash
   diff -y --suppress-common-lines start.tree 1659321234.tree
   ```

3. **Visual Playback**  
   Simulates animation with:
   ```bash
   clear && cat <snapshot> && sleep 0.5
   ```

### **3. Rust Implementation (Better Performance)**

```rust
// [«filesystem-cinema-rs»]⇒
use std::{
    process::{Command, Stdio},
    time::Duration,
    fs::{self, File},
    io::{Write, BufReader},
    path::PathBuf,
};
use notify_debouncer_full::{Debouncer, new_debouncer, FileIdMap};
use std::sync::mpsc::channel;

struct TreeCinema {
    snapshot_dir: PathBuf,
    interval: Duration,
}

impl TreeCinema {
    fn new(snapshot_dir: impl Into<PathBuf>, interval_secs: u64) -> Self {
        let dir = snapshot_dir.into();
        fs::create_dir_all(&dir).unwrap();
        Self {
            snapshot_dir: dir,
            interval: Duration::from_secs(interval_secs),
        }
    }

    fn capture_tree(&self) -> std::io::Result<()> {
        let output = Command::new("tree")
            .args(["-a", "-h", "--noreport"])
            .output()?;
            
        let timestamp = chrono::Local::now().timestamp();
        let mut file = File::create(self.snapshot_dir.join(format!("{}.tree", timestamp)))?;
        file.write_all(&output.stdout)
    }

    fn monitor(&self) -> notify::Result<()> {
        let (tx, rx) = channel();
        let mut debouncer = new_debouncer(self.interval, None, tx)?;

        debouncer.watcher().watch(
            &std::env::current_dir()?,
            notify::RecursiveMode::Recursive
        )?;

        for events in rx {
            for event in events.unwrap() {
                if !event.paths.is_empty() {
                    self.capture_tree()?;
                }
            }
        }
        Ok(())
    }
}

fn main() -> std::io::Result<()> {
    let cinema = TreeCinema::new("fs_snapshots", 1);
    
    // Run monitoring thread
    let monitor_handle = std::thread::spawn(move || {
        cinema.monitor().unwrap();
    });

    // Run Ansible
    Command::new("ansible-playbook")
        .arg("site.yml")
        .status()?;

    // Generate report
    Command::new("bash")
        .arg("-c")
        .arg("diff -y --suppress-common-lines fs_snapshots/*.tree")
        .status()?;

    monitor_handle.join().unwrap();
    Ok(())
}
```

### **4. Usage Workflow**

1. **Run Monitoring**  
   ```bash
   # Bash version
   ./filesystem-cinema.sh

   # Rust version
   cargo run --release
   ```

2. **View Outputs**  
   - Snapshots:
     ```bash
     ls fs_snapshots/*.tree
     ```
   - Diffs:
     ```bash
     cat fs_snapshots/diff_*
     ```

3. **Create Visualization**  
   ```bash
   # ASCII cinema
   asciinema rec -c "bash -c 'for f in fs_snapshots/*.tree; do clear; cat $f; sleep 0.5; done'"
   ```

### **5. Study Guide**

**Core Concepts**  
1. **Filesystem Observation**  
   - `tree` for directory structure
   - `diff` for change detection
   - `inotify` (Linux) / `FSEvents` (macOS) for low-level monitoring

2. **Performance Considerations**  
   | Approach | Pros | Cons |
   |----------|------|------|
   | **Bash** | Simple, immediate | High CPU usage |
   | **Rust** | Efficient, debounced | Compilation needed |

**Experiments**  
1. **Change Detection**  
   ```bash
   # Create test files
   mkdir -p test_dir && cd test_dir
   touch {1..10}.txt

   # Run monitoring
   ../filesystem-cinema.sh &
   
   # Make changes
   rm 5.txt && echo "test" > 1.txt && mkdir sub

   # Observe snapshots
   ls ../fs_snapshots/*.tree
   ```

2. **Diff Analysis**  
   ```bash
   diff -y --color=always fs_snapshots/start.tree fs_snapshots/end.tree | less -R
   ```

**Advanced Features**  
1. **HTML Report**  
   ```bash
   tree -H . -o report.html
   sed -i 's/<hr>//g; s/<br>//g; s/<a[^>]*>//g; s/<\/a>//g' report.html
   ```

2. **Timeline Visualization**  
   ```bash
   convert -delay 100 -loop 0 fs_snapshots/*.tree.png fs_timeline.gif
   ```

This solution balances simplicity (bash) with efficiency (Rust). The bash version works immediately, while the Rust version offers better performance for large directories. Both generate diff-able snapshots that can be used for post-mortem analysis of filesystem changes during Ansible runs.
