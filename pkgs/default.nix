# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  eye-of-zomm = pkgs.callPackage ./eye-of-zomm {};
  # Bumps the eye-of-zomm pin to the latest upstream release
  update-eoz = pkgs.callPackage ./eye-of-zomm/update.nix {};
}
