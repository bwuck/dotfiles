function fish_user_key_bindings
  fzf_key_bindings

  # User defined key bindings.
  bind \cl fzf-cd-widget
  if bind -M insert > /dev/null 2>&1
      bind -M insert \cl fzf-cd-widget
  end
end
