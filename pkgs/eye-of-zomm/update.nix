# Bumps the eye-of-zomm pin (pkgs/eye-of-zomm/default.nix) to the latest
# upstream release of Maergoth/EQL-EOZ. Run from the config repo root:
#   nix run .#update-eoz
{
  writeShellApplication,
  coreutils,
  curl,
  gnused,
  jq,
  nix,
}:
writeShellApplication {
  name = "update-eoz";
  runtimeInputs = [coreutils curl gnused jq nix];
  text = ''
    repo="Maergoth/EQL-EOZ"
    pkg_file="''${1:-pkgs/eye-of-zomm/default.nix}"

    if [[ ! -f "$pkg_file" ]]; then
      echo "error: $pkg_file not found" >&2
      echo "Run this from your NixOS config repo root, or pass the path to pkgs/eye-of-zomm/default.nix." >&2
      exit 1
    fi

    echo "Checking latest release of $repo ..."
    release_json="$(curl -fsSL "https://api.github.com/repos/$repo/releases/latest")"

    version="$(jq -r '.tag_name' <<<"$release_json" | sed 's/^v//')"
    url="$(jq -r '[.assets[] | select(.name | endswith("-x64.AppImage"))][0].browser_download_url' <<<"$release_json")"

    if [[ -z "$url" || "$url" == "null" ]]; then
      echo "error: release v$version has no x64.AppImage asset" >&2
      exit 1
    fi

    current="$(sed -n -E 's/^[[:space:]]*version = "([^"]+)";.*/\1/p' "$pkg_file" | head -n 1)"
    if [[ "$current" == "$version" ]]; then
      echo "Already at v$version - nothing to do."
      exit 0
    fi

    echo "Downloading v$version AppImage ..."
    tmpdir="$(mktemp -d)"
    trap 'rm -rf "$tmpdir"' EXIT
    curl -fL -o "$tmpdir/app.AppImage" "$url"

    hash="$(nix hash file --sri "$tmpdir/app.AppImage")"

    sed -i -E \
      -e "s/version = \"[^\"]+\";/version = \"$version\";/" \
      -e "s|hash = \"sha256-[^\"]*\";|hash = \"$hash\";|" \
      "$pkg_file"

    echo "Updated $pkg_file: v$current -> v$version"
    echo "Hash: $hash"
    echo
    echo "Next: nix fmt . && sudo nixos-rebuild switch --flake .#zenbook"
  '';
}
