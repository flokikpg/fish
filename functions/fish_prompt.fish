function fish_prompt
    set -l last_status $status

    # ── TokyoNight colors ────────────────────
    set -l blue     7aa2f7
    set -l cyan     7dcfff
    set -l green    9ece6a
    set -l purple   bb9af7
    set -l red      f7768e
    set -l yellow   e0af68
    set -l grey     565f89

    # ── OS / SSH icon ────────────────────────
    set -l os_icon "󰍹"
    if test -f /etc/arch-release
        set os_icon ""
    else if test -f /etc/debian_version
        set os_icon ""
    else if test -f /etc/fedora-release
        set os_icon ""
    end

    if set -q SSH_CONNECTION
        set os_icon "󰢩"
    end

    set_color $cyan
    echo -n "$os_icon "

    # ── Username (root-aware) ────────────────
    if test (id -u) -eq 0
        set_color $red
    else
        set_color $blue
    end
    echo -n $USER

    set_color normal
    echo -n ' '

    # ── Path ─────────────────────────────────
    set_color $green
    echo -n (prompt_pwd)

    # ── Git branch + state ───────────────────
    set -l git_prompt (fish_git_prompt)
    if test -n "$git_prompt"
        set_color $purple
        echo -n " $git_prompt"

        # Repo depth
        set -l depth (count (string split / (command git rev-parse --show-toplevel 2>/dev/null)))
        if test $depth -gt 1
            set_color $grey
            echo -n " ▸$depth"
        end
    end

    # ── Language indicators ──────────────────
    set_color $yellow
    if test -f Cargo.toml
        echo -n " "
    end
    if test -f package.json
        echo -n " "
    end
    if set -q VIRTUAL_ENV
        echo -n " "
    end

    # ── Exit status ──────────────────────────
    if test $last_status -ne 0
        set_color $red
        echo -n " ✗$last_status"
    end

    # ── New line + prompt arrow ──────────────
    set_color normal
    echo
    set_color $blue
    echo -n '❯ '
    set_color normal
end

    function fish_right_prompt
    set_color 565f89
    date "+%H:%M"
end


