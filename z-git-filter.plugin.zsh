# -*- mode: sh; sh-indentation: 4; indent-tabs-mode: nil; sh-basic-offset: 4; -*-

# Copyright (c) 2023 zero mobile

# According to the Zsh Plugin Standard:
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html

0=${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}
0=${${(M)0:#/*}:-$PWD/$0}

# Then ${0:h} to get plugin's directory

if [[ ${zsh_loaded_plugins[-1]} != */z-git-filter && -z ${fpath[(r)${0:h}/functions]} ]] {
    fpath+=( "${0:h}/functions" )
}

vars=(thing 1 thing 2)
onetoten(){
for i in vars
do
    echo "$i"
done
}

# vars=(thing 1 thing 2)
# addtovars(){
#     $vars+="$1"
# }
# printvars(){
#     for i in $vars; do
#         echo $i;
#     done
# }

gunadd(){
case "$1" in
    stg)
        git status -s | rg "^A.? *" -r "" | xargs git restore --staged
        ;;
    dir)
        git status -s | rg "^.?A *" -r "" | xargs git restore 
        ;;
    *)
        echo "Usage: gunadd {stg|dir} <pattern> to unadd staged files or working directory files"
esac
}
gundel(){
case "$1" in
    stg)
        git status -s | rg "^D *" -r "" | xargs git restore --staged
        ;;
    dir)
        git status -s | rg "^.?D *" -r "" | xargs git restore 
        ;;
    *)
        echo "Usage: gundel {stg|dir} <pattern> to undelete staged files or working directory files"
esac
}
gexc(){
case "$1" in
    stg)
        git status -s | rg -v "^R" | rg "^.{0, 2} *" -r "" | rg "$2" | xargs git restore --staged
        ;;
    dir)
        git status -s | rg -v "^.R" | rg "^.{0, 2} *" -r "" | rg "$2" | xargs git restore 
        ;;
    *)
        echo "Usage: gexc {stg|dir} to except (restore) staged files or working directory files"
esac
}
# Standard hash for plugins, to not pollute the namespace
typeset -gA Plugins
Plugins[Z_GIT_FILTER_DIR]="${0:h}"


# Use alternate vim marks [[[ and ]]] as the original ones can
# confuse nested substitutions, e.g.: ${${${VAR}}}

