{
  rustPlatform,
  fetchFromGitHub,
  lib,
  makeWrapper,
  hvm,
}:

rustPlatform.buildRustPackage rec {
  pname = "Bend";
  version = "0.2.38";

  src = fetchFromGitHub {
    owner = "HigherOrderCO";
    repo = "Bend";
    tag = version;
    hash = "sha256-3E5Vt/YO6fe0JAtfV5M76Eq84ddRXSGClDBCle0fjyg=";
  };

  cargoHash = "sha256-NPOnbP+11LAV6+It2G24MVB0BJKtXnUaBDmhi47ytC8=";

  nativeBuildInputs = [
    hvm
    makeWrapper
  ];

  doCheck = false;

  postInstall = ''
    wrapProgram $out/bin/bend \
      --prefix PATH : ${lib.makeBinPath [ hvm ]}
  '';

  meta = {
    description = "Massively parallel, high-level programming language";
    homepage = "https://higherorderco.com/";
    license = lib.licenses.asl20;
    mainProgram = "bend";
    maintainers = with lib.maintainers; [ k3yss ];
    platforms = lib.platforms.unix;
  };
}
