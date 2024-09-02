{pkgs, ...}: let
in {
  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = ''
      unbind C-b
      set-option -g prefix C-Space
      bind C-Space send-prefix
      set status-bg default
      set -g mouse on
      set -g @yank_selection_mouse 'clipboard'
      set -g base-index 1
      setw -g pane-base-index 1
      run-shell ${pkgs.tmuxPlugins.better-mouse-mode}/share/tmux-plugins/better-mouse-mode/better-mouse-mode.tmux
      run-shell ${pkgs.tmuxPlugins.yank}/share/tmux-plugins/tmux-yank/yank.tmux
      run-shell ${pkgs.tmuxPlugins.vim-tmux-navigator}/share/tmux-plugins/tmux-navigator/vim-tmux-navigator.tmux
      # Enable vi mode
      setw -g mode-keys vi

      # Vim-style navigation in copy mode
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
      bind-key -T copy-mode-vi 'V' send -X select-line
      bind-key -T copy-mode-vi 'r' send -X rectangle-toggle
    '';
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.yank
      #modern-tmux-theme
      tmuxPlugins.catppuccin
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
    ];
  };
}
