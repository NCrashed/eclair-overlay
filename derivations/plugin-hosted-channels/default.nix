{ lib, stdenv, maven, sbt, fetchgit, eclair, eclair-repository, eclair-alarmbot }:
stdenv.mkDerivation rec {
  name = "plugin-hosted-channels";
  version = "0.6.2.2";
  buildInputs = [ sbt ];
  src = import ./source.nix { inherit fetchgit; };
  buildPhase = ''
    echo "Adding eclair dependency"
    mkdir -p lib
    cp -r ${eclair}/lib/* lib/
    cp ${eclair}/share/java/eclair-core_2.13-0.6.2-tests.jar lib
    cp ${eclair-alarmbot}/share/java/eclair-alarmbot_2.13-0.6.2.jar lib

    # echo "resolvers += \"Local Maven Repository\" at \"file:///${eclair-repository}\"" >> build.sbt

    echo "Adding repo itself"
    sbt assembly -Duser.home=./ -Dsbt.boot.directory=./.sbt/boot -Dsbt.repository.config=./repositories -Dsbt.global.base=./.sbt/1.0 -Dsbt.ivy.home=./.sbt/.ivy2
    # mvn package -Dmaven.repo.local=$out
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/java

    cp target/scala-2.13/hc-assembly-0.2.jar $out/share/java

    runHook postInstall
  '';

  # don't do any fixup
  dontFixup = true;
  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  # replace this with the correct SHA256
  outputHash = "0y0q8b0257d9fxkpy01djjm8wm927pb0azf50ja1g51nprcsv7dh";
}