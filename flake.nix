{
  description = "A very basic flake with home mnager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {self, nixpkgs, home-manager}:
  let
    username = "alex";
    homeDirectory = "/home/alex";
    system = "x86_64-linux";
    stateVersion = "23.05";
    pkgs = import nixpkgs { 
        inherit system;
        config.allowUnfree = true;
        };
    lib = nixpkgs.lib;
    in {
        nixosConfigurations = {
            alex = lib.nixosSystem {
                inherit system;
                modules = [                     
                    ./configuration.nix
                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.alex = {
                            imports = [
                                ./home.nix
                                ];
                        };
                    }
                ];
            };
        }; 
   };
}
