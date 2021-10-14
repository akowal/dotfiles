eval (/opt/homebrew/bin/brew shellenv)

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/andrew/google-cloud-sdk/path.fish.inc' ]; . '/Users/andrew/google-cloud-sdk/path.fish.inc'; end
status --is-interactive; and source (jenv init -|psub)
