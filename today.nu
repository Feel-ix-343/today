#!/usr/bin/env nu


def main [change: int = 0, --gui, --hx, --x, --c] {
    let day = (date now) + ($"($change)day" | into duration)
    let day = ($day | date to-record)
    cd ~/notes

    let month = if $day.month <  10 {
      "0" + ($day.month | into string)
    } else {
      $day.month | into string
    }

    let day_num = if $day.day < 10 {
      "0" + ($day.day | into string)
    } else {
      $day.day | into string
    }

    let file = $"($day.year)-($month)-($day_num).md"

    if $gui {
      neovide $file
    } else if $hx {
      hx $file
    } else if $x {
      if (not ($file | path exists)) { touch $file }
      codex --skip-git-repo-check $"Use the file '($file)' in this directory as initial context for this session."
    } else if $c {
      if (not ($file | path exists)) { touch $file }
      claude --dangerously-skip-permissions --add-dir (pwd) $"Use the file '($file)' in this directory as initial context for this session."
    } else {
      nvim $file
    }

}
