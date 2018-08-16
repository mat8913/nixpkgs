{
  allowUnfree = true;
  unison.enableX11 = false;
  packageOverrides = pkgs: {
    my = {
      packages = import ./packages.nix pkgs.pkgs;
      xmonad-exe = pkgs.haskellPackages.callPackage ./xmonad-exe.nix {};
      x-terminal-emulator = pkgs.callPackage ./x-terminal-emulator.nix {};
    };
  };
}
