{ config, pkgs, unstable, ... }:
{
  containers.postgres = {
    bindMounts."/" = {
      hostPath = "/home/williams/containers/pg";
      isReadOnly = false;
    };
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_15;
    };
  };
}
