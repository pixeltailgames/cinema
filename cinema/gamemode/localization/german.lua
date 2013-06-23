-- Basic information
LANG.Name	    = "Deutsch"	-- Native name for language
LANG.Id			= "de"		-- Find corresponding ID in garrysmod/resource/localization
LANG.Author		= "Sapd"	-- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Volume						= "Lautstärke"
LANG.Voteskips					= "Abwählungen" -- Sounds weird, but no other short word/sentence.
LANG.Loading					= "Lade..."
LANG.Invalid					= "[UNGÜLTIG]"
LANG.NoVideoPlaying				= "Kein aktives Video"
LANG.Cancel						= "Abbrechen"
LANG.Set						= "Anwenden"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy		= C("Aktuelles Video angefordert von ",ColHighlight,"%s",ColDefault,".")
LANG.Theater_InvalidRequest 		= "Ungültiger Video Wunsch."
LANG.Theater_AlreadyQueued 			= "Das angeforderte Video ist bereits in der Warteschlange."
LANG.Theater_ProcessingRequest 		= C("Verarbeite ",ColHighlight,"%s",ColDefault," Wunsch...")
LANG.Theater_RequestFailed 			= "Es gab ein Problem bei der Verarbeitung des angeforderten Videos."
LANG.Theater_Voteskipped 			= "Das aktuelle Video wurde abgewählt." -- Using "abgewählt" as neologism
LANG.Theater_ForceSkipped 			= C(ColHighlight,"%s",ColDefault," hat das Überspringen des Videos erzwungen.")
LANG.Theater_PlayerReset 			= C(ColHighlight,"%s",ColDefault," hat das Theater zurückgesetzt.")
LANG.Theater_LostOwnership 			= "Da du das Theater verlassen hast, bist du nicht mehr der Besitzer."
LANG.Theater_NotifyOwnership 		= "Du bist nun der Besitzer des privaten Theaters."
LANG.Theater_OwnerLockedQueue 		= "Der Besitzer des Theaters hat die Warteschlange gesperrt."
LANG.Theater_LockedQueue 			= C(ColHighlight,"%s",ColDefault," hat die Warteschlange des Theaters gesperrt.")
LANG.Theater_UnlockedQueue 			= C(ColHighlight,"%s",ColDefault," hat die Warteschlange des Theaters freigegeben.")
LANG.Theater_OwnerUseOnly 			= "Nur der Besitzer des Theaters kann das benutzen."
LANG.Theater_PublicVideoLength 		= "Videowünsche in öffentlichen Theatern sind auf %s Sekunden begrenzt."
LANG.Theater_PlayerVoteSkipped 		= C(ColHighlight,"%s",ColDefault," hat dafür gestimmt, das Video zu überspringen ",ColHighlight,"(%s/%s)",ColDefault,".")
LANG.Theater_VideoAddedToQueue 		= C(ColHighlight,"%s",ColDefault," wurde zur Warteschlange hinzugefügt.")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1	= "Die aktuelle Map wird nicht vom Cinema Gamemode unterstützt."
LANG.Warning_Unsupported_Line2	= "Drücke F1 um die offizielle Map im Workshop zu öffnen."
LANG.Warning_OSX_Line1			= "Eventuell erhalten Mac OS X Benutzer ein schwarzes Bild auf der Leinwand"
LANG.Warning_OSX_Line2			= "Drücke F1 um Tipps bei der Fehlerbehebung zu bekommen und um diese Nachricht zu schließen."

-- Queue
-- modules/scoreboard/cl_queue.lua
-- In English the 2nd Words are also written with capital Letters.
-- But here in German I need up to 3 words, it would look weird here
LANG.Queue_Title				= "WARTESCHLANGE"
LANG.Request_Video 				= "Video anfordern"
LANG.Vote_Skip 					= "Für Überspringen stimmen"
LANG.Toggle_Fullscreen 			= "Vollbildmodus umschalten"
LANG.Refresh_Theater			= "Theater neu laden"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin				= "ADMIN"
LANG.Theater_Owner				= "BESITZER"
LANG.Theater_Skip				= "Überspringen"
LANG.Theater_Seek				= "Starten bei..." -- There is no direct translation for "seek" so I use "start at ...", just like youtube
LANG.Theater_Reset				= "Zurücksetzen"
LANG.Theater_ChangeName			= "Name ändern"
LANG.Theater_QueueLock			= "Warteliste ein/aus" -- Warteschlange also sounds better here, but doesn't fit
LANG.Theater_SeekQuery			= "HH:MM:SS oder Zeit in Sekunden (z.B. 1:30:00 oder 5400)" -- h also stands in german for hours

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing		= "AKTUELLE VORFÜHRUNGEN"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History			= "VERLAUF"
LANG.Request_Clear				= "Verlauf löschen"
LANG.Request_DeleteTooltip		= "Video vom Verlauf entfernen"
LANG.Request_PlayCount			= "Bereits %d Mal Angefordert" -- e.g. 10 request(s)
LANG.Request_Url				= "URL Anfordern"
LANG.Request_Url_Tooltip		= "Drücken um einen gültigen Video Link anzufordern.\nDer Button wird rot sobald der Link gültig ist."

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title					= "EINSTELLUNGEN"
LANG.Settings_ClickActivate			= "KLICKEN UM MAUS ZU AKTIVIEREN"
LANG.Settings_VolumeLabel			= "Lautstaerke" -- Can't use umlaut Ä here, because the gamemode somehow try's to convert the word to uppercase (even if it is already written so). And so the small letter ä would stand there, instead of Ä.
LANG.Settings_VolumeTooltip			= "Benutze die +/- Tasten um die Lautstärke zu erhöhen/senken."
LANG.Settings_HDLabel				= "HD Video Wiedergabe"
LANG.Settings_HDTooltip				= "Aktiviert die HD Wiedergabe für HD fähige Videos."
LANG.Settings_HidePlayersLabel		= "Spieler im Theater ausblenden"
LANG.Settings_HidePlayersTooltip 	= "Reduziert die Sichtbarkeit der Spieler innerhalb der Theater."
LANG.Settings_MuteFocusLabel		= "Im Hintergrund stummschalten"
LANG.Settings_MuteFocusTooltip		= "Theater Audio stummschalten während Garrysmod minimiert ist."

-- Video Services
LANG.Service_EmbedDisabled			= "Das angeforderte Video hat die Einbettung deaktiviert."
LANG.Service_PurchasableContent		= "Das angeforderte Video ist kaufbar und kann somit nicht abgespielt werden."
LANG.Service_StreamOffline 			= "Der angeforderte Stream ist offline."

