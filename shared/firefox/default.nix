{pkgs, ...}: {
  # Don't use programs.firefox.enable, because it creates a policy which conflicts with my own
  environment.systemPackages = [pkgs.firefox-esr];
  environment.etc."firefox/policies/policies.json".source = ./policies.json;
}
