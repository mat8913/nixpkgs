{ stdenv, fetchurl, gfortran, readline, ncurses, perl, flex, texinfo, qhull
, libsndfile, portaudio, libX11, graphicsmagick, pcre, pkgconfig, libGLU_combined, fltk
, fftw, fftwSinglePrec, zlib, curl, qrupdate, openblas, arpack, libwebp
, qt ? null, qscintilla ? null, ghostscript ? null, llvm ? null, hdf5 ? null,glpk ? null
, suitesparse ? null, gnuplot ? null, gl2ps ? null, jdk ? null, python ? null, overridePlatforms ? null
}:

let
  suitesparseOrig = suitesparse;
  qrupdateOrig = qrupdate;
in
# integer width is determined by openblas, so all dependencies must be built
# with exactly the same openblas
let
  suitesparse =
    if suitesparseOrig != null then suitesparseOrig.override { inherit openblas; } else null;
  qrupdate = if qrupdateOrig != null then qrupdateOrig.override { inherit openblas; } else null;
in

stdenv.mkDerivation rec {
  version = "4.2.2";
  name = "octave-${version}";
  src = fetchurl {
    url = "mirror://gnu/octave/${name}.tar.gz";
    sha256 = "0vkjfrpv7aikcn73bxqkph1qrhrdx7jqy193n8d8lwp7v2al7f3p";
  };

  buildInputs = [ gfortran readline ncurses perl flex texinfo qhull
    graphicsmagick pcre pkgconfig fltk zlib curl openblas libsndfile fftw
    fftwSinglePrec portaudio qrupdate arpack libwebp ]
    ++ (stdenv.lib.optional (qt != null) qt)
    ++ (stdenv.lib.optional (qscintilla != null) qscintilla)
    ++ (stdenv.lib.optional (ghostscript != null) ghostscript)
    ++ (stdenv.lib.optional (llvm != null) llvm)
    ++ (stdenv.lib.optional (hdf5 != null) hdf5)
    ++ (stdenv.lib.optional (glpk != null) glpk)
    ++ (stdenv.lib.optional (suitesparse != null) suitesparse)
    ++ (stdenv.lib.optional (jdk != null) jdk)
    ++ (stdenv.lib.optional (gnuplot != null) gnuplot)
    ++ (stdenv.lib.optional (gl2ps != null) gl2ps)
    ++ (stdenv.lib.optional (python != null) python)
    ++ (stdenv.lib.optionals (!stdenv.isDarwin) [ libGLU_combined libX11 ])
    ;

  # makeinfo is required by Octave at runtime to display help
  prePatch = ''
    substituteInPlace libinterp/corefcn/help.cc \
      --replace 'Vmakeinfo_program = "makeinfo"' \
                'Vmakeinfo_program = "${texinfo}/bin/makeinfo"'
  ''
  # REMOVE ON VERSION BUMP
  # Needed for Octave-4.2.1 on darwin. See https://savannah.gnu.org/bugs/?50234
  + stdenv.lib.optionalString stdenv.isDarwin ''
    sed 's/inline file_stat::~file_stat () { }/file_stat::~file_stat () { }/' -i ./liboctave/system/file-stat.cc
  '';

  doCheck = !stdenv.isDarwin;

  enableParallelBuilding = true;

  configureFlags =
    [ "--enable-readline"
      "--enable-dl"
      "--with-blas=openblas"
      "--with-lapack=openblas"
    ]
    ++ stdenv.lib.optional openblas.blas64 "--enable-64"
    ++ stdenv.lib.optionals stdenv.isDarwin ["--with-x=no"]
    ;

  # Keep a copy of the octave tests detailed results in the output
  # derivation, because someone may care
  postInstall = ''
    cp test/fntests.log $out/share/octave/${name}-fntests.log || true
  '';

  passthru = {
    inherit version;
    sitePath = "share/octave/${version}/site";
  };

  meta = {
    homepage = http://octave.org/;
    license = stdenv.lib.licenses.gpl3Plus;
    maintainers = with stdenv.lib.maintainers; [viric raskin];
    platforms = if overridePlatforms == null then
      (with stdenv.lib.platforms; linux ++ darwin)
    else overridePlatforms;
  };
}
