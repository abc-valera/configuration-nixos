dir:
let
  contents = builtins.readDir dir;
in
map (name: dir + "/${name}") (
  builtins.filter (name: builtins.match ".*\\.nix$" name != null) (builtins.attrNames contents)
)
