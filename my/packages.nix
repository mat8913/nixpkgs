pkgs:

with pkgs;
with import ../nixos { configuration = {}; };
with config.system.build;

buildEnv {
  name = "my-packages";
  paths = [
    ffmpeg_3_2
    mkvtoolnix
    youtube-dl
    gitAndTools.git-annex-remote-rclone
    rclone

    haskellPackages.myanimelist-export
    haskellPackages.passman-cli

    nix
    nixos-rebuild
    manual.manpages
  ];
  extraOutputsToInstall = [ "man" "doc" ];
}
