-- Basic information
LANG.Name               = "Norwegian"       -- Native name for language
LANG.Id                 = "no"              -- Find corresponding ID in garrysmod/resource/localization
LANG.Author             = "DoleDuck"        -- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema             = "KINO"
LANG.Volume             = "Volum"
LANG.Voteskips          = "Har stemt for å hoppe over"
LANG.Loading            = "Lader..."
LANG.Invalid            = "[UGYLDIG]"
LANG.NoVideoPlaying     = "Ingen Video Spiller"
LANG.Cancel             = "Avbryt"
LANG.Set                = "Sett"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy           = C("Denne video er forespurt av ",ColHighlight,"%s",ColDefault,".")
LANG.Theater_InvalidRequest             = "Ugyldig video forespørsel."
LANG.Theater_AlreadyQueued              = "Den forespurte videoen er allerede i køen."
LANG.Theater_ProcessingRequest          = C("Behandler ",ColHighlight,"%s",ColDefault," forespørsel...")
LANG.Theater_RequestFailed              = "Det var et problem med å behandle den forespurte videoen."
LANG.Theater_Voteskipped                = "Den gjeldende videoen har blitt stemt bort."
LANG.Theater_ForceSkipped               = C(ColHighlight,"%s",ColDefault," har hoppet over denne videoen.")
LANG.Theater_PlayerReset                = C(ColHighlight,"%s",ColDefault," har tilbakestillt kinoen.")
LANG.Theater_LostOwnership              = "Du har mistet eierskapet fordi du har forlatt kinoen."
LANG.Theater_NotifyOwnership            = "Du er nå eieren av denne kinoen."
LANG.Theater_OwnerLockedQueue           = "Eieren av kinoen har stengt køen."
LANG.Theater_LockedQueue                = C(ColHighlight,"%s",ColDefault," har stengt køen.")
LANG.Theater_UnlockedQueue              = C(ColHighlight,"%s",ColDefault," har åpnet køen.")
LANG.Theater_OwnerUseOnly               = "Bare eieren av kinoen kan gjøre det."
LANG.Theater_PublicVideoLength          = "Forespørsler i offentlige kinoer har en frist på %s sekund(er)."
LANG.Theater_PlayerVoteSkipped          = C(ColHighlight,"%s",ColDefault," har stemt for å hoppe over ",ColHighlight,"(%s/%s)",ColDefault,".")
LANG.Theater_VideoAddedToQueue          = C(ColHighlight,"%s",ColDefault," har blitt lagt til i køen.")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1          = "Den gjeldene banen er ikke støtter av Cinema gamemode"
LANG.Warning_Unsupported_Line2          = "Trykk F1 for å åpne den offisielle banen i workshop"
LANG.Warning_OSX_Line1                  = "Mac OS X brukere kan erfare blanke skjermer i Cinema"
LANG.Warning_OSX_Line2                  = "Trykk F! for å se feilsøke tips og for å fjerne denne beskjeden"

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title                        = "KØ"
LANG.Request_Video                      = "Spør om en video"
LANG.Vote_Skip                          = "Stem for å hoppe over"
LANG.Toggle_Fullscreen                  = "Veksle mellom fullskjerm"
LANG.Refresh_Theater                    = "Oppdater Kino"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin                      = "ADMIN"
LANG.Theater_Owner                      = "EIER"
LANG.Theater_Skip                       = "Hopp over"
LANG.Theater_Seek                       = "Søk"
LANG.Theater_Reset                      = "Tilbakestill"
LANG.Theater_ChangeName                 = "Bytt navn"
LANG.Theater_QueueLock                  = "Lås/åpne køen"
LANG.Theater_SeekQuery                  = "HH:MM:SS eller antall sekunder (f.eks. 1:30:00 eller 5400)"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing             = "VISER NÅ"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History                    = "HISTORIE"
LANG.Request_Clear                      = "Slett"
LANG.Request_DeleteTooltip              = "Fjern video fra histore"
LANG.Request_PlayCount                  = "%d forespørsel(er)" -- e.g. 10 request(s)
LANG.Request_Url                        = "Be om en URL"
LANG.Request_Url_Tooltip                = "Klikk for å be om en gyldig video URL.\nKnappen vil bli rød når URL'en er ugyldig"

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title                     = "INNSTILLINGER"
LANG.Settings_ClickActivate             = "KLIKK FOR Å AKTIVERE MUSEN"
LANG.Settings_VolumeLabel               = "Volum"
LANG.Settings_VolumeTooltip             = "Bruk +/- tastene for å øke/redusere volumet."
LANG.Settings_HDLabel                   = "HD Video Avspilling"
LANG.Settings_HDTooltip                 = "Aktiver HD video avspilling for HD-aktiverte videoer."
LANG.Settings_HidePlayersLabel          = "Skjul Spillere I Kino"
LANG.Settings_HidePlayersTooltip        = "Reduser spiller synlighet inne i kinoene."
LANG.Settings_MuteFocusLabel            = "Skru av lyd mens du er alt-tabbet"
LANG.Settings_MuteFocusTooltip          = "Skru av kino lyden mens Garry's Mod er ute av fokus (f.eks. i alt-tab)."

-- Video Services
LANG.Service_EmbedDisabled              = "Innholdet til den følgende videoen er slått av."
LANG.Service_PurchasableContent         = "Den forespurte videoen er kjøpt innhold og kan ikke bli spilt av."
LANG.Service_StreamOffline              = "Den forespurte stream er offline."

-- Version 1.1
LANG.TranslationsCredit                 = "Oversettelse av %s"