mrs() {
  local path="$HOME/.multiruby/install/$1/bin:"
  if test "$1" = "system" -o "$1" = ""; then
    echo >&2 "using system"
    path=
  elif ! test -d "${path%:}"; then
    echo >&2 "$1 not available"
    return 1
  fi
  PATH="${path}$(printenv PATH | tr : '\n' | grep -v -e '/.gem/' -e '/.multiruby/' | tr '\n' :)"
  # 1.9 needs multiple paths :/
  export PATH="$(gem env path | sed 's@\(:\|$\)@/bin\1@g'):${PATH%:}"
}
_mrs() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  local prev=${COMP_WORDS[COMP_CWORD-1]}
  if [ $prev = "mrs" ]; then
    COMPREPLY=( $( cd $HOME/.multiruby/install; compgen -d -- $cur ) )
  fi
}
complete -F _mrs mrs
