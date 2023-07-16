{
  description = "A basic modular flake with home-manager and hyprland";

  inputs =
   {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";                         # Default Stable Nix Packages
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";             # Unstable Nix Packages

        home-manager = {
            url = "github:nix-community/home-manager/release-23.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        
        hyprland = {                                                          # Official Hyprland flake
        url = "github:vaxerski/Hyprland";                                   # Add "hyprland.nixosModules.default" to the host modules
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };
  outputs = inputs @ {self, nixpkgs, nixpkgs-unstable, home-manager, hyprland}:
    let
        user = "alex";
        location = "$HOME/.setup";
    in 
    {
        nixosConfigurations = (
            import ./hosts {
                inherit (nixpkgs) lib;
                inherit inputs nixpkgs nixpkgs-unstable home-manager user hyprland location;
            }
        ); 
   };
}
