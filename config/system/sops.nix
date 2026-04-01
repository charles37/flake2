{config, ...}: {
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age = {
      # Use host SSH key for system-level decryption
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      # User age key (derived from SSH key)
      keyFile = "/home/ben/.config/sops/age/keys.txt";
      generateKey = false;
    };

    secrets = {
      "ben-password" = {
        neededForUsers = true;
      };
    };
  };
}
