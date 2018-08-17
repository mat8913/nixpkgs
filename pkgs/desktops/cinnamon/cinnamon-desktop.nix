{ stdenv, fetchFromGitHub, meson, pkgconfig, gdk_pixbuf, gtk3, xkeyboard_config
, libxkbfile, libpulseaudio, gettext, gobjectIntrospection, ninja, intltool
, python3Packages
}:

stdenv.mkDerivation rec {
  name = "cinnamon-desktop-${version}";
  version = "3.8.1";

  src = fetchFromGitHub {
    owner = "linuxmint";
    repo = "cinnamon-desktop";
    rev = version;
    sha256 = "0pqgwc37g3nrr9gj67rbkggxyffpghm2ssmgmkmgwsyaz9rm4qs7";
  };

  nativeBuildInputs = [
    meson pkgconfig gettext gobjectIntrospection ninja
    intltool python3Packages.wrapPython
  ];

  buildInputs = [ gdk_pixbuf gtk3 xkeyboard_config libxkbfile libpulseaudio ];

  pythonPath = [ python3Packages.pygobject3 ];

  postPatch = ''
    chmod +x install-scripts/meson_install_schemas.py
    patchShebangs install-scripts/meson_install_schemas.py
  '';

  postFixup = ''
    buildPythonPath "$pythonPath"
    patchPythonScript "$out/bin/cinnamon-desktop-migrate-mediakeys"
  '';

  meta = {
    homepage = "http://cinnamon.linuxmint.com";
    description = "Library and data for various Cinnamon modules";

    longDescription = ''
       The libcinnamon-desktop library provides API shared by several applications
       on the desktop, but that cannot live in the platform for various
       reasons. There is no API or ABI guarantee, although we are doing our
       best to provide stability. Documentation for the API is available with
       gtk-doc.
    '';

    platforms = stdenv.lib.platforms.linux;
    maintainers = [ stdenv.lib.maintainers.mat8913 ];
  };
}
