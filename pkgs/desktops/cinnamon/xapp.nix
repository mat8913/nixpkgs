{ stdenv, fetchFromGitHub, meson, pkgconfig, gobjectIntrospection, gtk3, libgnomekbd, libxklavier, vala, python3Packages, python2, ninja }:

stdenv.mkDerivation rec {
  name = "xapp-${version}";
  version = "1.2.2";

  src = fetchFromGitHub {
    owner = "linuxmint";
    repo = "xapps";
    rev = version;
    sha256 = "0ck66wgym29sz1k14kirv4dzfddx86z8kmdx0k663v1l1b3n7dcj";
  };

  nativeBuildInputs = [ meson pkgconfig vala python2 ninja ];
  buildInputs = [ gobjectIntrospection gtk3 libgnomekbd libxklavier python3Packages.pygobject3 ];

  postPatch = ''
    chmod +x schemas/meson_install_schemas.py
    patchShebangs schemas/meson_install_schemas.py
  '';

  preInstall = ''
    export DESTDIR="$out"
  '';
}
