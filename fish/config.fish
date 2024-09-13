if status is-interactive
    # Commands to run in interactive sessions can go here
    alias vi='nvim'
    fish_add_path /Users/guushuizen/.local/bin/
    fish_add_path /Users/guushuizen/.composer/vendor/bin/

    set -Ux PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin

    pyenv init - | source

    set --global tide_right_prompt_items status git cmd_duration python
    set --global tide_left_prompt_items pwd character
end
