{pkgs, ...}: {
  services.github-runners = {
    alex = {
      url = "https://github.com/AlexanderTroyScott/servarr";
      user = "actuary";
      extraPackages = with pkgs; [docker];
      # Create this file on the host: echo "TOKEN" > /etc/github-runner-token && chmod 600 /etc/github-runner-token
      tokenFile = "/etc/github-runner-token";
      replace = true;
    };
    actuarynew = {
      url = "https://github.com/Actuary-LLC";
      user = "actuary";
      # labels = ["traefik" "coral"]; # Option not available in current nixpkgs
      extraPackages = with pkgs; [docker docker-compose];
      # Create this file on the host: echo "TOKEN" > /etc/github-runner-actuarynew-token && chmod 600 /etc/github-runner-actuarynew-token
      tokenFile = "/etc/github-runner-actuarynew-token";
      replace = true;
    };
  };
}
