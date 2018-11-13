pkgs:

with pkgs;

[
  chromium
  ffmpeg_3_2
  firefox-esr-60
  gitAndTools.git-annex
  gitAndTools.gitRemoteGcrypt
  gnupg
  mkvtoolnix
  mpv
  powerline-fonts
  taskwarrior
  unison
  weechat
  youtube-dl

  haskellPackages.myanimelist-export
  haskellPackages.passman-cli
]
