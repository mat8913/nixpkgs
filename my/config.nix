{
  allowUnfree = true;
  packageOverrides = pkgs: {
    my = {
      xmonad-exe = pkgs.haskellPackages.callPackage ./xmonad-exe.nix {};
    };
  };
}
