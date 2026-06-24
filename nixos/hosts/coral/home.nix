{
  outputs,
  pkgs,
  ...
}: {
  nixpkgs = {
    config.allowUnfree = true;
  };

  home = {
    username = "actuary";
    homeDirectory = "/home/actuary";
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "AlexanderTroyScott";
      user.email = "Alexander.Troy.Scott@gmail.com";
    };
  };
}
