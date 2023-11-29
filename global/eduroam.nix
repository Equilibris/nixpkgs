{ config, pkgs, ... }:
let
  ca-cert = /home/williams/.config/nixpkgs/global/ca.pem;

  nmconnection = (pkgs.formats.ini { }).generate "eduroam-cam-ac-uk.nmconnection" {
    connection = {
      id = "eduroam (cam.ac.uk)";
      type = "wifi";
    };

    wifi = {
      ssid = "eduroam";
    };

    wifi-security = {
      key-mgmt = "wpa-eap";
    };

    "802-1x" = {
      anonymous-identity = "_token@cam.ac.uk";
      ca-cert = "${ca-cert}";
      domain-suffix-match = "cam.ac.uk";
      eap = "peap";
      identity = "ws423+nixos@cam.ac.uk ";
      password = "rdtbzqehujugz7qd";
      phase2-auth = "mschapv2"; # Don't know if this is needed
    };

    ipv4 = {
      method = "auto";
    };

    ipv6 = {
      addr-gen-mode = "stable-privacy";
      method = "auto";
    };
  };
in
{
  security.pki.certificateFiles = [ ca-cert ];

  environment.etc."NetworkManager/system-connections/eduroam.nmconnection" = {
    source = nmconnection;
    mode = "0600";
  };
}
