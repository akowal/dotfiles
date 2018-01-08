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

info "Configuring keyboard"
# full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
# illuminate keyboard in low light
defaults write com.apple.BezelServices kDim -bool true
# turn off illumination if idle for 5 min
defaults write com.apple.BezelServices kDimTime -int 300
# use F-keys by default
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

#info "Configuring locale and languages"
defaults write NSGlobalDomain AppleLanguages -array "en_SE" "ru_SE" "sv_SE"
defaults write NSGlobalDomain AppleLocale -string "en_SE"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

#info "Configuring power management" 
# on battery
#sudo pmset -b sleep 30
#sudo pmset -b displaysleep 10
#sudo pmset -b disksleep 10
# on power adapter
#sudo pmset -c sleep 0
#sudo pmset -c displaysleep 10
#sudo pmset -c disksleep 10
#sudo pmset -c womp 1
#defaults write com.apple.menuextra.battery ShowPercent -string "YES"

info "Configuring Finder" 
chflags nohidden ~/Library
sudo chflags nohidden /Volumes
defaults write com.apple.finder NewWindowTargetPath "file://$HOME"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
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

info "Configuring Transmission" 
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "$HOME/Downloads/Incomplete"
defaults write org.m0k.transmission DownloadAsk -bool false
defaults write org.m0k.transmission MagnetOpenAsk -bool false
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true
defaults write org.m0k.transmission WarningDonate -bool false
defaults write org.m0k.transmission WarningLegal -bool false
defaults write org.m0k.transmission CheckRemoveDownloading -bool true

info "Configuring iTerm2" 
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.config/iterm2"

info "Configuring dock"
dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/Telegram.app"
dockutil --no-restart --add "/Applications/Spotify.app"

killall Dock

