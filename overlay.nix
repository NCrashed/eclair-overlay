self: super:
rec {
  eclair = self.callPackage ./derivations/eclair {};
  eclair-repository = self.callPackage ./derivations/eclair/repository.nix {};
  eclair-alarmbot = self.callPackage ./derivations/alarmbot {};
}
