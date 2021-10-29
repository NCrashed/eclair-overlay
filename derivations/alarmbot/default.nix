{ lib, stdenv, maven, fetchgit, callPackage, eclair, eclair-repository }:
let repository = callPackage ./repository.nix {  };
in stdenv.mkDerivation rec {
  pname = "alarmbot";
  version = "0.6.2";
  
  src = import ./source.nix { inherit fetchgit; };

  buildInputs = [ maven ];

  buildPhase = ''
    echo "Using repository ${repository}"
    mvn --offline -Dmaven.repo.local=${repository} package;
  '';

  installPhase = ''
    mkdir -p $out/share/java
    cp target/eclair-alarmbot_2.13-${version}.jar $out/share/java
  '';

  meta = with lib; {
    description = "Simplest possible Eclair plugin. Can be upgraded with new events or even important node statistics.";
    homepage = "https://github.com/engenegr/eclair-alarmbot-plugin";
    # license = licenses.asl20;
    # maintainers = with maintainers; [ prusnak ];
    platforms = [ "x86_64-linux" "x86_64-darwin" ];
  };
}