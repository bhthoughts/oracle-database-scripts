# Oracle Database Scripts

Scripts I use on a daily basis — some mine, some shared by the community.

Maintained by [Bruno Tarnowski](https://github.com/bhthoughts), Oracle ACE Associate.
Companion to the **BHThoughts** blog.

> [!WARNING]
> These scripts query and, in some cases, modify production databases. **Read a script before you run it.** Nothing here comes with any warranty — see [LICENSE](LICENSE).

## Categories

| Directory | What's in it |
|---|---|
| [ASM](ASM) | Automatic Storage Management: diskgroups, disks, rebalance |
| [Backup](Backup) | RMAN, backup validation, restore checks |
| [Data Guard](<Data Guard>) | Standby status, gaps, apply lag |
| [Database Jobs](<Database Jobs>) | Scheduler and DBMS_JOB |
| [Memory](Memory) | SGA, PGA, advisors |
| [Miscellaneous](Miscellaneous) | Everything that doesn't fit elsewhere |
| [Monitoring](Monitoring) | Health checks, alerts, general status |
| [MViews](MViews) | Materialized views and refresh |
| [Performance](Performance) | Waits, plans, AWR, top SQL |
| [Security](Security) | Users, privileges, auditing |
| [Sessions](Sessions) | Active sessions, blocking, locks |
| [Statistics](Statistics) | Optimizer, dictionary and system statistics |
| [Tablespaces, Datafile and Redos](<Tablespaces, Datafile and Redos>) | Space, datafiles, redo |

## Using a script

Every file is plain text, so you can grab one directly:

```bash
curl -O https://raw.githubusercontent.com/bhthoughts/oracle-database-scripts/main/Performance/<script>.sql
```

Or just open it on GitHub and copy.

## License and attribution

The scripts written by me are released under the [MIT License](LICENSE) — use them, change them, ship them, no permission needed. Keeping the copyright notice is the only condition.

**Some scripts came from the community.** Where I know the original source, it is credited in the file header. If you recognize something of yours that isn't credited — or that you'd rather not see here — [open an issue](https://github.com/bhthoughts/oracle-database-scripts/issues) and I'll attribute it properly or take it down.

## Script header convention

New scripts carry a short header so you can tell what a file does without reading it end to end:

```sql
-- Purpose:      One line on what this script answers.
-- Tested on:    19c, 21c
-- Author/Source: Bruno Tarnowski  (or the original author, when it isn't mine)
```

Older files may not have it yet — it's being added as they're touched.
