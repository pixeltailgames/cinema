-- Basic information
LANG.Name		= "Česky"	-- Native name for language
LANG.Id			= "cs"		-- Find corresponding ID in garrysmod/resource/localization
LANG.Author		= "MatesakCZ"		-- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema						= "CINEMA"
LANG.Volume						= "Hlasitost"
LANG.Voteskips					= "Hlasy o přeskočení"
LANG.Loading					= "Načítání..."
LANG.Invalid					= "[NEPLATNÝ]"
LANG.NoVideoPlaying				= "Nepřehrává se žádné video"
LANG.Cancel						= "Zrušit"
LANG.Set						= "Nastavit"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy 		= C("Současné video vyžádáno hráčem ",ColHighlight,"%s",ColDefault,".")
LANG.Theater_InvalidRequest 		= "Neplatný video požadavek."
LANG.Theater_AlreadyQueued 			= "Požadované video je již ve frontě."
LANG.Theater_ProcessingRequest 		= C("Zpracovává se ",ColHighlight,"%s",ColDefault," požadavek...")
LANG.Theater_RequestFailed 			= "Nastal problém při zpracování požadovaného videa."
LANG.Theater_Voteskipped 			= "Současné video bylo přeskočeno hlasováním."
LANG.Theater_ForceSkipped 			= C(ColHighlight,"%s",ColDefault," vynutil/a přeskočení současného videa.")
LANG.Theater_PlayerReset 			= C(ColHighlight,"%s",ColDefault," resetoval/a kino.")
LANG.Theater_LostOwnership 			= "Ztratil/a jsi vlastnictví kina z důvodu jeho opuštění."
LANG.Theater_NotifyOwnership 		= "Jsi nyní majitelem tohoto soukromého kina."
LANG.Theater_OwnerLockedQueue 		= "Majitel kina uzamkl frontu videí."
LANG.Theater_LockedQueue 			= C(ColHighlight,"%s",ColDefault," uzamkl/a frontu videí.")
LANG.Theater_UnlockedQueue 			= C(ColHighlight,"%s",ColDefault," odemkl/a frontu videí.")
LANG.Theater_OwnerUseOnly 			= "Toto může použít pouze majitel kina."
LANG.Theater_PublicVideoLength 		= "Videa vyžádaná ve veřejných kinech jsou omezena na maximální délku %s sekund."
LANG.Theater_PlayerVoteSkipped 		= C(ColHighlight,"%s",ColDefault," hlasoval/a pro přeskočení ",ColHighlight,"(%s/%s)",ColDefault,".")
LANG.Theater_VideoAddedToQueue 		= C(ColHighlight,"%s",ColDefault," bylo přidáno do fronty.")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1	= "Současná mapa není podporována herním módem Cinema."
LANG.Warning_Unsupported_Line2	= "Stiskněte F1 pro otevření oficiální mapy ve workshopu."
LANG.Warning_OSX_Line1			= "Uživatelé Mac OS X mohou v Cinema módu vidět prázdné obrazovky"
LANG.Warning_OSX_Line2			= "Stiskněte F1 pro zobrazení tipů pro odstraňování problémů a skrytí této zprávy"

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title				= "FRONTA"
LANG.Request_Video 				= "Vyžádat video"
LANG.Vote_Skip 					= "Hlasovat o přeskočení"
LANG.Toggle_Fullscreen 			= "Na celou obrazovku"
LANG.Refresh_Theater			= "Obnovit kino"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin				= "ADMIN"
LANG.Theater_Owner				= "MAJITEL"
LANG.Theater_Skip				= "Přeskočit"
LANG.Theater_Seek				= "Přetočit"
LANG.Theater_Reset				= "Reset"
LANG.Theater_ChangeName			= "Změnit jméno"
LANG.Theater_QueueLock			= "Přepnout zámek fronty"
LANG.Theater_SeekQuery			= "HH:MM:SS nebo počet sekund (např. 1:30:00 nebo 5400)"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing		= "NYNÍ SE PROMÍTÁ"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History			= "HISTORIE"
LANG.Request_Clear				= "Vyčistit"
LANG.Request_DeleteTooltip		= "Odstranit video z historie"
LANG.Request_PlayCount			= "%d vyžádáno" -- e.g. 10 request(s)
LANG.Request_Url				= "Vyžádat video"
LANG.Request_Url_Tooltip		= "Stiskněte pro vyžádání platného videa.\nTlačítko zčervená když je URL platná"

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title				= "NASTAVENÍ"
LANG.Settings_ClickActivate		= "KLIKNĚTE PRO AKTIVACI KURZORU MYŠI"
LANG.Settings_VolumeLabel		= "Hlasitost"
LANG.Settings_VolumeTooltip		= "Stiskněte klávesy +/- pro zvýšení/snížení hlasitosti."
LANG.Settings_HDLabel			= "Přehrávat videa v HD"
LANG.Settings_HDTooltip			= "Zapnout přehrávání videí v HD kvalitě, pokud to podporují."
LANG.Settings_HidePlayersLabel	= "Skrýt hráče v kinech"
LANG.Settings_HidePlayersTooltip = "Redukuje viditelnost hráčů uvnitř kin."
LANG.Settings_MuteFocusLabel	= "Ztišit zvuk při alt-tab"
LANG.Settings_MuteFocusTooltip	= "Ztiší zvuk v kině když je okno Garry's Mod neaktivní (např. při stisknutí alt-tab)."

-- Video Services
LANG.Service_EmbedDisabled 		= "Požadované video má zakázáno vkládání."
LANG.Service_PurchasableContent = "Požadované video je zakoupitelný obsah a nemůže být přehráno."
LANG.Service_StreamOffline 		= "Požadovaný stream je offline."

-- Version 1.1
LANG.TranslationsCredit = "Překlad: %s"