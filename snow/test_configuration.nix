{ config, pkgs, lib, ... }: {

  users.users.bjorn = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    vim
  ];
  services.xserver = {
    enable = true;
    layout = "us";
    desktopManager.enlightenment.enable = true;
    displayManager.ly = {
      enable = true;
      defaultUser = "bjorn";
    };
  };

  system.stateVersion = "20.09";
}
