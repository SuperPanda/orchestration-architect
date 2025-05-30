# Setup multi-mdbook environment LITERATE SPECIFICATION 

**TODO** Format process like documents process like <oa://docs/scratchpad/01-setup-mdbook-preprocessors.html>

**Related Resources** <oa://notes/2025-05-29.html>

**This imported from personal notes**

> **Note** This is the non auto reloading version. Later, need to add hot loading

> **Note** If init was not done, then the cleanup is not required. Since `mdbook`
> is installed in the `$HOME/.cargo/bin`

## Setting up a notebook

**Need to incorporate** <oa://docs/scratchpad/01-setup-mdbook-preprocessors.html>

### Create `book.html`

```toml
[book]
authors = ["Andrew Briscoe"]
language = "en"
src = "."
title = "Development Journal"
```


### Configure reverse proxies

**THIS WILL NEED TO BE DISECTED**

**WILL NEED TO SETUP CONFIGURATION <oa://config:documents> link not yet working**


```conf «tiny config»
User tinyproxy
Group tinyproxy
Port 8888
Listen 127.0.0.1
Timeout 600
DefaultErrorFile "/usr/share/tinyproxy/default.html"
StatFile "/usr/share/tinyproxy/stats.html"
Syslog On
LogLevel Info
PidFile "./tinyproxy.pid"
MaxClients 100
Allow 127.0.0.1
Allow ::1
ViaProxyName "tinyproxy"
ReversePath "/docs/" "http://localhost:3000/"
ReversePath "/notes/" "http://localhost:3001/"
ReverseOnly No
# BindSame Yes
ReverseMagic Yes
ReverseBaseURL "http://localhost:8888"
```

```xdg
[Desktop Entry]
Type=Application
Name=OA Scheme Handler
Exec=sh -c 'uri=$(echo %u | sed "s/oa:\\/\\//http:\\/\\/localhost:8888\\//"); xdg-open "$uri"'
MimeType=x-scheme-handler/oa;
NoDisplay=true
```

## Architecture 


```d2
direction: right
fs -> nvim -> http
```

## Literate Spec

**Needs to make something like: <oa://spec/literate-spec>**

```lua
vim.api.nvim_command('w !cat | sed -nE \'/^```conf/,/^```/p\' | tail -n+2 | head -n-1 > ./test-tinyproxy.conf')
vim.api.nvim_command('w !cat | sed -nE \'/^```xdg/,/^```/p\' | tail -n+2 | head -n-1 > $HOME/.local/share/applications/oa-handler.desktop')
vim.api.nvim_command('w !cat | sed -nE \'/^```update/,/^```/p\' | tail -n+2 | head -n-1 | cat | bash')
```

```update
# Register the desktop entry as default handler
xdg-mime default oa-handler.desktop x-scheme-handler/oa

# Update desktop database
update-desktop-database ~/.local/share/applications

```


> **Note** Auto-apply changes using `echo "FILE TO WATCH" | entr -r <SOME COMMAND TO TRIGGER>`

```fish «watch and serve»
echo "./test-tinyproxy.conf" | entr -r tinyproxy -d -c ./test-tinyproxy.conf
```

> **Capabilities** Allows linking between documents like [<oa://docs/>] (to a non-hotloading verison)

> **Capabilities** Allows cross book referencing see [<oa://notes/>]

> **Requires** Standardised configurations and to implement Literate Specification.

> **Issues** No websocket liveloading yet.
> 
> `Firefox can’t establish a connection to the server at ws://localhost:8888/__livereload.`
