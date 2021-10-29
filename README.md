# Alarmbot

Generation of `project-info.json` is done by commenting `fr.acinq.eclair` deps in `pom.xml` and running the command inside the alarmbot repo:
```
nix-shell -p maven --run "mvn  -Dmaven.repo.local=$(mktemp -d -t maven)  org.nixos.mvn2nix:mvn2nix-maven-plugin:mvn2nix"
```