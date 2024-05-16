{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
    # pnpm
    export PNPM_HOME="/Users/lj/Library/pnpm"
    case ":$PATH:" in
      *":$PNPM_HOME:"*) ;;
      *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
    # pnpm end

    export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

    # bun completions
    [ -s "/Users/lj/.bun/_bun" ] && source "/Users/lj/.bun/_bun"

    # bun
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
    
    '';
   
  };

  home.shellAliases = {
  };
}
