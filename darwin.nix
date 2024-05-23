{ pkgs, lib, username, hostname, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nix;

    settings = {
      auto-optimise-store = false;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ username ];
    };

    gc = {
      automatic = lib.mkDefault true;
      options = lib.mkDefault "--delete-older-than 7d";
    };
  };


  networking = {
    hostName = hostname;
    computerName = hostname;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
  };


  system = {
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      smb.NetBIOSName = hostname;

      # customize dock
      dock = {
        autohide = true; # automatically hide and show the dock
        show-recents = false; # do not show recent apps in dock
        mru-spaces = false;

      };
      # customize finder
      finder = {
        _FXShowPosixPathInTitle = true; # show full path in finder title
        AppleShowAllExtensions = true; # show all file extensions
        AppleShowAllFiles = true;
        FXEnableExtensionChangeWarning = false; # disable warning when changing file extension
        QuitMenuItem = true; # enable quit menu item
        ShowPathbar = true; # show path bar
        ShowStatusBar = true; # show status bar
      };
      NSGlobalDomain = {
        AppleShowAllFiles = true;
      };
      CustomUserPreferences = {
        "com.apple.finder" = {
          AppleShowAllFiles = true;
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = true;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
        };

      };
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;
  environment = {
    shells = [
      pkgs.zsh
    ];
    systemPackages = with pkgs; [
      nixpkgs-fmt
    ];
    variables.EDITOR = "nvim";
  };




  services = {
    nix-daemon.enable = true;
    yabai = {
      enable = true;
      enableScriptingAddition = true;
      extraConfig = builtins.readFile ./yabairc;
    };
    skhd = {
      enable = true;
      skhdConfig = builtins.readFile ./skhdrc;
    };
  };


  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };

    taps = [
    ];
    brews = [
      "pnpm"
      "nvm"
      "watchman"
    ];
    casks = [
      "font-jetbrains-mono-nerd-font"
      "visual-studio-code"
      "google-chrome"
      "microsoft-edge"
      "raycast"
      "proxyman"
      "ollama"
    ];

    masApps = {
      Xcode = 497799835;
    };

  };

}
