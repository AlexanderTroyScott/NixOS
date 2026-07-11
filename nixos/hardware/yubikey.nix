{
  security.pam.u2f = {
    enable = true;
    settings = {
      cue = true;
      debug = false;
      pinVerification = false;
    };
    control = "sufficient";
  };

  security.pam.services.login.u2fAuth = true;
  security.pam.services.sudo.u2fAuth = true;
}
