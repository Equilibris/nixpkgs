{ config, pkgs, ... }:

{
  # Set your time zone.
  # time.timeZone = "Europe/Oslo";
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.utf8";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.williams = {
    isNormalUser = true;
    description = "William Sørensen";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    createHome = true;
  };
}
