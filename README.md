[![#StandWithUkraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://vshymanskyy.github.io/StandWithUkraine)

## Installation

Clone the repo into the home directory:

```
cd
mkdir -p repos/abc-valera
cd repos/abc-valera
nix-shell -p git
git clone https://github.com/abc-valera/config-nixos.git
```

**If using NixOS**, copy the hardware configuration from `/etc/nixos` into `src/cmd/nixos/hardware/<machine-name>` if it doesn't already exist. The `/etc/nixos` directory can then be removed entirely:

```
sudo rm -r /etc/nixos
```

Then apply the configuration (replace `wsl` or `elitebook25` with the target host):

```
# WSL
sudo nixos-rebuild switch --flake ~/repos/abc-valera/config-nixos#wsl

# Bare metal
sudo nixos-rebuild switch --flake ~/repos/abc-valera/config-nixos#elitebook25
```

On the first run, Nix will create a `flake.lock` file pinning all input versions.

## Updating inputs

To update all flake inputs to their latest versions and rebuild:

```
sudo nix flake update --flake ~/repos/abc-valera/config-nixos
sudo nixos-rebuild switch --flake ~/repos/abc-valera/config-nixos#<host>
```

To update a single input (e.g. only `nixpkgs-unstable`):

```
sudo nix flake update nixpkgs-unstable --flake ~/repos/abc-valera/config-nixos
sudo nixos-rebuild switch --flake ~/repos/abc-valera/config-nixos#<host>
```

## Updating to a next major system version

Edit the versions for the inputs in `flake.nix` to match the new release (e.g. bump `26.05` → `26.11`). Then run:

```
sudo nix flake update --flake ~/repos/abc-valera/config-nixos
sudo nixos-rebuild switch --flake ~/repos/abc-valera/config-nixos#<host>
```

## Other useful commands

SSH keys can be generated via:

```
ssh-keygen -t ed25519 -C "valeriy.tymofieiev@gmail.com" -f /home/abc-valera/.ssh/id_ed_personal
```

To manually run garbage collector:

```
sudo nix-collect-garbage -d
```

To cleanup docker data:

```
docker system prune -a --volumes -f
docker builder prune -a -f
```

To check the disk usage:

```
df -h
```

## Shell Shortcuts

![diagram](./.meta/images/shell_shortcuts.png)

**Moving:**

- `ctrl-a` moves the cursor to the beginning of the line.
- `ctrl-e` moves to the end of line. If the cursor is already at the end of the line, and an autosuggestion is available, accepts the autosuggestion.

- `alt-b` and `alt-f` move the cursor one word left or right, or accept one word of the autosuggestion. If the command line is empty, moves forward/backward in the directory history instead.

- `ctrl-b` and `ctrl-f` move the cursor one character left or right or accept the autosuggestion

**Completion:**

- `tab` / `ctrl-i` completes the current token
- `shift-tab` completes the current token and starts the pager’s search mode
- `alt-f` accepts the first argument/word of the autosuggestion
- `ctrl-e` accepts the full autosuggestion
- `alt-b` / `alt-f` accept one word of the autosuggestion

**Editing:**

- `ctrl-u` removes contents from the beginning of line to the cursor (moving it to the kill ring).
- `ctrl-k` deletes from the cursor to the end of line (moving it to the kill ring).

- `ctrl-w` removes the previous path component (everything up to the previous “/”, “:” or “@”) (moving it to the kill ring).
- `alt-d` moves the next word to the kill ring.

- `ctrl-d` deletes one character to the right of the cursor. If the command line is empty, ctrl-d will exit fish.
- `ctrl-h` removes one character forwards or backwards respectively.

- `alt-s` Prepends sudo to the current commandline. If the commandline is empty, prepend sudo to the last commandline.

- `alt-enter` inserts a newline at the cursor position. This is useful to add a line to a commandline that’s already complete.

- `ctrl-shift-z` reverts the most recent undo.
- `ctrl-z` undo the most recent edit of the line.

- `alt-p` adds the string `&| less;` to the end of the job under the cursor. The result is that the output of the command will be paged.

**Clipboard:**

- `ctrl-v` inserts the clipboard contents
- `ctrl-x` copies the current buffer to the system’s clipboard

**History:**

- `ctrl-r` opens the history in a pager. This will show history entries matching the search, a few at a time. Pressing `ctrl-r` again will search older entries, pressing `ctrl-s` (that otherwise toggles pager search) will go to newer entries. The search bar will always be selected.

- `ctrl-p` and `ctrl-n` search the command history for the previous/next command containing the string that was specified on the commandline before the search was started. If the commandline was empty when the search started, all commands match.

- `shift-delete` removes the current history item or autosuggestion from the command history.

**Current folder listing:**

- `alt-l` lists the contents of the current directory, unless the cursor is over a directory argument, in which case the contents of that directory will be listed.

- `alt-d` lists the directory history if the command line is empty.

**Execute:**

- `enter` executes the current commandline or inserts a newline if it’s not complete yet (e.g. a `)` or `end` is missing).
- `ctrl-c` interrupts/kills whatever is running (SIGINT).

**Editor:**

- `alt-e` / `alt-v` edits the current command line in an external editor.
- `alt-o` opens the file at the cursor in a pager. If the cursor is in command position and the command is a script, it will instead open that script in your editor.

**Other:**

- `alt-w` prints a short description of the command under the cursor.
- `alt-h` shows the manual page for the current command, if one exists.

- `ctrl-l` pushes any text above the prompt to the terminal’s scrollback, then clears and repaints the screen.

## Resources

https://nix-community.github.io/NixOS-WSL
