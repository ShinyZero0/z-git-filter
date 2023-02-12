# -*- mode: sh; sh-indentation: 4; indent-tabs-mode: nil; sh-basic-offset: 4; -*-

# Copyright (c) 2023 zero mobile

# According to the Zsh Plugin Standard:
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html

0=${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}
0=${${(M)0:#/*}:-$PWD/$0}

# Then ${0:h} to get plugin's directory

if [[ ${zsh_loaded_plugins[-1]} != */z-git-filter && -z ${fpath[(r)${0:h}]} ]] {
    fpath+=( "${0:h}" )
}

gnoadd(){
case "$1" in
    dex)
        git status -s | ack --output="$'" "^A.? *"  | xargs git restore --staged
        ;;
    wd)
        git status -s | ack --output="$'" "^.?A *" | xargs git restore 
        ;;
    *)
        git status -s | ack --output="$'" "^A.? *" | xargs git restore --staged
esac
}
gnodel(){
    git status -s | ack --output="$'" "^D.? *" | xargs git restore --staged
}
# Standard hash for plugins, to not pollute the namespace
typeset -gA Plugins
Plugins[Z_GIT_FILTER_DIR]="${0:h}"


# Use alternate vim marks [[[ and ]]] as the original ones can
# confuse nested substitutions, e.g.: ${${${VAR}}}

