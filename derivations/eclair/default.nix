{ lib
, stdenv
, fetchgit
, jq
, openjdk11
, maven
, callPackage
, unzip
, eclair-repository
}:
stdenv.mkDerivation rec {
  pname = "eclair";
  version = "0.6.2";

  src = import ./source.nix { inherit fetchgit; };

  propagatedBuildInputs = [ jq openjdk11 ];
  buildInputs = [ maven unzip ];

  buildPhase = ''
    echo "Using repository ${eclair-repository}"
    mvn --offline -Dmaven.repo.local=${eclair-repository} -DskipTests=true package;
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin $out/share/java

    install -Dm644 eclair-core/target/eclair-core_2.13-${version}.jar $out/share/java/
    install -Dm644 eclair-core/target/eclair-core_2.13-${version}-tests.jar $out/share/java/
    install -Dm644 eclair-node/target/eclair-node_2.13-${version}.jar $out/share/java/
    
    unzip eclair-node/target/eclair-node-${version}-\''${git.commit.id.abbrev}-bin.zip
    mv eclair-node-${version}-\''${git.commit.id.abbrev}/bin/eclair-node.sh $out/bin/
    cp -r eclair-node-${version}-\''${git.commit.id.abbrev}/lib $out/lib

    runHook postInstall
  '';

  meta = with lib; {
    description = "A scala implementation of the Lightning Network";
    homepage = "https://github.com/ACINQ/eclair";
    license = licenses.asl20;
    maintainers = with maintainers; [ prusnak ];
    platforms = [ "x86_64-linux" "x86_64-darwin" ];
  };
}