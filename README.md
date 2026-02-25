# Clone Repo Interactive (`cri`)

`cri` is a terminal CLI that lets you browse and clone GitHub repositories interactively using the GitHub CLI (`gh`).

It supports:

- Listing your repositories (default) or another user's/org's public repositories.
- Interactive selection with arrow keys.
- Always-on live search filtering (name, full name, and description).
- Table-style list with `Name`, `Updated`, and `Visibility` headers.
- Search term highlighting in the list.
- Sorting by most recently updated.
- Richer repository rows (visibility + relative update time + description).
- Prompting for destination folder name before cloning (default: repo name).

## Requirements

- Python 3.10+ (for modern type hints used in the script).
- GitHub CLI (`gh`) installed and available in `PATH`.
- Authenticated GitHub CLI session for your own/private repos:
  - `gh auth login`

## Files

- `cri` - executable script (run directly as command in this folder).
- `cri.py` - Python source copy of the same CLI logic.

## Run Locally

From this project directory:

```bash
./cri
```

List repositories from a specific owner (user or org):

```bash
./cri <owner>
```

## Optional: "Install" as a Global Command

This project does not need compilation. It is a Python script.

If you want to run `cri` from anywhere:

```bash
mkdir -p ~/.local/bin
cp ./cri ~/.local/bin/cri
chmod +x ~/.local/bin/cri
```

Make sure `~/.local/bin` is in your `PATH` (for zsh, add this to `~/.zshrc` if needed):

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Then reload shell config:

```bash
source ~/.zshrc
```

Now run:

```bash
cri
```

## How to Use

1. Start `cri` (or `cri <owner>`).
2. Navigate repository list:
   - Up/Down arrows
   - PageUp/PageDown for larger jumps
3. Type to search immediately (no separate search mode).
   - `Backspace` removes characters.
   - `Ctrl+U` clears the search query.
   - Press `/` to quickly clear and start a new search.
4. Use `Left`/`Right` to horizontally scroll long descriptions.
5. Press `Enter` on a selected repo.
6. Enter destination folder name (or press Enter for default repo name).
7. `cri` runs `gh repo clone <owner/repo> <folder>`.

## Notes

- If you pass another owner, only public repositories are shown.
- If destination folder already exists, cloning is aborted with an error.
- If no repositories are found, the tool exits cleanly with a message.

## Troubleshooting

- `Error: 'gh' command not found`
  - Install GitHub CLI and verify with `gh --version`.
- Authentication issues or missing private repos
  - Run `gh auth status`, then `gh auth login` if needed.
- Empty results
  - Check owner name and network access.
