{ config, pkgs, unstable, ... }:
{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";

      useOSProber = true;

      # splashImage = /home/williams/walls/nordic/nixos.png;
      # theme =
        # pkgs.stdenv.mkDerivation {
        #   pname = "vimix";
        #   version = "3.1";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "vinceliuice";
        #     repo = "grub2-themes";
        #     rev = "7c0d8eb7849cd5a4cf6a26c8750dcf71c26f2b0f";
        #     hash = "sha256-cBgjWD/mR1tiPyVky9Bl5kUrDX6RnARJ+0cEJ4VhbRg=";
        #   };
        #   installPhase = ''
        #     mkdir $out
        #     cd $src
        #     sed -i '1d' ./install.sh
        #     sudo ./install.sh --generate $out -t vimix
        #   '';
        # };
        # pkgs.stdenv.mkDerivation {
        #   pname = "distro-grub-themes";
        #   version = "3.1";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "vinceliuice";
        #     repo = "grub2-themes";
        #     rev = "02ec0a888bbac1483080238aee641a8f78979b21";
        #     hash = "sha256-LLlP3d5I6uDOaa1N1nAbz7xYVghEAF/bydS7oVQj99U=";
        #   };
        #   installPhase = "sh $src/install.sh -g $out";
        # };
      # pkgs.stdenv.mkDerivation {
      #   pname = "distro-grub-themes";
      #   version = "3.1";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "13atm01";
      #     repo = "GRUB-Theme";
      #     rev = "02a3e4233e0b2852a310dc9165097ae9ccf3b2c8";
      #     hash = "sha256-rIpRP5+5Z8tIet6/1/8rB2NFgofUhJVgNhezf7jdRgA=";
      #   };
      #   # installPhase = "cp -r \"Monika (Doki Doki Literature Club)/Monika-DDLC-Version\" $out";
      #   installPhase = "cp -r \"Artoria Pendragon (15th Celebration Version)/Artoria-Celebration-Version\" $out";
      # };

      # pkgs.stdenv.mkDerivation {
      #   pname = "distro-grub-themes";
      #   version = "3.1";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "AdisonCavani";
      #     repo = "distro-grub-themes";
      #     rev = "v3.1";
      #     hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
      #   };
      #   installPhase = "cp -r customize/nixos $out";
      # };

    };
    # shell_on_fail = true;

  };
  # boot.kernelPackages = unstable.linuxPackages_latest;
  # boot.extraModulePackages = [ config.boot.kernelPackages.rtl8812au ];
  # boot.initrd.kernelModules = [ "8812au" ];
}
