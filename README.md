# dotfiles

My personal Linux desktop and development environment configuration.

## Features

* Hyprland Wayland compositor
* Quickshell-based desktop widgets
* Neovim development setup
* QuickShell bar
* Terminal-focused workflow
* C++ and Python development environment
* Fast and lightweight configuration
* Arch Linux friendly

## Screenshots (Waybar)

![Desktop](https://raw.githubusercontent.com/AzeTurk810/dotfiles/master/ScreenShotsdot/2026-06-29-230254_hyprshot.png)
Desktop

![Media](https://raw.githubusercontent.com/AzeTurk810/dotfiles/master/ScreenShotsdot/2026-06-29-230346_hyprshot.png)
Media player/selector

![Desktop](https://raw.githubusercontent.com/AzeTurk810/dotfiles/master/ScreenShotsdot/2026-06-29-230600_hyprshot.png)

Wallpaper selector

## Screenshots (QuickShell)

![Desktop](https://raw.githubusercontent.com/AzeTurk810/dotfiles/master/ScreenShotsdot/2026-06-17-143535_hyprshot.png)

![Neovim Dashboard](https://raw.githubusercontent.com/AzeTurk810/dotfiles/master/ScreenShotsdot/2026-06-17-143730_hyprshot.png)

## Components

| Component     | Program        |
| ------------- | -------------- |
| WM            | Hyprland       |
| Shell         | Bash / Zsh     |
| Editor        | Neovim         |
| Terminal      | Kitty          |
| Widgets       | Quickshell     |
| Launcher      | Rofi           |
| Notifications | Mako           |
| Browser       | Firefox / Zen  |

## Installation

Clone the repository:

```bash
git clone https://github.com/AzeTurk810/dotfiles.git
cd dotfiles
```

Backup your current configuration:

```bash
mkdir -p ~/dotfiles-backup
cp -r ~/.config ~/dotfiles-backup/
```

Install the configurations you need manually.
You must change monitors.lua

## Neovim

This repository contains my Neovim configuration focused on:

* Competitive programming
* C++
* Python
* LSP support
* Autocompletion
* Treesitter

## Hyprland

Features include:

* Custom keybinds
* Workspace management
* Animation tweaks
* Development-oriented workflow

## Quickshell

Custom widgets and desktop components written using Quickshell.

## Goals

* Fast startup
* Low resource usage(Except Nvim)
* Comfortable programming workflow
* Easy customization

## Notes

These are personal dotfiles. Some paths, monitor settings, and hardware-specific options may need to be adjusted for your system.

## TODO
* Do quickshell App launcher
* Add CheatSheet
* Design Beatifull Quickshell Bar

## License

MIT License
