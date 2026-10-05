## Scripts!

A personal collection of everyday shell and Go scripts for working on Groundfloor's mobile app and backend dev environment — tossed out with the bath water when Fig got acquired by AWS.

### Gum
Most of the shell scripts use [Gum](https://github.com/charmbracelet/gum) for interactive terminal prompts.
```
brew install gum
```

### Setup
Run `./setup.sh` to check for Gum and add this directory's path (`SCRIPTS_DIR`) to your `.zshrc`.

### Aliases
`alias.sh` defines the shortcuts below. Source it (or let `setup.sh` wire it up) to use them:

| Alias | Script | What it does |
| --- | --- | --- |
| `ahm` | `src/ad-hoc-mobile.sh` | Builds and uploads ad-hoc iOS/Android builds via Fastlane, prints the install links and branch/PR info |
| `cmb` | `src/clean-mobile-branch.sh` | Cleans the mobile repo's build state: wipes `node_modules`, reinstalls with yarn, and reinstalls CocoaPods |
| `gpr` | `src/create-pr.sh` | Pushes the current branch upstream with `-u` so you can open a PR |
| `smk` | `src/smokes.sh` | Logs into AWS SSO if needed, then creates a smoke-test user (investing/lending) in a target k8s namespace via `k8s-console` |
| `gst` | `src/stash-message.sh` | `git stash` with a prompted, descriptive message |
| `gcc` | `conventional-commit` (Go binary) | Interactive form (type, PR number, message, breaking change) that builds a `[PR] type!: message` commit and runs `git commit` |

### Go CLI: conventional-commit
Source lives in `cmd/conventional-commit/main.go` (module `gf-scripts`), built with [Charm's `huh`](https://github.com/charmbracelet/huh). It infers the PR/ticket number from the current branch name, walks you through a form for commit type, message, and breaking-change flag, and commits the result in conventional-commit format. Rebuild with:
```
go build -o conventional-commit ./cmd/conventional-commit
```

### Other bits
- `main.go` — a small Bubble Tea/Bubbles list demo used for experimenting with TUI components; not wired into any alias.
- `ad-hoc-mobile` — compiled binary checked in alongside `ad-hoc-mobile.sh`.
