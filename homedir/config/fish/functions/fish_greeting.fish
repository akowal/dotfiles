function fish_greeting
  set_color $fish_color_autosuggestion
  uname -nmsr
  uptime
  set_color $fish_color_quote
  echo "Good day, commander!"
  set_color normal
end
