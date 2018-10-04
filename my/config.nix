{
  unison.enableX11 = false;
  packageOverrides = pkgs: {
    my = {
      packages = import ./packages.nix pkgs.pkgs;
    };
  };
}
