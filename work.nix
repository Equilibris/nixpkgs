{ config, pkgs, lib, ... }:

let
  work = false;

  python-deps = python-packages: with python-packages; [ boto3 ];
  python-with-deps = pkgs.python3.withPackages python-deps;

  # awsScripts = builtins.fetchgitPrivate {
  #   url = "git@bitbucket.org:embriq-regionnord/aws-cli-helper.git";
  #   rev = "a12cbfaaf89cdde59283e0785aafbffb77c2fb2a";

  #   sha256 = ""
  # };
in 
  if work then {
    home.packages = [ python-with-deps ];

    programs.fish.shellInit = ''
      alias ca="export CODEARTIFACT_AUTH_TOKEN=$(aws codeartifact get-authorization-token --domain powercatch --domain-owner 232639570454 --query authorizationToken --output text --profile mfa) \
        && aws codeartifact login --tool npm --domain powercatch --domain-owner 232639570454 --repository npm-store --profile mfa"

      alias assumepowercatchdev="python3 ~/bin/aws-cli-helper.py assume-role powercatch-dev"
      alias assumepowercatchstaging="python3 ~/bin/aws-cli-helper.py assume-role powercatch-staging"
      alias assumepowercatchprod="python3 ~/bin/aws-cli-helper.py assume-role powercatch-prod"

      alias awshelper="python3 ~/bin/aws-cli-helper.py"

      ca
      '';

    home.file = {
      "bin/aws-cli-helper.py" = {
        source = ./work/aws-cli-helper.py;
      };
      ".aws/powercatch-config" = {
        source = ./work/powercatch-config;
      };

      ".m2/settings.xml" = { source = ./work/m2-settings.xml; }; 
    };
  } else {}

