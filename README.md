The repo provides [nix](nixos.org) scripts for deterministic builds for [Eclair](https://github.com/ACINQ/eclair) and the following plugins:

- [alarmbot](https://github.com/engenegr/eclair-alarmbot-plugin)
- [plugin-hosted-channels](https://github.com/btcontract/plugin-hosted-channels)

# Build 

To build Eclair and all plugins:
```
nix-build
```

# Overlay

The repo provides `overlay.nix` that adds the derivations into the package set. How to use it:
```
let pkgs = import ./pkgs.nix { 
        overlays = [
            (import ./overlay.nix)
        ];
    };
```

# Nixos Modules 

TODO

# Hashes 

The deterministic build pins hashes of dependencies in `alarmbot/repository.nix` and `eclair/repository.nix` files. 
If you get hash mismatch errors due updated set of dependencies, simply update `outputHash` in these files.
