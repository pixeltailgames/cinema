-- Basic information
LANG.Name  	= "Suomi"	-- Native name for language
LANG.Id			= "fi"		-- Find corresponding ID in garrysmod/resource/localization
LANG.Author		= "Jani"		-- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema						= "CINEMA"
LANG.Volume						= "Äänenvoimakkuus"
LANG.Voteskips					= "Äänestys ohittamiseen"
LANG.Loading					= "Lataa..."
LANG.Invalid					= "[VIRHEELLINEN]"
LANG.NoVideoPlaying				= "Ei videota käynnissä"
LANG.Cancel						= "Peruuta"
LANG.Set						= "Valitse"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy 		= C("Tämänhetkistä videota on ehdottanut ",ColHighlight,"%s",ColDefault,".")
LANG.Theater_InvalidRequest 		= "Virheellinen videopyyntö."
LANG.Theater_AlreadyQueued 			= "Pyydetty video on jo jonossa."
LANG.Theater_ProcessingRequest 		= C("Käsitellään ",ColHighlight,"%s",ColDefault," pyyntöä...")
LANG.Theater_RequestFailed 			= "Pyynnetyn videon käsittelyssä ilmeni ongelma."
LANG.Theater_Voteskipped 			= "Tämänhetkinen video on äänestetty ohitettavaksi."
LANG.Theater_ForceSkipped 			= C(ColHighlight,"%s",ColDefault," on pakottanut nykyisen videon ohitettavaksi.")
LANG.Theater_PlayerReset 			= C(ColHighlight,"%s",ColDefault," on käynnistänyt teatterin uudelleen.")
LANG.Theater_LostOwnership 			= "Olet menettänyt teatterin omistajuuden lähtemisen vuoksi."
LANG.Theater_NotifyOwnership 		= "Olet nyt tämän yksityisen teatterin omistaja."
LANG.Theater_OwnerLockedQueue 		= "Teatterin omistaja on lukinnut videojonon."
LANG.Theater_LockedQueue 			= C(ColHighlight,"%s",ColDefault," on lukinnut videojonon.")
LANG.Theater_UnlockedQueue 			= C(ColHighlight,"%s",ColDefault," on avannut teatterin videojonon.")
LANG.Theater_OwnerUseOnly 			= "Vain teatterin omistaja voi käyttää tuota."
LANG.Theater_PublicVideoLength 		= "Julkisen teatterin videopyynnöt ovat rajoitettu %s sekunnin pituuteen."
LANG.Theater_PlayerVoteSkipped 		= C(ColHighlight,"%s",ColDefault," on äänestänyt ohittamista ",ColHighlight,"(%s/%s)",ColDefault,".")
LANG.Theater_VideoAddedToQueue 		= C(ColHighlight,"%s",ColDefault," on lisätty videojonoon.")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1	= "Nykyinen kartta ei tue Cinema-pelimuotoa."
LANG.Warning_Unsupported_Line2	= "Paina F1 avataksesi virallisen kartan workshopissa."
LANG.Warning_OSX_Line1			= "Mac OS X käyttäjät saattavat kärsiä mustista näytöistä Cinema-pelimuodossa."
LANG.Warning_OSX_Line2			= "Paina F1 nähdäksesi vianmääritysohjeita ja sulkeaksesi tämän viestin."

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title				= "VIDEOJONO"
LANG.Request_Video 				= "Tee videopyyntö"
LANG.Vote_Skip 					= "Äänestä ohittamista"
LANG.Toggle_Fullscreen 			= "Vaihda kokoruututilaan"
LANG.Refresh_Theater			= "Lataa teatteri uudelleen"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin				= "ADMIN"
LANG.Theater_Owner				= "OMISTAJA"
LANG.Theater_Skip				= "Ohita"
LANG.Theater_Seek				= "Siirry kohtaan"
LANG.Theater_Reset				= "Käynnistä uudelleen"
LANG.Theater_ChangeName			= "Vaihda nimi"
LANG.Theater_QueueLock			= "Videojonon lukko on/off"
LANG.Theater_SeekQuery			= "HH:MM:SS tai sekunnit numeroina (esim. 1:30:00 tai 5400)"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing		= "NYT TOISTOSSA"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History			= "HISTORIA"
LANG.Request_Clear				= "Tyhjennä"
LANG.Request_DeleteTooltip		= "Poista video historiasta"
LANG.Request_PlayCount			= "%d pyyntö(ä)" -- esim. 10 pyyntö(ä)
LANG.Request_Url				= "Pyydä URL:ia toistettavaksi"
LANG.Request_Url_Tooltip		= "Paina pyytääksesi kelvollista URL:ia toistettavaksi.\nPainike on punainen, jos URL on kelvollinen."

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title				= "ASETUKSET"
LANG.Settings_ClickActivate		= "KLIKKAA AKTIVOIDAKSESI HIIRI"
LANG.Settings_VolumeLabel		= "Äänenvoimakkuus"
LANG.Settings_VolumeTooltip		= "Käytä +/- näppäimiä nostaaksesi/pienentääksesi äänenvoimakkuutta."
LANG.Settings_HDLabel			= "HD Videoiden toisto"
LANG.Settings_HDTooltip			= "Käytä HD videotoistoa HD videoille."
LANG.Settings_HidePlayersLabel	= "Älä näytä pelaajia teatterissa"
LANG.Settings_HidePlayersTooltip = "Vähennä pelaajien näkyvyyttä teattereissa."
LANG.Settings_MuteFocusLabel	= "Mykistä audio kun siirryt toiseen ohjelmaan(Alt+Tab)"
LANG.Settings_MuteFocusTooltip	= "Mykistä teatterin audio kun Garry's Mod ei ole päällimmäisenä."

-- Video Services
LANG.Service_EmbedDisabled 		= "Pyydetty video ei ole upotettavissa."
LANG.Service_PurchasableContent = "Pyydetty video on ostettavaa materiaalia eikä ole toistettavissa."
LANG.Service_StreamOffline 		= "Pyydetty videostreami on offline."
