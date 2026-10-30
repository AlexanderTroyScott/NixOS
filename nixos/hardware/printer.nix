{
  config,
  pkgs,
  ...
}: {
  hardware.printers = {
    ensurePrinters = [
      {
        name = "Canon";
        location = "Home";
        deviceUri = "socket://192.168.2.59:9100";
        model = "Canon_MF733C_UFR_II.ppd";
        ppdOptions = {
          PageSize = "Letter";
        };
      }
    ];
    ensureDefaultPrinter = "Canon";
  };

  services.printing = {
    enable = true;
    drivers = [pkgs.canon-cups-ufr2];
  };

  hardware.sane.enable = true;

  networking.firewall.allowedTCPPorts = [631];
}
