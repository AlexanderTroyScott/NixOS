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

  # gh provides the git credential helper below (and `gh auth login` for first-time setup)
  home.packages = [pkgs.gh];

  programs.git = {
    enable = true;
    settings = {
      user.name = "AlexanderTroyScott";
      user.email = "Alexander.Troy.Scott@gmail.com";
      # Git credential helper backed by gh's stored token (equivalent to `gh setup-git`)
      credential."https://github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
    };
  };
}
