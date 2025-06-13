# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is Ben's fork of ZaneyOS, a NixOS configuration that combines personal dotfiles with Tyler Kelley's ZaneyOS. It's a complete NixOS system configuration featuring Hyprland window manager, carefully configured applications, and a modular structure.

## Common Commands

### Building and Rebuilding
```bash
# Rebuild the system configuration
sudo nixos-rebuild switch --flake .#nora

# Alternative rebuild command (when NH_FLAKE env var is set)
flake-rebuild

# Generate hardware configuration
nixos-generate-config --show-hardware-config > hardware.nix
```

### Flake Management
```bash
# Update flake inputs
nix flake update

# Check flake
nix flake check

# Show flake outputs
nix flake show
```

### Development
```bash
# Enter development shell with specific packages
nix-shell -p git vim
nix-shell -p git curl

# Format Nix files (if nixpkgs-fmt is available)
nixpkgs-fmt *.nix
```

## Architecture

### Configuration Structure
- **`flake.nix`**: Main flake configuration defining inputs and outputs
- **`system.nix`**: System-level NixOS configuration
- **`home.nix`**: Home Manager configuration for user environment
- **`options.nix`**: Central configuration options (username, hostname, theme, etc.)
- **`hardware.nix`**: Hardware-specific configuration (generated)

### Modular Organization
- **`config/system/`**: System-level modules (GPU drivers, services, packages)
- **`config/home/`**: User-level modules (desktop applications, shell configuration)
- **`config/scripts/`**: Custom scripts as Nix packages
- **`config/pkgs/`**: Custom package definitions

### Key Options (options.nix)
- `username`, `hostname`: Basic system identity
- `cpuType`, `gpuType`: Hardware configuration ("amd", "intel", "nvidia", "intel-nvidia")
- `theShell`: Shell choice ("fish", "bash", "zsh", "nushell")
- `theKernel`: Kernel variant ("zen", "default", "latest", "lqx", "xanmod")
- `theme`: Color scheme (from nix-colors)
- `browser`: Default browser
- `terminal`: Default terminal

### Special Features
- **Impermanence**: Optional filesystem persistence configuration
- **Home Manager**: User environment management
- **Hyprland**: Wayland compositor with custom configuration
- **Custom Scripts**: Utility scripts packaged as Nix derivations
- **Modular GPU Support**: Separate modules for different GPU configurations

### Package Management
- System packages: `config/system/packages.nix`
- User packages: `config/home/packages.nix`
- Custom packages: `config/pkgs/`
- Custom overlays: `config/system/overlays/` (includes updated Claude Code 1.0.0)

## Important Notes

- Configuration is controlled via `options.nix` - edit this file to change system behavior
- The flake directory is set in options.nix as `flakeDir` (currently `/home/ben/flake2`)
- Default user password is "password" (hashed in system.nix)
- Hardware configuration should be regenerated when moving to new hardware
- The system uses nixos-unstable channel for latest packages