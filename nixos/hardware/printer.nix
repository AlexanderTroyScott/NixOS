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

}