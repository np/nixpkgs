{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  trezor,
  libagent,
}:

buildPythonPackage rec {
  pname = "trezor-agent";
  version = "0.13.0";
  pyproject = true;

  src = fetchPypi {
    pname = "trezor_agent";
    inherit version;
    hash = "sha256-8zJKfFcI2w5AaC4nJyD12enax7Yige50DueCXmoj6P8=";
  };

  build-system = [ setuptools ];

  dependencies = [
    libagent
    trezor
  ];

  doCheck = false;
  pythonImportsCheck = [ "trezor_agent" ];

  meta = {
    description = "Using Trezor as hardware SSH/GPG/age agent";
    homepage = "https://github.com/romanz/trezor-agent";
    license = lib.licenses.lgpl3Only;
    maintainers = with lib.maintainers; [
      hkjn
      np
      mmahut
    ];
  };
}
