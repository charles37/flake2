# Claude Code Update Guide for NixOS Overlay

This guide documents the process for updating Claude Code in the NixOS overlay when a new version is released.

## Overview

Claude Code is packaged as an npm package that needs special handling in Nix because:
- It has no actual dependencies (only optional dependencies)
- It doesn't include a package-lock.json in the npm package
- It requires custom installation steps

## Step-by-Step Update Process

### 1. Update the Version Number

Edit `/home/ben/flake2/config/system/overlays/claude-code-overlay.nix` and update the version:

```nix
version = "1.0.53";  # Change this to the new version
```

### 2. Clear the Hash Values

Set both hash values to empty strings to trigger build failures that will give you the correct hashes:

```nix
hash = "";
npmDepsHash = "";
```

### 3. Build to Get the Source Hash

Run the build command:

```bash
nix build .#nixosConfigurations.nora.pkgs.claude-code --no-link 2>&1 | tail -50
```

Look for the hash mismatch error. It will show:
```
error: hash mismatch in fixed-output derivation...
  specified: sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
  got:    sha256-opFOUa/YtJDwhkD5dN+PL74z5NqkrRCVrU2RQu6xmEc=
```

Update the `hash` field with the "got" value.

### 4. Update the package-lock.json

The Claude Code npm package doesn't include a package-lock.json, so we maintain a minimal one. Update `/home/ben/flake2/config/system/overlays/claude-code-package-lock.json` with the new version:

```json
{
  "name": "@anthropic-ai/claude-code",
  "version": "1.0.53",  // Update this version
  "lockfileVersion": 3,
  "requires": true,
  "packages": {
    "": {
      "name": "@anthropic-ai/claude-code",
      "version": "1.0.53",  // Update this version too
      "license": "SEE LICENSE IN README.md",
      "bin": {
        "claude": "cli.js"
      },
      "engines": {
        "node": ">=18.0.0"
      },
      "optionalDependencies": {
        "@img/sharp-darwin-arm64": "^0.33.5",
        "@img/sharp-darwin-x64": "^0.33.5",
        "@img/sharp-linux-arm": "^0.33.5",
        "@img/sharp-linux-arm64": "^0.33.5",
        "@img/sharp-linux-x64": "^0.33.5",
        "@img/sharp-win32-x64": "^0.33.5"
      }
    }
  }
}
```

### 5. Build to Get the npmDepsHash

Build again with the updated source hash:

```bash
nix build .#nixosConfigurations.nora.pkgs.claude-code --no-link 2>&1 | tail -50
```

Look for another hash mismatch error for npm-deps:
```
error: hash mismatch in fixed-output derivation...npm-deps.drv':
  specified: sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
  got:    sha256-h17YzjOyb/Lb7NGAxpbhDN3GKI5Qpir2n7sI2NChjnM=
```

Update the `npmDepsHash` field with the "got" value.

### 6. Verify the Build

Run the build one more time to ensure it completes successfully:

```bash
nix build .#nixosConfigurations.nora.pkgs.claude-code --no-link
```

### 7. Test and Deploy

Test the new version:

```bash
# Test the built package
/nix/store/.../bin/claude --version

# Or rebuild your system
sudo nixos-rebuild switch --flake .#nora
```

## Important Notes

### The Overlay Structure

The overlay includes these key components:

1. **forceEmptyCache = true** - Required because Claude Code has no real dependencies
2. **Custom installPhase** - Manually copies files and creates wrapper since npm install doesn't do much
3. **makeWrapper** - Properly sets up the Node.js executable with the CLI script
4. **postInstall** - Wraps the binary to disable auto-updates via DISABLE_AUTOUPDATER

### Common Issues

1. **Missing package-lock.json**: If you get errors about missing lockfile, ensure the package-lock.json is properly formatted and has the correct version numbers.

2. **Hash mismatches**: Always use the exact hash provided in the error message, including the sha256- prefix.

3. **Build failures**: If the build fails after updating hashes, check the nix log command provided in the error message for details.

### Quick Reference

Files to update:
- `/home/ben/flake2/config/system/overlays/claude-code-overlay.nix` - version and hashes
- `/home/ben/flake2/config/system/overlays/claude-code-package-lock.json` - version numbers

Commands to run:
```bash
# Build and get hashes
nix build .#nixosConfigurations.nora.pkgs.claude-code --no-link 2>&1 | tail -50

# Apply to system
sudo nixos-rebuild switch --flake .#nora
```