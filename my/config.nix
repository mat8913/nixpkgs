{
  packageOverrides = pkgs: {
    my = {
      packages = import ./packages.nix pkgs.pkgs;
    };
  };
}
