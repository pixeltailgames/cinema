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

-- Rentable Theater System
-- modules/scoreboard/cl_rent.lua
-- modules/theater/sh_rent.lua
LANG.Theater_RentTimeRemaining  = "Time Remaining: %s"
LANG.Theater_RentOwner          = "Owner: %s"
LANG.Theater_RentOwnerNone      = "Owner: NONE"
LANG.Theater_AddRent            = "Add Rent Time"
LANG.Theater_RentTime           = "Rent Time (Minutes)"
LANG.Theater_RentCost           = "Cost: %s Points"
LANG.Theater_NoOwner            = "This theater has no owner. Rent it if you want to queue a video."
LANG.Theater_NotifyRentExpiring = C("Your Rent is expiring in ", ColHighlight, "%s", ColDefault, " in 5 minutes.")
LANG.Theater_NotifyRentExpired  = C("Your Rent has expired in ", ColHighlight, "%s", ColDefault, ".")
LANG.Theater_RentExpired        = C(ColHighlight, "Rent has expired.", ColDefault, " This theater no longer has an owner.")
LANG.Theater_QueueClearWarning  = "The queue will be cleared if there is no new owner within 5 minutes."
LANG.Theater_QueueClearExecuted = "The queue was cleared as there was no new owner within 5 minutes."
LANG.Theater_RentablesNotEnabled = "The Rentables System is not enabled. To enable it, the server owner must run cinema_rentables 1 in server console or add it to server config."
LANG.Theater_RentLessThan10Minutes = "You can't rent a theater for less than 10 minutes."
LANG.Theater_RentMoreThanOne     = "You can't rent more than one theater."
LANG.Theater_RentNotEnoughPoints = "You don't have enough Points to do that."
LANG.Theater_RentedFor           = C("Theater rented for ", ColHighlight, "%s", ColDefault, ".")
LANG.Theater_AddedRentTime       = C("Added ", ColHighlight, "%s", ColDefault, " of Rent Time to the theater.")
LANG.Theater_InvalidRentOwner    = "You can't rent right now, the theater owner data is invalid (most likely left the server). Please wait for rent to expire or for the owner to rejoin."
LANG.Theater_ReacquiredOwnership = C("Ownership of ", ColHighlight, "%s", ColDefault, " reacquired! You have ", ColHighlight, "%s", ColDefault, " of Rent Time remaining.")

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