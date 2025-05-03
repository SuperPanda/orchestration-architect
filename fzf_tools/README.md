# FZF Tools

The `fzf tools` provides the capability to *find and filter input* and
*execute preview commands*.

## Development Tutorial

**How to preview file contents in a directory**

The following command list the contents of a file system directory
(using the `ls` command), which is piped to the `fzf-tmux` program.
The `fzf-tmux` program provides a terminal user interface (also known as a *tui* ) which
displays a preview of the contents of filtered files.

```bash
SELECTED_FILE="$(ls | fzf-tmux -p "80%,80%" -- --preview='bat {1}')"
echo "$SELECTED_FILE"
```

> *Tip* Ensure the programs in commands are on your system for them to work.

**Find files with `fd`**

The `fzf-tmux` command is structured as:

    fzf-tmux «layout options» -- «fzf options»

```literate 
«default music path»
«filter and select»
```

Find `mp3` and `flac` files in the default Music directory
as per *XDG specifications*:


```sh «fzf-music-finder
MUSIC_PATH="${1:-$HOME/Music}"
SELECTED_SONGS=$(fd --type file --glob "**.{mp3,flac}" "$MUSIC_PATH" | tac | fzf-tmux 'ffplay -autoexit -nodisp {}' -p "100%,25%" -x 0 -y 0) 
echo "$SELECTED_SONGS"
```

If the above was in `$HOME/music-finder` (after `chmod +x`),
then we can capture the selected song with:

```fish 
set SELECTED_SONG "$($HOME/music-finder)"
```

> **Tip** Run `file "$SELECTED_SONG` to see metadata. 
>
> An output using the example:
>
>   FLAC audio bitstream data, 16 bit, stereo, 96 kHz, 1144832 samples

**Example**

Select songs and keep selected songs in a variable.

```sh
SELECTED_SONGS=$(fd --type file --glob "**.{mp3,flac}" "$HOME/Music" | tac | fzf-tmux --preview 'ffplay -autoexit -nodisp {}' -p "100%,25%" -x 0 -y 0)
```

> *Neovim Tip* Execute commands.
> Use `V:w !bash` to visually select line and execute it.



**Usage Instructions for fzf-tmux**

> *Tip* Run `fzf --man` or `man fzf` to read the man page.

The command `fzf-tmux --help` returns:

```
usage: fzf-tmux [LAYOUT OPTIONS] [--] [FZF OPTIONS]

  LAYOUT OPTIONS:
    (default layout: -d 50%)

    Popup window (requires tmux 3.2 or above):
      -p [WIDTH[%][,HEIGHT[%]]]  (default: 50%)
      -w WIDTH[%]
      -h HEIGHT[%]
      -x COL
      -y ROW

    Split pane:
      -u [HEIGHT[%]]             Split above (up)
      -d [HEIGHT[%]]             Split below (down)
      -l [WIDTH[%]]              Split left
      -r [WIDTH[%]]              Split right

```





