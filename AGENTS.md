# NixOS Config (@gfors)

## Rebuild

```sh
sudo nixos-rebuild switch --flake ~/nixos-config#tbook --impure
```

Updates both NixOS system config and home-manager (user `gfors`) in one command.

## Directory Tree

```
nixos-config/
├── AGENTS.md                              # Panduan konfigurasi & catatan penting
├── flake.nix                              # Entrypoint: nixpkgs 26.05 + nixpkgs-unstable + home-manager + spicetify-nix
├── flake.lock                             # Lockfile dependencies
├── .gitmodules                            # (kosong)
│
├── hosts/
│   └── tbook/                             # Host profile: tbook (x86_64-linux)
│       ├── default.nix                    #   Impor modul NixOS (core, hardware, desktop, services)
│       └── hardware-configuration.nix     #   Auto-generated — jangan diedit
│
├── modules/                               # System-level NixOS modules
│   ├── core/
│   │   ├── boot.nix                       #   systemd-boot + EFI + resume/hibernate
│   │   ├── networking.nix                 #   Firewall, KDE Connect ports (1714-1764), NetworkManager
│   │   ├── nix-settings.nix               #   Flakes, nix-command, GC auto (5d), unfree
│   │   ├── nix-ld.nix                     #   nix-ld — jalankan binary ELF non-NixOS
│   │   └── users.nix                      #   User: gfors
│   │
│   ├── hardware/
│   │   ├── audio.nix                      #   PipeWire (pengganti pulseaudio)
│   │   ├── bluetooth.nix                  #   Bluetooth
│   │   ├── intel-graphics.nix             #   Intel GPU (media-driver + vpl-gpu-rt)
│   │   └── memory.nix                     #   zramSwap (zstd, 50% RAM)
│   │
│   ├── desktop/
│   │   ├── hyprland.nix                   #   Hyprland system (SDDM, portal, logind) — user config di home-manager
│   │   └── kde-plasma.nix                 #   KDE Plasma 6 (dead code — tidak diimpor)
│   │
│   └── services/
│       ├── docker.nix                     #   Docker (tidak auto-start)
│       ├── flatpak.nix                    #   Flatpak
│       ├── mysql.nix                      #   MySQL/MariaDB
│       ├── power-profiles-daemon.nix      #   Power profiles
│       └── ssh.nix                        #   SSH client config + agent
│
└── home/                                  # Home-manager (user: gfors)
    └── profiles/
        └── tbook.nix                      # Entrypoint: impor semua modul shared/ (bukan home/default.nix)
            │
            └── shared/                    # Logical directory — diimpor eksplisit via tbook.nix
                ├── apps/
                │   ├── spotify.nix        #   Spotify (via spicetify-nix — aktif)
                │   ├── vesktop.nix        #   Vencord desktop
                │   ├── alsa-tools.nix     #   ALSA tools
                │   ├── browsers.nix       #   Firefox/Chromium dll
                │   ├── tor-browser.nix    #   Tor Browser
                │   ├── mpv.nix            #   MPV
                │   ├── obs.nix            #   OBS Studio
                │   ├── gimp.nix           #   GIMP
                │   └── vlc.nix            #   VLC (dead code — tidak diimpor)
                │
                ├── shell/
                │   ├── zsh.nix            #   Zsh + p10k (dari dotfiles eksternal)
                │   ├── tmux.nix           #   Tmux
                │   └── scripts/
                │       └── tmux-autostart.sh
                │
                ├── common/
                │   └── hyprland.nix       #   Hyprland user config (dotfiles symlink, waybar, rofi, mako)
                │
                ├── terminal/
                │   └── kitty.nix          #   Kitty terminal
                │
                ├── cli-tools/
                │   ├── opencode.nix       #   opencode AI CLI
                │   ├── yazi.nix           #   Yazi file manager
                │   ├── ffmpeg.nix         #   FFmpeg
                │   ├── ngrok.nix          #   ngrok
                │   └── posting.nix        #   Posting API client
                │
                ├── dev/
                │   ├── direnv.nix         #   Direnv
                │   ├── gcc.nix            #   GCC
                │   ├── git.nix            #   Git + SSH agent (id_ed25519_github)
                │   ├── go.nix             #   Go
                │   ├── nodejs.nix         #   Node.js
                │   ├── php.nix            #   PHP
                │   └── python.nix         #   Python
                │
                └── editor/
                    └── neovim.nix         #   Neovim
```

## Structure Overview

| Layer | Path | Deskripsi |
|---|---|---|
| **Flake** | `flake.nix` | Inputs (nixpkgs, nixpkgs-unstable, home-manager, spicetify-nix) → `nixosConfigurations.tbook` |
| **System (NixOS)** | `hosts/tbook/` → imports `modules/*` | Boot, network, hardware, desktop, services |
| **User (home-manager)** | `home/profiles/tbook.nix` → imports `home/shared/*` | Aplikasi, shell, common(hyprland), dev tools, CLI, editor |

## Key details

- **User**: `gfors` (shell: zsh, home: `/home/gfors`)
- **Boot**: systemd-boot with EFI
- **Desktop**: Hyprland system via SDDM (Wayland); KDE Plasma 6 module tersedia tapi tidak aktif
- **Audio**: PipeWire (replaces pulseaudio)
- **GPU**: Intel with `intel-media-driver` + `vpl-gpu-rt`
- **Firewall**: enabled, ports 1714-1764 (UDP/TCP) open for KDE Connect
- **Nix**: flakes + nix-command experimental features, auto GC (delete >5d), unfree packages allowed
- **Time zone**: Asia/Jakarta

## Quirks & gotchas

- `hardware-configuration.nix` is regenerated on hardware changes — do not hand-edit
- `home-manager` is used as a NixOS module (`useGlobalPkgs = true`, `useUserPackages = true`)
- `spicetify-nix` is a flake input, passed via `extraSpecialArgs`, dan sudah dipakai oleh `home/shared/apps/spotify.nix`
- `home/profiles/tbook.nix` is the home-manager entrypoint (not `home/default.nix` — file itu tidak ada)
- `modules/desktop/kde-plasma.nix` & `home/shared/apps/vlc.nix` adalah dead code — file ada tapi tidak diimpor di mana pun
- `home/shared/common/hyprland.nix` holds Hyprland user config (dotfiles symlinks, waybar, rofi, mako, etc.) — system-level Hyprland config (SDDM, portal, logind) stays at `modules/desktop/hyprland.nix`
- Zsh config sources `~/.p10k.zsh` from an external `dotfiles` repo (`${config.home.homeDirectory}/dotfiles/zsh/.p10k.zsh`)
- SSH agent auto-starts; GitHub identity uses `~/.ssh/id_ed25519_github` with `IdentitiesOnly yes`
- `home.stateVersion` and `system.stateVersion` are both `"26.05"` — bump only on first install of a new release
- `.gitmodules` exists but is empty (no submodules currently)
