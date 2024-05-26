
# Tools and Utilities
## Terminal AI Usage
### Step 1. Load Terminal AI Shell Environment
Load a shell to configure the environment variables used by Terminal AI:
```
source scripts/activate-terminal-ai
```

Deactivate environment variables with:
```
source scripts/deactivate-terminal-ai
```
Follow any instructions to setup OPENAI
### Step 2. Converse with Terminal AI
#### One-shot Message
Use **```terminal-ai <USER_MESSAGE>```** to send a message. Requires ```--env-file=<path_to_openai_enviornment_file>``` if not loaded with ```activate-terminal-ai```
#### Conversation with a Goldfish
Use **```terminal-ai-interact-goldfish```** to keep sending one-shot messages.
Used to run a loop to send low-cost messages to GPT 4-omni.
####  Contextual Conversation (WIP)
The goal is to manage conversations in an efficient manner. Experiments ongoing.
#### Copy User or GPT Response to Clipboard
```

```
#### Monitor Conversations
Run (replace path if using custom --output-dir or --outpute-path):
```
tail -f $HOME/artifacts/logs/terminal-ai/transcripts/<date in YYYY-MM-DD>.md

```
Tip: Start a Terminal AI Shell Environment in a Terminal Multiplexer like tmux and follow along

