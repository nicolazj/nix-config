{ pkgs, ... }: {
  ##########################################################################
  # 
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  # 
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    # neovim
    # git
    nixpkgs-fmt
  ];
  environment.variables.EDITOR = "nvim";


  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    taps = [
    ];
    brews = [
      "pnpm"
      "nvm"
    ];
    casks = [
      "font-victor-mono-nerd-font"
      "visual-studio-code"
      "google-chrome"
      "warp"
      "raycast"
    ];

  };

}
