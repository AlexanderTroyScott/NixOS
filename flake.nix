{
  description = "A basic modular flake with home-manager";

  inputs =
   {
       # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";                         # Default Stable Nix Packages
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";             # Unstable Nix Packages
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-22-11.url = "github:NixOS/nixpkgs/nixos-22.11";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs-unstable";
        };
        
        hyprland = {                                                          # Official Hyprland flake
        url = "github:vaxerski/Hyprland";                                   # Add "hyprland.nixosModules.default" to the host modules
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      };
    };
    
  outputs = inputs @ {self, nixpkgs, nixpkgs-22-11, nixpkgs-unstable, home-manager, hyprland}:
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
        nixpkgs.overlays = [
        (self: super: {
          pcloud = self.inputs.nixpkgs-22-11.legacyPackages.x86_64-linux.pcloud.overrideAttrs (oldAttrs: {
            meta = oldAttrs.meta // { free = true; };
          });
        })
        ];
    };
}
