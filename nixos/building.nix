nix = {
    distributedBuilds = true;
    buildMachines = [{
      hostName = "remote-builder";
      system = "x86_64-linux";  # Adjust if your desktop is a different architecture
      maxJobs = 1;  # Adjust based on your desktop's CPU core count
      speedFactor = 2;
      #sshKey = "/root/.ssh/id_ed25519";
      sshKey = "/home/alex/.ssh/id_ed25519";
      supportedFeatures = [ "nixos-test" "big-parallel" "kvm" ];
      mandatoryFeatures = [ ];
      sshUser = "builder";
    }];
    settings.builders-use-substitutes = true;