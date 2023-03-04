{ pkgs }:
let

  raylib-lua = with pkgs; stdenv.mkDerivation rec {
    version = "v4.2a";
    pname = "raylib-lua-${version}";
    src = fetchFromGitHub {
      owner = "TSnake41";
      repo = "raylib-lua";
      rev = version;
      sha256 = "18y186c989bvl8n2zfh9wjvfx9x315pab20ywdx71w9h520gfsmb";
      fetchSubmodules = true;
    };
    buildInputs = [
      raylib
      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXinerama
      xorg.libXi
      xorg.libXext
    ];

    installPhase = ''
    mkdir -p $out/bin
    cp -r * $out/bin/
    '';
  };
  
in
{ 
  deps = [
    raylib-lua
    pkgs.luajitPackages.lua
    pkgs.luajitPackages.argparse
    pkgs.luajitPackages.moonscript
    pkgs.libresprite
    #pkgs.tiled

    # not available from old channel
    #pkgs.pixelorama
  ];
}