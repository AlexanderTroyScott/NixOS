# Eye of Zomm (EQLWiki) - desktop companion for EverQuest Legends.
# https://github.com/Maergoth/EQL-EOZ
#
# Packaged from the upstream AppImage release (electron-builder).
# Do not edit `version` and `hash` by hand - bump them with:
#   nix run .#update-eoz
{
  lib,
  appimageTools,
  fetchurl,
}: let
  pname = "eye-of-zomm";
  version = "1.0.11";

  src = fetchurl {
    url = "https://github.com/Maergoth/EQL-EOZ/releases/download/v${version}/EQLWiki-Eye-of-Zomm-${version}-x64.AppImage";
    hash = "sha256-Hmsum0aRuIOoBa9LypH8xDlPIy6sCPx0FHV2fSP3vF0=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
  appimageTools.wrapType2 {
    inherit pname version src;

    # Chromium's text-to-speech (trigger speech) talks to speech-dispatcher.
    # It also needs the daemon: services.speechd.enable = true;
    extraPkgs = pkgs: [pkgs.speechd];

    extraInstallCommands = ''
      # Desktop entry + icon from the AppImage. Upstream runs Electron with
      # --no-sandbox (kept in the launcher below), so plain Exec works.
      install -m 444 -D ${appimageContents}/com.eqlwiki.eyeofzomm.desktop \
        $out/share/applications/com.eqlwiki.eyeofzomm.desktop
      substituteInPlace $out/share/applications/com.eqlwiki.eyeofzomm.desktop \
        --replace-fail 'Exec=AppRun --no-sandbox %U' 'Exec=eye-of-zomm %U'
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/512x512/apps/eqlwiki-eye-of-zomm.png \
        $out/share/icons/hicolor/512x512/apps/eqlwiki-eye-of-zomm.png

      # Bake upstream's --no-sandbox flag into direct launches too.
      mv $out/bin/eye-of-zomm $out/bin/eye-of-zomm-inner
      printf '#!/bin/sh\nexec %s --no-sandbox "$@"\n' "$out/bin/eye-of-zomm-inner" > $out/bin/eye-of-zomm
      chmod +x $out/bin/eye-of-zomm
    '';

    meta = {
      description = "Companion app for EverQuest Legends: game-log following, live maps, wiki loot, combat parse and triggers";
      homepage = "https://github.com/Maergoth/EQL-EOZ";
      downloadPage = "https://github.com/Maergoth/EQL-EOZ/releases";
      license = lib.licenses.mit;
      platforms = ["x86_64-linux"];
      sourceProvenance = [lib.sourceTypes.binaryNativeCode];
    };
  }
