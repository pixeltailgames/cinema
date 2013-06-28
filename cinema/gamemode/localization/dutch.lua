	-- Basic information
LANG.Name    = "Nederlands"  -- Native name for language
LANG.Id      = "nl"    -- Find corresponding ID in garrysmod/resource/localization
LANG.Author    = "Ubister"    -- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema            = "CINEMA"
LANG.Volume            = "Volume"
LANG.Voteskips          = "Stemmen om over te slaan" --I could not make this any shorter and let it keep the correct meaning ~Ubi
LANG.Loading          = "Laden..."
LANG.Invalid          = "[ONGELDIG]"
LANG.NoVideoPlaying        = "Geen afspelende video"
LANG.Cancel            = "Annuleer"
LANG.Set            = "Instellen"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy     = C("Deze video is verzocht door ",ColHighlight,"%s",ColDefault,".")
LANG.Theater_InvalidRequest     = "Ongeldig videoverzoek."
LANG.Theater_AlreadyQueued       = "De verzochte video is al in de rij."
LANG.Theater_ProcessingRequest     = C("Verzoek ",ColHighlight,"%s",ColDefault," verwerken...")
LANG.Theater_RequestFailed       = "Er trad een probleem op bij het verwerken van de verzochte video."
LANG.Theater_Voteskipped       = "Deze video is weggestemd."
LANG.Theater_ForceSkipped       = C(ColHighlight,"%s",ColDefault," heeft deze video overgeslagen.")
LANG.Theater_PlayerReset       = C(ColHighlight,"%s",ColDefault," heeft de bioscoop gereset.")
LANG.Theater_LostOwnership       = "Je hebt hebt het eigenaarschap over deze bioscoop verloren omdat je het hebt verlaten."
LANG.Theater_NotifyOwnership     = "Je bent nu de eigenaar van deze privébioscoop."
LANG.Theater_OwnerLockedQueue     = "De bioscoopeigenaar heeft de rij gesloten."
LANG.Theater_LockedQueue       = C(ColHighlight,"%s",ColDefault," heeft de rij gesloten.")
LANG.Theater_UnlockedQueue       = C(ColHighlight,"%s",ColDefault," heeft de rij geopend")
LANG.Theater_OwnerUseOnly       = "Alleen de bioscoopeigenaar kan dit doen."
LANG.Theater_PublicVideoLength     = "Verzoeken in openbare bioscopen hebben een tijdslimiet van $s seconde(n)"
LANG.Theater_PlayerVoteSkipped     = C(ColHighlight,"%s",ColDefault," heeft gestemd om ",ColHighlight,"(%s/%s)",ColDefault,"over te slaan.")
LANG.Theater_VideoAddedToQueue     = C(ColHighlight,"%s",ColDefault," is aan de rij toegevoegd")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1  = "De huidige map wordt niet ondersteunt door de Cinema gamemode"
LANG.Warning_Unsupported_Line2  = "Druk op F1 om de officiële map te openen in workshop"
LANG.Warning_OSX_Line1      = "Mac OS X gebruikers krijgen moegelijk een wit scherm te zien in Cinema"
LANG.Warning_OSX_Line2      = "Druk op F1 om probleemoplostips te zien en dit bericht weg te halen"

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title        = "RIJ"
LANG.Request_Video         = "Verzoek Video"
LANG.Vote_Skip           = "Wegstemmen"
LANG.Toggle_Fullscreen       = "Schakel Vol Scherm In"
LANG.Refresh_Theater      = "Bioscoop Verversen"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin        = "ADMIN"
LANG.Theater_Owner        = "EIGENAAR"
LANG.Theater_Skip        = "Overslaan"
LANG.Theater_Seek        = "Zoek"
LANG.Theater_Reset        = "Reset"
LANG.Theater_ChangeName      = "Wijzig Naam"
LANG.Theater_QueueLock      = "Sluit Rij"
LANG.Theater_SeekQuery      = "HH:MM:SS of het aantal seconden (bv. 1:30:00 of 5400)"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing    = "NU OP"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History      = "GESCHIEDENIS"
LANG.Request_Clear        = "Wis"
LANG.Request_DeleteTooltip    = "Wis video uit geschiedenis"
LANG.Request_PlayCount      = "%d verzoek(en)" -- e.g. 10 request(s)
LANG.Request_Url        = "Verzoek URL"
LANG.Request_Url_Tooltip    = "Druk om een geldige video URL te verzoeken.\nDe knop is rood als de URL geldig is"

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title        = "INSTELLINGEN"
LANG.Settings_ClickActivate    = "KLIK OM JE MUIS TE ACTIVEREN"
LANG.Settings_VolumeLabel    = "Volume"
LANG.Settings_VolumeTooltip    = "Gebruik de +/- knoppen om je volume harder/zachter te zetten."
LANG.Settings_HDLabel      = "HD Video Weergave"
LANG.Settings_HDTooltip      = "HD weergave inschakelen voor HD video's."
LANG.Settings_HidePlayersLabel  = "Verberg Spelers In Bioscoop"
LANG.Settings_HidePlayersTooltip = "Verminder spelerzichtbaarheid binnen bioscopen."
LANG.Settings_MuteFocusLabel  = "Demp audio wanneer gealt-tabd" --Looks weird but it's correct Dutch grammar when considering ''alt tabbing'' as a verb ~Ubi
LANG.Settings_MuteFocusTooltip  = "Demp bioscoopvolume wanneer Garry's Mod niet geselecteerd is (bv. in alt-tab.)"

-- Video Services
LANG.Service_EmbedDisabled     = "Bij de verzochte video zijn insluitingen uitgeschakeld"
LANG.Service_PurchasableContent = "De verzochte video is koopbaar materiaal en kan niet afgesleepd worden."
LANG.Service_StreamOffline     = "De verzochte stream is offline."