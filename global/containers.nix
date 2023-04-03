{ config, pkgs, unstable, ... }:
{
  # virtualisation.docker.enable = true;

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_14;

    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
  };
  # containers.pgx = {
  #   bindMounts."/" = {
  #     hostPath = "/home/williams/containers/pg";
  #     isReadOnly = false;
  #   };
  #   privateNetwork = true;
  #   config =
  #     { config, pkgs, unstable, ... }:
  #     {
  #       services.postgresql = {
  #         enable = true;
  #         package = pkgs.postgresql_14;
  #       };
  #     };
  # };
}
