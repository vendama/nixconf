{...}: {
  networking.nameservers = ["127.0.0.1" "::1"];
  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      server_names = ["quad9-dnscrypt-ip4-filter-pri" "quad9-dnscrypt-ip6-filter-pri"];
      require_nolog = true;
    };
  };
}
