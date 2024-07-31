#!/usr/bin/env nu


def main [change: int = 0, --gui] {
    let day = (date now) + ($"($change)day" | into duration)
    let day = ($day | date to-record)
    cd ~/Notes

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

    if $gui {
      neovide $"($day.year)-($month)-($day_num).md"
    } else {
      nvim $"($day.year)-($month)-($day_num).md"
    }

}
