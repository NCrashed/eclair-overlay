# Hashes 

The deterministic build pins hashes of dependencies in `alarmbot/repository.nix` and `eclair/repository.nix` files. 
If you get hash mismatch errors due updated set of dependencies, simply update `outputHash` in these files.