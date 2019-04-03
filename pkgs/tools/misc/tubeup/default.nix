{ buildPythonPackage, fetchPypi, internetarchive, youtube-dl, docopt
, makeWrapper }:

buildPythonPackage rec {

  pname = "tubeup";
  version = "0.0.16";

  src = fetchPypi {
    inherit pname version;
    sha256 = "082mki4f8njccs7xd1s6y01n8sfhplhgiiv2wv876sg9l9m2kp27";
  };

  nativeBuildInputs = [ makeWrapper ];
  propagatedBuildInputs = [ internetarchive youtube-dl docopt ];

  makeWrapperArgs = youtube-dl.makeWrapperArgs;
}
