let

config = import ../config.nix;
nixpkgs = import ../..;
makeOverride = packageOverrides: nixpkgs {
  config = config // {inherit packageOverrides;};
};

in

{
}
