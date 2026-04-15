{
  lib,
  fetchFromGitHub,
  backports-shutil-which,
  bech32,
  buildPythonPackage,
  setuptools,
  cryptography,
  docutils,
  ecdsa,
  gnupg,
  semver,
  mnemonic,
  unidecode,
  mock,
  pytestCheckHook,
  configargparse,
  python-daemon,
  pymsgbox,
  pynacl,
}:

# When changing this package, please test packages {onlykey,trezor}-agent

buildPythonPackage rec {
  pname = "libagent";
  version = "0.16.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "romanz";
    repo = "trezor-agent";
    tag = "libagent/${version}";
    hash = "sha256-JFHBE2o5VSJaz5yeCiXmBchm4/1gA+dZ/PRt3+WENdA=";
  };

  # hardcode the path to gpgconf in the libagent library
  postPatch = ''
    substituteInPlace libagent/gpg/keyring.py \
      --replace "util.which('gpgconf')" "'${gnupg}/bin/gpgconf'" \
      --replace "'gpg-connect-agent'" "'${gnupg}/bin/gpg-connect-agent'"
  '';

  build-system = [ setuptools ];

  # https://github.com/romanz/trezor-agent/pull/481
  pythonRemoveDeps = [ "backports.shutil-which" ];

  dependencies = [
    backports-shutil-which
    unidecode
    configargparse
    python-daemon
    pymsgbox
    ecdsa
    mnemonic
    semver
    pynacl
    bech32
    cryptography
    docutils
  ];

  pythonImportsCheck = [ "libagent" ];

  nativeCheckInputs = [
    mock
    pytestCheckHook
  ];

  disabledTests = [
    # test fails in sandbox
    "test_get_agent_sock_path"
  ];

  meta = {
    description = "Using hardware wallets as SSH/GPG/age agent";
    homepage = "https://github.com/romanz/trezor-agent";
    license = lib.licenses.lgpl3Only;
    maintainers = with lib.maintainers; [ np ];
  };
}
