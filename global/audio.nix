{ config, pkgs, ... }:

{
  #########################################################
  ########## ANY AUDIO PROBLEMS?? TRY THIS FIRST ##########
  #########################################################
  environment.systemPackages = [ pkgs.pavucontrol ];

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  programs.dconf.enable = true;

  # hardware.pulseaudio.enable = true;
  # # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;

  hardware.pulseaudio.enable = true;

  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
  #   # If you want to use JACK applications, uncomment this
  #   #jack.enable = true;

  #   # use the example session manager (no others are packaged yet so this is enabled by default,
  #   # no need to redefine it in your config for now)
  #   #media-session.enable = true;
  # };
}
