{
  config,
  ...
}: {
  imports = builtins.map (file: ./system + "/${file}") (
    builtins.filter (file: builtins.match ".*\\.nix$" file != null)
      (builtins.attrNames (builtins.readDir ./system))
  );
}