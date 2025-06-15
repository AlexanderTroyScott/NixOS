# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
          pcloud = prev.pcloud.overrideAttrs (oldAttrs: {
            meta = oldAttrs.meta // { free = true; };
          url = "github:NixOS/nixpkgs/release-21.11";
          });

    #pcloud = prev.pcloud.overrideAttrs (oldAttrs: {
    #  version = "unstable-2021-12-10";
    #  src = final.fetchFromGitHub {
    #    owner = "NixOS";
    #    repo = "nixpkgs";
    #    rev = "";
    #    sha256 = "sha256-6eMRFuZOLcoZd2hGw7QV+kAmzE5lK8uK6ZpGs4n7/zw=";
    #  };
    #});

  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
