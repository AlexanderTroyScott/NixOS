{
  description = "A basic modular flake with home-manager";

  inputs =
   {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";                         # Default Stable Nix Packages
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";             # Unstable Nix Packages

        home-manager = {
            url = "github:nix-community/home-manager/release-23.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    };
  outputs = inputs @ {self, nixpkgs, nixpkgs-unstable, home-manager}:
    let
        user = "alex";
        location = "$HOME/.setup";
    in 
    {
        nixosConfigurations = (
            import ./hosts {
                inherit (nixpkgs) lib;
                inherit inputs nixpkgs nixpkgs-unstable home-manager user location;
            }
        ); 
   };
}
