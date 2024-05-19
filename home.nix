{ lib, username, useremail, ... }:

{

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = username;
    homeDirectory = "/Users/${username}";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.11";

    shellAliases = { };

  };



  programs = {
    home-manager.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      initExtra = builtins.readFile ./zshrc;

      prezto = {
        enable = true;
        pmodules = [
          "environment"
          "terminal"
          "editor"
          "history"
          "directory"
          "spectrum"
          "utility"
          "completion"
          "autosuggestions"
        ];

      };

    };

    git = {
      enable = true;
      lfs.enable = true;

      userName = username;
      userEmail = useremail;


      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        pull.rebase = true;
      };

      delta = {
        enable = true;
        options = {
          features = "side-by-side";
        };
      };

      aliases = {
        br = "branch";
      };
    };

    starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;

      settings = {
        character = {
          success_symbol = "[›](bold green)";
          error_symbol = "[›](bold red)";
        };
      };
    };



    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };

    # A command-line fuzzy finder
    fzf = {
      enable = true;
    };
    skim = {
      enable = true;
    };

    wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./wezterm.lua;
    };

  };
}
