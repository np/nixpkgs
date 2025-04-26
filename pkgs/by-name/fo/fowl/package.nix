{
  lib,
  python3Packages,
  fetchPypi,
}:

python3Packages.buildPythonApplication rec {
  pname = "fowl";
  version = "25.4.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-Pggy2BmtG/avB/QbFjMhdX6Tf+8z6eABYwHL7S5Gvv0=";
  };

  build-system = [
    python3Packages.hatchling
  ];

  dependencies = with python3Packages; [
    attrs
    click
    humanize
    magic-wormhole
    msgpack
    setuptools
    six
    twisted
  ];

  optional-dependencies = with python3Packages; {
    dev = [
      cuvner
      dulwich
      gpg
      hatch
      pip-tools
      readme-renderer
      sphinx
      twine
    ];
    test = [
      cuvner
      hypothesis
      magic-wormhole-mailbox-server
      pytest
      pytest-cov
      pytest-twisted
      ruff
    ];
  };

  pythonImportsCheck = [
    "fowl"
  ];

  meta = {
    description = "Forward Over Wormhole Locally provides bi-directional streaming data over secure and durable Dilated magic-wormhole connections. Secure communication with easy setup";
    homepage = "https://pypi.org/project/fowl/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ np ];
    mainProgram = "fowl";
  };
}
