# NixOS Config

Personal NixOS + Home Manager configuration using Flakes for host **tbook** (x86_64-linux).

## Rebuild

```sh
sudo nixos-rebuild switch --flake ~/nixos-config#tbook --impure
```

Updates both NixOS system config and Home Manager (user `gfors`) in one command.

## Directory Structure

```
nixos-config/
├── flake.nix                              # Entrypoint: nixpkgs 26.05 + nixpkgs-unstable + home-manager + spicetify-nix
├── hosts/
│   └── tbook/                             # Host profile (x86_64-linux)
│       ├── default.nix                    #   NixOS module imports (core, hardware, desktop, services)
│       └── hardware-configuration.nix     #   Auto-generated — do not edit
│
├── modules/                               # System-level NixOS modules
│   ├── core/                              #   Boot, networking, nix settings, users
│   ├── hardware/                          #   Audio, Bluetooth, Intel GPU, zram
│   ├── desktop/                           #   Hyprland (system-level), KDE Plasma 6 (unused)
│   └── services/                          #   Docker, Flatpak, MySQL, power profiles, SSH
│
└── home/                                  # Home Manager (user: gfors)
    └── profiles/
        └── tbook.nix                      # Entrypoint → imports home/shared/*
            └── shared/                    #   Apps, shell, terminal, dev tools, CLI tools, editor
```

## Structure Overview

| Layer | Path | Description |
|---|---|---|
| **Flake** | `flake.nix` | Inputs (nixpkgs, nixpkgs-unstable, home-manager, spicetify-nix) → `nixosConfigurations.tbook` |
| **System (NixOS)** | `hosts/tbook/` → imports `modules/*` | Boot, network, hardware, desktop, services |
| **User (home-manager)** | `home/profiles/tbook.nix` → imports `home/shared/*` | Apps, shell, hyprland user config, dev tools, CLI tools, editor |

## Key Details

- **User**: `gfors` (shell: zsh, home: `/home/gfors`)
- **Boot**: systemd-boot with EFI
- **Desktop**: Hyprland via SDDM (Wayland)
- **Audio**: PipeWire
- **GPU**: Intel (`intel-media-driver` + `vpl-gpu-rt`)
- **Firewall**: enabled, ports 1714–1764 (UDP/TCP) open for KDE Connect
- **Nix**: Flakes + nix-command experimental features, auto GC (>5d), unfree packages allowed
- **Time zone**: Asia/Jakarta

## Included Software

**Applications**: Spotify (via spicetify-nix), Vesktop, Firefox, Chromium, Tor Browser, MPV, OBS Studio, GIMP

**Shell & Terminal**: Zsh + p10k, Tmux, Kitty

**CLI Tools**: opencode, yazi, FFmpeg, ngrok, Posting

**Dev Tools**: Git, Go, Node.js, PHP, Python, GCC, Direnv

**Services**: Docker, Flatpak, MySQL/MariaDB, SSH agent

## Quirks & Gotchas

- `hardware-configuration.nix` is auto-generated on hardware changes — do not hand-edit.
- Home Manager is used as a NixOS module (`useGlobalPkgs = true`, `useUserPackages = true`).
- `spicetify-nix` is a flake input, passed via `extraSpecialArgs`.
- `home/profiles/tbook.nix` is the Home Manager entrypoint (not `home/default.nix` — that file does not exist).
- `modules/desktop/kde-plasma.nix` and `home/shared/apps/vlc.nix` are dead code — files exist but are not imported anywhere.
- Zsh sources `~/.p10k.zsh` from an external `dotfiles` repo.
- SSH agent auto-starts; GitHub identity uses `~/.ssh/id_ed25519_github` with `IdentitiesOnly yes`.
- Both `home.stateVersion` and `system.stateVersion` are `"26.05"` — bump only on first install of a new release.
