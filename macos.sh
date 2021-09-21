#!/usr/bin/env sh

source functions.sh

info "Configuring trackpad"
# tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
# for login screen
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# 3-finter drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

info "Configuring keyboard"
# full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
# illuminate keyboard in low light
defaults write com.apple.BezelServices kDim -bool true
# turn off illumination if idle for 5 min
defaults write com.apple.BezelServices kDimTime -int 300
# use F-keys by default
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
defaults write com.apple.Accessibility KeyRepeat -int 2
defaults write com.apple.Accessibility InitialKeyRepeat -int 15
defaults write com.apple.Accessibility ApplePressAndHoldEnabled -bool false

info "Configuring Finder" 
chflags nohidden ~/Library
sudo chflags nohidden /Volumes
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.finder EmptyTrashSecurely -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

info "Configuring Dock" 
defaults write com.apple.dock mouse-over-hilite-stack -bool true
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock launchanim -bool true
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.15
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

info "Configuring some more system stuff" 
sudo nvram SystemAudioVolume=" "
defaults write com.apple.screencapture location ~/Pictures
defaults write com.apple.screencapture type -string "png"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write com.apple.CrashReporter DialogType -string "none"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 5
defaults write NSGlobalDomain AppleFontSmoothing -int 2 
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
defaults write com.apple.commerce AutoUpdate -bool true

info "Configuring iTerm2" 
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.config/iterm2"

info "Configuring dock"
dockutil --no-restart --remove all

killall Dock

