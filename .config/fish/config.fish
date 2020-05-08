


#========================================================================
#---------------- ALIAS MIOS --------------------------------------------
#========================================================================
# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.github_dots/ --work-tree=$HOME"
alias doom="$HOME/.emacs.d/bin/doom"
alias ls="ls -lA --color=auto"

#========================================================================
#---------------- AUTOSTART --------------------------------------------
#========================================================================

neofetch
fish_ssh_agent

#========================================================================
#---------------- BASIC CONFIG ------------------------------------------
#========================================================================
set fish_greeting "..."


#========================================================================
#---------------- THEME CONFIG --------------------------------------------
# https://github.com/oh-my-fish/oh-my-fish/blob/master/docs/Themes.md
#========================================================================
set -g theme_display_git yes
set -g theme_display_git_dirty no
set -g theme_display_git_untracked no
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_master_branch yes
set -g theme_git_worktree_support no
set -g theme_use_abbreviated_branch_name yes
set -g theme_display_vagrant no
set -g theme_display_docker_machine no
set -g theme_display_k8s_context no
set -g theme_display_hg no
set -g theme_display_virtualenv no
set -g theme_display_ruby no
set -g theme_display_nvm no
set -g theme_display_user ssh
set -g theme_display_hostname ssh
set -g theme_display_vi no
set -g theme_display_date yes
set -g theme_display_cmd_duration no
set -g theme_title_display_process no
set -g theme_title_display_path no
set -g theme_title_display_user yes
set -g theme_title_use_abbreviated_path no
set -g theme_date_format "+%a %H:%M"
set -g theme_date_timezone Europe/Madrid
set -g theme_avoid_ambiguous_glyphs yes
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g theme_display_jobs_verbose no
set -g default_user your_normal_user
set -g theme_color_scheme nord
set -g fish_prompt_pwd_dir_length 0
set -g theme_project_dir_length 1
set -g theme_newline_cursor no
set -g theme_newline_prompt '$ '
