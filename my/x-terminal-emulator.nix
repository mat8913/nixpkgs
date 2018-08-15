{ runCommandNoCC, xfce }:

runCommandNoCC "x-terminal-emulator"
  { preferLocalBuild = true;
    allowSubstitutes = false;
  }
  ''
    mkdir -p "$out/bin"
    ln -s "${xfce.terminal}/bin/xfce4-terminal" "$out/bin/x-terminal-emulator"
  ''
