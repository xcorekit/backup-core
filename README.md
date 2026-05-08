# backup-core

`backupx` — personal backup orchestrator. Sync local directories to cloud via rclone. Archive-first: nothing is ever silently deleted.

## Install

```bash
git clone git@github.com:xcorekit/backup-core.git
cd backup-core && ./install.sh
```

## Config

Edit `~/.config/sconl/backups.conf` to define your backup jobs.

## Usage

```bash
backupx              # interactive job menu
backupx --list       # show all jobs
backupx --dry-run    # preview without touching files
backupx --init       # first run: pull remote → local
```
