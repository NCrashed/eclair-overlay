{ lib, stdenv, maven, fetchgit, eclair, openjdk11 }:
stdenv.mkDerivation rec {
  name = "eclair-maven-repository";
  version = "0.6.2";
  buildInputs = [ maven openjdk11 ];
  src = import ./source.nix { inherit fetchgit; };
  buildPhase = ''
    mvn install -Dmaven.repo.local=$out -DskipTests=true
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
  outputHash = "1v7vcpkxdpjq3x6ybr05sz3vxm2afwy5y3s29cvrb0w6nrlhpcyi";
}