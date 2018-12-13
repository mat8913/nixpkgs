{ stdenv, fetchFromGitHub, SDL2, cmake, ffmpeg }:

stdenv.mkDerivation rec {
  name = "faudio";

  src = fetchFromGitHub {
    owner = "FNA-XNA";
    repo = "FAudio";
    rev = "1afcf017bbbe31d18f762a9d93674e36c6a0302f";
    sha256 = "080s7yjnf8y3wmqfyyb6ij6qpyq6q9i6cwy8736g23qh1xrc7y3f";
  };

  cmakeFlags = [ "-DFFMPEG=ON" ];

  buildInputs = [ SDL2 cmake ffmpeg ];

  postInstall = ''
    mkdir -p $out/lib/pkgconfig
    substitute ${./faudio.pc.in} $out/lib/pkgconfig/faudio.pc --replace @prefix@ $out
  '';

  meta = with stdenv.lib; {
    description = "Accuracy-focused XAudio reimplementation for open platforms";
    homepage = https://github.com/FNA-XNA/FAudio;
    license = licenses.zlib;
    platforms = platforms.all;
  };
}
