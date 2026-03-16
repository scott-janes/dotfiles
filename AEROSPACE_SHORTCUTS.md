# Aerospace Shortcuts & Workflow Reference

This document explains all keyboard shortcuts, workspace logic, automations, and layout settings from your custom `aerospace.toml` config for the [Aerospace window manager](https://github.com/aerospacewm/aerospace) on macOS.

---

## Visual Diagram: Controls & Layouts

```
FOCUS / MOVE WINDOW (vim-style):
    [ctrl+shift+cmd] + h/j/k/l   —  Focus Left/Down/Up/Right
        ┌───────┬───────┬───────┐
        │   K   │       │       │
        ├───┬───┴───────┴───┬──┤
        │ H │       J       │ L│
        └───┴───────────────┴──┘

    [ctrl+shift+cmd+alt] + h/j/k/l  — Move Active Window

WORKSPACE CLUSTER:   (Y/U/I/O/P)
    [ctrl+shift+cmd+alt] + Y/U/I/O/P — Switch Workspace
    [ctrl+shift+cmd] + Y/U/I/O/P     — Move window to Workspace

 ┌─Y─┬─U─┬─I─┬─O─┬─P─┐
 │   │   │   │   │   │
 └───┴───┴───┴───┴───┘

LAYOUT MODES:
  [ctrl+shift+cmd] + r    — Rotate layout (Horizontal / Vertical)
  [ctrl+shift+cmd] + s    — Stacked layout
  [ctrl+shift+cmd] + a    — Attach/Tiling
  [ctrl+shift+cmd] + d    — Detach/Floating

  Tiles:        Stacked:        Horizontal/Vertical:   Floating:
 [ ] [ ]         [ ]           [ ] [ ]                 [ ] [ ]
 [ ] [ ]         [ ]           [ ] [ ]                (windows
                                    |                   float)
```

---

## Keyboard Shortcuts

| Shortcut                                   | Action(s)                                | Description                               |
|---------------------------------------------|------------------------------------------|-------------------------------------------|
| ctrl-shift-cmd-f                           | fullscreen                               | Toggle fullscreen for focused window       |
| ctrl-shift-cmd-r                           | layout horizontal vertical               | Switch between horizontal/vertical layouts ([R]otate) |
| ctrl-shift-cmd-s                           | layout tiles accordion                   | Switch to accordion/stacked tile layout ([S]tacked)    |
| ctrl-shift-cmd-a                           | layout tiling                            | Switch to tiling layout ([A]ttach)        |
| ctrl-shift-cmd-d                           | layout floating                          | Switch window to floating ([D]etach)      |
| ctrl-shift-cmd-h/j/k/l                     | focus {left,down,up,right}, mouse center | Focus window in direction and recenter mouse |
| ctrl-shift-cmd-alt-h/j/k/l                 | move {left,down,up,right}                | Move window in direction                  |
| ctrl-shift-cmd-left/down/up/right          | join-with {left,down,up,right}           | Join window with neighbor in direction    |
| ctrl-shift-cmd-g                           | flatten-workspace-tree ([G]round)        | Flatten workspace window tree             |
| ctrl-shift-cmd-0                           | balance-sizes                            | Balance window sizes in workspace         |
| ctrl-shift-cmd-minus/equal                 | resize height (-100/+100)                | Decrease/Increase window height           |
| ctrl-shift-cmd-comma/period                | resize width (-100/+100)                 | Decrease/Increase window width            |
| ctrl-shift-cmd-alt-{y,u,i,o,p,quote,semicolon,backslash} | workspace {Y,U,I,O,P,qt,sc,bs}          | Switch to named workspace                 |
| ctrl-shift-cmd-{y,u,i,o,p,quote,semicolon,backslash}     | move-node-to-workspace {Y,U,I,O,P,qt,sc,bs} | Move current window to named workspace    |
| ctrl-shift-cmd-alt-6                       | workspace-back-and-forth                 | Toggle between two most recent workspaces |
| ctrl-shift-cmd-m                           | focus-monitor next + mouse center        | Focus next monitor and recenter mouse     |
| ctrl-shift-cmd-alt-m                       | move-node-to-monitor next                | Move window to next monitor               |
| ctrl-shift-cmd-alt-w                       | move-workspace-to-monitor next           | Move workspace to next monitor            |
| alt-tab                                    | workspace-back-and-forth                 | Toggle between two most recent workspaces |

---

## Workspaces & Monitor Assignments

| Workspace | Shortcut Key(s)          | Default Monitor(s)                | Typical Use/App Mapping           |
|-----------|-------------------------|-----------------------------------|-----------------------------------|
| Y         | alt/cmd+Y               | main                              | Custom                            |
| U         | alt/cmd+U               | main                              | IntelliJ auto-assigned            |
| I         | alt/cmd+I               | main                              | Custom                            |
| O         | alt/cmd+O               | main                              | Custom                            |
| P         | alt/cmd+P               | main                              | Spotify auto-assigned             |
| qt        | alt/cmd+Quote           | LG ULTRAWIDE, secondary, main     | Custom                            |
| sc        | alt/cmd+Semicolon       | LG ULTRAWIDE, secondary, main     | Custom                            |
| bs        | alt/cmd+Backslash       | LG ULTRAWIDE, secondary, main     | Outlook, Slack, Discord auto-assigned |

**Note:** Use `ctrl-shift-cmd-alt-{key}` for workspace switch, `ctrl-shift-cmd-{key}` for moving nodes/windows.

---

## Application Automations

Certain apps are automatically routed:

- **Outlook**: moved to workspace `bs`
- **Slack**: moved to workspace `bs`
- **Discord**: moved to workspace `bs`
- **Spotify**: moved to workspace `P`
- **IntelliJ**: moved to workspace `U`
- **Zoom**: set layout floating

---

## Layout & General Settings

- **Default layout:** tiles
- **Default orientation:** auto
- **Gaps:** inner horizontal = 15, vertical = 15; outer left/right = 20, top = 45, bottom = 20
- **Mouse:** always centered on focus/monitor changes
- **Preset:** key mapping is `qwerty`
- **Hooks:** external triggers to Sketchybar on workspace/focus changes

---

## Visual: Workspace–Monitor Mapping

```
Workspaces      Monitors
=========================
Y, U, I, O, P  → [main]
qt, sc, bs     → [LG ULTRAWIDE, secondary, main]
```

> Apps are sent to their designated workspace automatically.

---

## Quick Actions

- **Move window to workspace:** `ctrl-shift-cmd-{key}`
- **Switch to workspace:** `ctrl-shift-cmd-alt-{key}`
- **Move to next monitor:** `ctrl-shift-cmd-alt-m`
- **Focus next monitor:** `ctrl-shift-cmd-m`

---

For full Aerospace documentation, see [github.com/aerospacewm/aerospace](https://github.com/aerospacewm/aerospace).

## Customization

You can adjust key bindings, workspace names, monitor assignments, and automations in your `aerospace.toml` for any workflow.
