function fish_prompt
    set_color cyan
    echo -n "┌─["

    set_color white
    echo -n (whoami)

    set_color green
    echo -n "@"

    set_color white
    echo -n $hostname

    set_color cyan
    echo -n "]["

    set_color blue
    echo -n (prompt_pwd)

    set_color cyan
    echo -n "]"

    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set branch (git branch --show-current)
        set dirty ""

        if not git diff --quiet --ignore-submodules HEAD >/dev/null 2>&1
            set dirty "*"
        end

        set_color cyan
        echo -n "["

        set_color magenta
        echo -n $branch

        set_color red
        echo -n $dirty

        set_color cyan
        echo -n "]"
    end

    echo

    set_color cyan
    echo -n "└─> "

    set_color normal
end
