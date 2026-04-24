{
  lib,
  stdenv,
  vlang,
  coreutils,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "vls";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "vlang"; # GitHub username or org
    repo = "vls"; # Repo name
    rev = "${version}"; # Tag, branch, or commit hash
    sha256 = "sha256-wsohjR5ecD74lfTAArZx2Q9AqKEMaHeXiLlsTAANSds="; # Fill this after first run
  };

  buildInputs = [
    vlang
  ];

  nativeBuildInputs = [
    coreutils
  ];

  preBuild = ''
    export HOME=$(mktemp -d)
  '';

  buildPhase = ''
    export HOME=$TMPDIR
    export XDG_CACHE_HOME=$TMPDIR
    v -prod -cflags "-O3" . -o vls
    strip -s vls
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv vls $out/bin
  '';

  meta = {
    description = "V Language Server";
    homepage = "https://github.com/vlang/vls";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.linux;
    mainProgram = "vls";
  };
}
