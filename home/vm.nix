{ pkgs, ... }:{
  # services.yabai.enable = true;
  # services.yabai.package = pkgs.yabai;
  # services.yabai.enableScriptingAddition = true;


  services.yabai = {
    enable = true;
    # temporary workaround for https://github.com/ryan4yin/nix-config/issues/51
    package = pkgs.yabai.overrideAttrs (oldAttrs: rec {
      version = "6.0.7";
      src =
        if pkgs.stdenv.isAarch64
        then
          (pkgs.fetchzip {
            url = "https://github.com/koekeishiya/yabai/releases/download/v${version}/yabai-v${version}.tar.gz";
            hash = "sha256-hZMBXSCiTlx/37jt2yLquCQ8AZ2LS3heIFPKolLub1c=";
          })
        else
          (pkgs.fetchFromGitHub {
            owner = "koekeishiya";
            repo = "yabai";
            rev = "v${version}";
            hash = "sha256-vWL2KA+Rhj78I2J1kGItJK+OdvhVo1ts0NoOHIK65Hg=";
          });
    });

    # Whether to enable yabai's scripting-addition.
    # SIP must be disabled for this to work.
    # https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection
    enableScriptingAddition = true;
    # config = {};
    extraConfig = builtins.readFile ./yabairc;
  };

}
