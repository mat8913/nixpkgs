pkgs:

with pkgs;

buildEnv {
  name = "my-packages";
  paths = [
    ffmpeg_3_2
    firefox-esr-60
    gitAndTools.git-annex
    gitAndTools.gitRemoteGcrypt
    gnupg
    mkvtoolnix
    mpv
    powerline-fonts
    taskwarrior
    weechat
    youtube-dl
    gitAndTools.git-annex-remote-rclone
    rclone
    (pass.withExtensions (exts: [exts.pass-otp]))

    haskellPackages.myanimelist-export
    haskellPackages.passman-cli
  ];
  extraOutputsToInstall = [ "man" "doc" ];
}
