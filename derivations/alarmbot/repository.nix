{ lib, stdenv, maven, fetchgit, eclair, eclair-repository }:
stdenv.mkDerivation rec {
  name = "alarmbot-maven-repository";
  version = "0.6.2";
  buildInputs = [ maven ];
  src = import ./source.nix { inherit fetchgit; };
  buildPhase = ''
    echo "Adding eclair dependency"
    cp -r ${eclair-repository} $out
    chmod -R u+rw $out        
    echo "Adding repo itself"
    mvn package -Dmaven.repo.local=$out
  '';

  # keep only *.{pom,jar,sha1,nbm} and delete all ephemeral files with lastModified timestamps inside
  installPhase = ''
    find $out -type f \
      -name \*.lastUpdated -or \
      -name resolver-status.properties -or \
      -name _remote.repositories \
      -delete
  '';

  # don't do any fixup
  dontFixup = true;
  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  # replace this with the correct SHA256
  outputHash = "1j184mm9i8b648n0bv4ymmz00k5d00fz6vb2aa59d4dxa2xxh9i5";
}