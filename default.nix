let pkgs = import ./pkgs.nix { 
        overlays = [
            (import ./overlay.nix)
        ];
    };
in with pkgs; [
    eclair 
    eclair-alarmbot
    plugin-hosted-channels
]