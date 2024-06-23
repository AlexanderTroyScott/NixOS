{ config, pkgs, ... }:

{

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Canon";
        location = "Home";
        deviceUri = "http://192.168.209.60:631/ipp/print";
        model = "drv:///sample.drv/generic.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "Canon";
  };

  services.printing = {
    enable = true;
    drivers = [ pkgs.cups ];
  };

  hardware.sane.enable = true;

  networking.firewall.allowedTCPPorts = [ 631 ];
}

