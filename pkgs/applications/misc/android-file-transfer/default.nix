{ stdenv, fetchgit, cmake, qtbase }:

let
  version = "3.1";
in
stdenv.mkDerivation {
  name = "android-file-transfer-${version}";
  src = fetchgit {
    url = "https://github.com/whoozle/android-file-transfer-linux";
    rev = "f4e722c450badb642a8f8a03aa3760bc51361209";
    sha256 = "09zmdd01bj0zim2y40abhh7g491bk59909jcmf3dny5nan0n4s8i";
  };

  buildInputs = [ cmake qtbase ];

  meta = {
    homepage = "https://github.com/whoozle/android-file-transfer-linux";
    description = "Android File Transfer For Linux (and Mac OS X!)";
    license = stdenv.lib.licenses.gpl3;
    platforms = stdenv.lib.platforms.unix;
    maintainers = [ stdenv.lib.maintainers.np ];
  };
}
