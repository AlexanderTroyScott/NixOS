{ config, pkgs, ... }:

let
  sidekickBrowser = pkgs.stdenv.mkDerivation {
    name = "sidekick-browser";
    src = pkgs.fetchurl {
      url = "https://api.meetsidekick.com/downloads/linux/deb?aid=93f675ee-fe1e-47c8-a2c0-3db76d17690d&download_source=website&gcid=1801555284.1718376396"; # Replace with the actual URL of the .deb file
      sha256 = "58ff9bdf22852aa3131d14aa713b75418c093d2ce3f02ffb12c71a2df6fd2cce"; # Replace with the actual SHA256 hash of the .deb file
    };

    unpackPhase = "dpkg-deb -x $src $out";

    buildInputs = [
      pkgs.buildFHSUserEnv
      pkgs.patchelf
    ];

    installPhase = ''
      patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" $out/usr/bin/sidekick-browser
      mkdir -p $out/bin
      ln -s $out/usr/bin/sidekick-browser $out/bin/sidekick-browser
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
    (pkgs.buildFHSUserEnv {
      name = "sidekick-env";
      targetPkgs = pkgs: [
        sidekickBrowser
        pkgs.libX11
        pkgs.libXrender
        pkgs.libXext
        pkgs.glibc
        pkgs.glibcLocales
        pkgs.gcc
        pkgs.libstdcxx
      ];

      runScript = "sidekick-browser";
    })
  ];

  # other existing configuration settings...
}
