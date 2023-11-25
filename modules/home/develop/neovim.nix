{ pkgs, ... }: {
  # TODO: this.
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      Ionide-vim
    ];
  };
}
