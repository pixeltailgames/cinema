-- Basic information
LANG.Name       = "English" -- Native name for language
LANG.Id         = "en"      -- Find corresponding ID in garrysmod/resource/localization
LANG.Author     = ""        -- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema                     = "CINEMA"
LANG.Volume                     = "Volume"
LANG.Voteskips                  = "Voteskips"
LANG.Loading                    = "Loading..."
LANG.Invalid                    = "[INVALID]"
LANG.NoVideoPlaying             = "No video playing"
LANG.Cancel                     = "Cancel"
LANG.Set                        = "Set"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy       = C("Current video requested by ",ColHighlight,"%s",ColDefault,".")
LANG.Theater_InvalidRequest         = "Invalid video request."
LANG.Theater_AlreadyQueued          = "The requested video is already in the queue."
LANG.Theater_ProcessingRequest      = C("Processing ",ColHighlight,"%s",ColDefault," request...")
LANG.Theater_RequestFailed          = "There was a problem processing the requested video."
LANG.Theater_Voteskipped            = "The current video has been voteskipped."
LANG.Theater_ForceSkipped           = C(ColHighlight,"%s",ColDefault," has forced to skip the current video.")
LANG.Theater_PlayerReset            = C(ColHighlight,"%s",ColDefault," has reset the theater.")
LANG.Theater_LostOwnership          = "You have lost theater ownership due to leaving the theater."
LANG.Theater_NotifyOwnership        = "You're now the owner of the private theater."
LANG.Theater_OwnerLockedQueue       = "The owner of the theater has locked the queue."
LANG.Theater_LockedQueue            = C(ColHighlight,"%s",ColDefault," has locked the theater queue.")
LANG.Theater_UnlockedQueue          = C(ColHighlight,"%s",ColDefault," has unlocked the theater queue.")
LANG.Theater_OwnerUseOnly           = "Only the theater owner can use that."
LANG.Theater_PublicVideoLength      = "Public theater requests are limited to %s second(s) in length."
LANG.Theater_PlayerVoteSkipped      = C(ColHighlight,"%s",ColDefault," has voted to skip ",ColHighlight,"(%s/%s)",ColDefault,".")
LANG.Theater_VideoAddedToQueue      = C(ColHighlight,"%s",ColDefault," has been added to the queue.")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1  = "The current map is unsupported by the Cinema gamemode"
LANG.Warning_Unsupported_Line2  = "Press F1 to open the official map on workshop"
LANG.Warning_OSX_Line1          = "Mac OS X users may experience blank screens in Cinema"
LANG.Warning_OSX_Line2          = "Press F1 to view troubleshooting tips and to remove this message"

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title                = "QUEUE"
LANG.Request_Video              = "Request Video"
LANG.Vote_Skip                  = "Vote Skip"
LANG.Toggle_Fullscreen          = "Toggle Fullscreen"
LANG.Refresh_Theater            = "Refresh Theater"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin              = "ADMIN"
LANG.Theater_Owner              = "OWNER"
LANG.Theater_Skip               = "Skip"
LANG.Theater_Seek               = "Seek"
LANG.Theater_Reset              = "Reset"
LANG.Theater_ChangeName         = "Change Name"
LANG.Theater_QueueLock          = "Toggle Queue Lock"
LANG.Theater_SeekQuery          = "HH:MM:SS or number of seconds (e.g. 1:30:00 or 5400)"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing     = "NOW SHOWING"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History            = "HISTORY"
LANG.Request_Clear              = "Clear"
LANG.Request_DeleteTooltip      = "Remove video from history"
LANG.Request_PlayCount          = "%d request(s)" -- e.g. 10 request(s)
LANG.Request_Url                = "Request URL"
LANG.Request_Url_Tooltip        = "Press to request a valid video URL.\nThe button will be red when the URL is valid"

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title             = "SETTINGS"
LANG.Settings_ClickActivate     = "CLICK TO ACTIVATE YOUR MOUSE"
LANG.Settings_VolumeLabel       = "Volume"
LANG.Settings_VolumeTooltip     = "Use the +/- keys to increase/decrease volume."
LANG.Settings_HDLabel           = "HD Video Playback"
LANG.Settings_HDTooltip         = "Enable HD video playback for HD enabled videos."
LANG.Settings_HidePlayersLabel  = "Hide Players In Theater"
LANG.Settings_HidePlayersTooltip = "Reduce player visibility inside of theaters."
LANG.Settings_MuteFocusLabel    = "Mute audio while alt-tabbed"
LANG.Settings_MuteFocusTooltip  = "Mute theater volume while Garry's Mod is out-of-focus (e.g. you alt-tabbed)."

-- Video Services
LANG.Service_EmbedDisabled      = "The requested video is embed disabled."
LANG.Service_PurchasableContent = "The requested video is purchasable content and can't be played."
LANG.Service_StreamOffline      = "The requested stream is offline."

-- Act command (don't bother translating this)
-- modules/taunts/sv_commands.lua
LANG.ActCommand = C(ColHighlight,"%s",ColDefault," %ss") -- e.g. Sam dances

-- Version 1.1
LANG.TranslationsCredit = "Translations by %s"