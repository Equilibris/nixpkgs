{ config, pkgs, lib, ... }:

let
  work = true;

  python-deps = python-packages: with python-packages; [ boto3 ];
  python-with-deps = pkgs.python3.withPackages python-deps;

  # awsScripts = builtins.fetchgitPrivate {
  #   url = "git@bitbucket.org:embriq-regionnord/aws-cli-helper.git";
  #   rev = "a12cbfaaf89cdde59283e0785aafbffb77c2fb2a";

  #   sha256 = ""
  # };
in
if work then {
  # home.packages = [ python-with-deps ];
  home.packages = with pkgs; [ slack ];

  programs.zsh.initExtra = ''
    ca () { export CODEARTIFACT_AUTH_TOKEN=$(aws codeartifact --region eu-north-1 get-authorization-token --domain powercatch --domain-owner 232639570454 --query authorizationToken --output text --profile mfa) \
        && aws codeartifact login --region eu-north-1 --tool npm --domain powercatch --domain-owner 232639570454 --repository npm-store --profile mfa }

    assumepowercatchdev     () { python3 ~/bin/aws-cli-helper.py assume-role powercatch-dev }
    assumepowercatchstaging () { python3 ~/bin/aws-cli-helper.py assume-role powercatch-staging }
    assumepowercatchprod    () { python3 ~/bin/aws-cli-helper.py assume-role powercatch-prod }

    awshelper () { python3 ~/bin/aws-cli-helper.py }
    awsmfa    () { python3 ~/bin/aws-cli-helper.py mfa-login }
  '';

  home.file = {
    "bin/aws-cli-helper.py" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixpkgs/work/aws-cli-helper.py";
    };
    ".aws/powercatch-config" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixpkgs/work/powercatch-config";
    };

    # ".m2/settings.xml" = { source = ./work/m2-settings.xml; };
  };
} else { }

