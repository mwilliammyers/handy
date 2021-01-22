# this is named 1-fzf.fish so it gets configured before any fzf.fish
if type -q 'fd'
    set -l exclude "-E .git/ -E '*target/ -E .Trash/ -E .trash/ -E '*Cache*/' -E '*cache*/' -E Applications/ -E Library/ -E 'Album Artwork/' -E .rustup/ -E registry/ -E .npm/ -E node_modules/ -E .node-gyp/ -E venv/ -E env/ -E .venv/ -E .env/ -E .apm/ -E packages/ -E pack/ -E '*.xcodeproj/'"
    
    set -q FZF_DEFAULT_COMMAND
    or set -Ux FZF_DEFAULT_COMMAND "fd -t f $exclude"
    
    set -q FZF_DEFAULT_OPTS
    or set -Ux FZF_DEFAULT_OPTS '--cycle --layout=reverse --height=33% --preview-window=wrap --marker="*"'
end
