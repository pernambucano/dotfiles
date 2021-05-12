#!/usr/bin/env bash

main() {

	# Colors
	blue='#7aa2f7'
	white='#f5f5f5'
	pink='#f7768e'
  black='#1d202f'
	aqua='#7dcfff'
  background='#24283b'
  background_lighter='#364A82'
  foreground='#c0caf5'
  light_gray='#839496'
  gray='#545c7e'
  green='#9ece6a'
  yellow='#e0af68'
  purple='#bb9af7'

	# Icons
	left_sep=''
	right_sep=''

	tmux set-option -g status on
	tmux set-option -g status-left-length 100
	tmux set-option -g status-right-length 100
	tmux set-option -g status-bg "${background}"
	tmux set-option -g status-fg "${foreground}"
	tmux set-option -g pane-active-border-style "fg=${green}"
status-left ''
	tmux set-option -g status-left "#[bg=${aqua}]#[fg=${black}]#{?client_prefix,#[bg=${green}],} ☺ #[bg=${pink},fg=${black}] #S #[bg=${background},fg=${foreground}] #I #[bg=${blue},fg=${white}]"
	tmux set-option -g status-right "#[bg=${background_lighter},fg=${foreground}]  #H #[bg=${background_lighter},fg=${foreground}]  %Y-%m-%d %H:%M %p"
	tmux set-window-option -g window-status-format " #I #W #F"
	tmux set-window-option -g window-status-current-format "#[bg=${purple},fg=${foreground}]#[fg=${black}] #I #W #[bg=${purple},fg=${foreground}]"
}

main

# vim: set filetype=bash
