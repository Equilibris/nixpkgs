{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.utf8";

  # Configure console keymap
  console.keyMap = "no";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  users.defaultUserShell = unstable.fish;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.williams = {
    isNormalUser = true;
    description = "William Sørensen";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
  virtualisation.docker.enable = true;
}

