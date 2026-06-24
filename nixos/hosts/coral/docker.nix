{...}: {
  virtualisation.docker = {
    enable = true;
    liveRestore = false;
    daemon.settings.ipv6 = true;
  };
}
