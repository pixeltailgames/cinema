-- Basic information
LANG.Name       = "Pirate Speak" -- Native name for language
LANG.Id         = "en-PT"      -- Find corresponding ID in garrysmod/resource/localization
LANG.Author     = "HawkBlock"        -- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema                     = "CINEMA"
LANG.Volume                     = "Loudness"
LANG.Voteskips                  = "Mutinies"
LANG.Loading                    = "Sailing..."
LANG.Invalid                    = "[INVALID]"
LANG.NoVideoPlaying             = "No ships sailing"
LANG.Cancel                     = "Abandon ship"
LANG.Set                        = "Set"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy       = C("Commander of this ship be ",ColHighlight,"%s",ColDefault,".")
LANG.Theater_InvalidRequest         = "Invalid ship request."
LANG.Theater_AlreadyQueued          = "The requested ship already be in harbour."
LANG.Theater_ProcessingRequest      = C("Processing ",ColHighlight,"%s",ColDefault," request...")
LANG.Theater_RequestFailed          = "The requested ship sank."
LANG.Theater_Voteskipped            = "The ship's been taken over by rebellious crew!"
LANG.Theater_ForceSkipped           = C(ColHighlight,"%s",ColDefault," sank the vessel.")
LANG.Theater_PlayerReset            = C(ColHighlight,"%s",ColDefault," swabbed the poopdeck!")
LANG.Theater_LostOwnership          = "Ye've lost command of the harbour!"
LANG.Theater_NotifyOwnership        = "Yer the captain now!"
LANG.Theater_OwnerLockedQueue       = "The captain closed the harbour."
LANG.Theater_LockedQueue            = C(ColHighlight,"%s",ColDefault," closed the harbour.")
LANG.Theater_UnlockedQueue          = C(ColHighlight,"%s",ColDefault," opened the harbour.")
LANG.Theater_OwnerUseOnly           = "Only the captain can do that."
LANG.Theater_PublicVideoLength      = "New ship requests may only be %s second(s) in length."
LANG.Theater_PlayerVoteSkipped      = C(ColHighlight,"%s",ColDefault," sunk the ",ColHighlight,"(%s/%s)",ColDefault,"!")
LANG.Theater_VideoAddedToQueue      = C(ColHighlight,"%s",ColDefault," sailed into harbour.")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1  = "The current map be unsupported by the Cinema gamemode"
LANG.Warning_Unsupported_Line2  = "Press F1 to open the official map on workshop"
LANG.Warning_OSX_Line1          = "Mac OS X users may experience blank screens in Cinema"
LANG.Warning_OSX_Line2          = "Press F1 to view troubleshooting tips and to remove this message"

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title                = "Harbour (Queue)"
LANG.Request_Video              = "Add Ship (Request Video)"
LANG.Vote_Skip                  = "Join Mutiny (Voteskip)"
LANG.Toggle_Fullscreen          = "Toggle Fullscreen"
LANG.Refresh_Theater            = "Swab the Poopdeck (Reset Theater)"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin              = "HARBOURMASTER"
LANG.Theater_Owner              = "CAPTAIN"
LANG.Theater_Skip               = "Sink"
LANG.Theater_Seek               = "Seek"
LANG.Theater_Reset              = "Swab the Poopdeck (Reset)"
LANG.Theater_ChangeName         = "Rename Vessel"
LANG.Theater_QueueLock          = "Close the Harbour"
LANG.Theater_SeekQuery          = "HH:MM:SS or number of seconds (e.g. 1:30:00 or 5400)"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing     = "NOW SAILING"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History            = "Ledger"
LANG.Request_Clear              = "Erase"
LANG.Request_DeleteTooltip      = "Remove ship from Ledger"
LANG.Request_PlayCount          = "%d voyage(s)" -- e.g. 10 request(s)
LANG.Request_Url                = "Request Ship"
LANG.Request_Url_Tooltip        = "Press to request a valid video URL.\nThe button'll be red when the URL be valid"

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title             = "SETTINGS"
LANG.Settings_ClickActivate     = "CLICK TO COMMAND YER MOUSE"
LANG.Settings_VolumeLabel       = "Loudness"
LANG.Settings_VolumeTooltip     = "Use the +/- keys to increase/decrease volume."
LANG.Settings_HDLabel           = "Shiney new paint for yer vessel"
LANG.Settings_HDTooltip         = "Enable HD video playback for HD enabled videos."
LANG.Settings_HidePlayersLabel  = "Send crew to thar quarters."
LANG.Settings_HidePlayersTooltip = "Reduce player visibility inside of theaters."
LANG.Settings_MuteFocusLabel    = "Silence noises while in quarters"
LANG.Settings_MuteFocusTooltip  = "Mute theater volume while Garry's Mod be out-of-focus (e.g. you alt-tabbed)."

-- Video Services
LANG.Service_EmbedDisabled      = "The requested ship be unfit for the open sea."
LANG.Service_PurchasableContent = "The requested ship be too expensive to sail."
LANG.Service_StreamOffline      = "The requested ship be a ghost."

-- Act command (don't bother translating this)
-- modules/taunts/sv_commands.lua
LANG.ActCommand = C(ColHighlight,"%s",ColDefault," %ss") -- e.g. Sam dances

-- Version 1.1
LANG.TranslationsCredit = "Translations by %s"
