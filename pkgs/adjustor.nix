{
  fetchFromGitHub,
  lib,
  python3,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "adjustor";
  version = "3.6.1";
  pyproject = true;

  src = fetchFromGitHub {
    hash = "sha256-A5IdwuhsK9umMtsUR7CpREGxbTYuJNPV4MT+6wqcWT8=";
    owner = "hhd-dev";
    repo = "adjustor";
    rev = "v${version}";
  };

  propagatedBuildInputs = with python3.pkgs; [
    dbus-python
    fuse
    pygobject3
    pyroute2
    rich
    setuptools
  ];

  # This package doesn't have upstream tests.
  doCheck = false;

  meta = with lib; {
    description = "TDP control of AMD Handhelds with handheld-daemon.";
    homepage = "https://github.com/hhd-dev/adjustor/";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
