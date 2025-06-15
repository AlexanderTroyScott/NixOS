{

#Yubikey
  security.pam.u2f = {
    enable = true;
    settings = {
      cue = true;
      debug = false;
    };
    control = "sufficient";
  };
}