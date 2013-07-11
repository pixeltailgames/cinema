-- Basic information
LANG.Name	= "Italiano"	-- Native name for language
LANG.Id	= "it"	-- Find corresponding ID in garrysmod/resource/localization
LANG.Author	= "Wolfaloo"	-- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema	= "CINEMA"
LANG.Volume	= "Volume"
LANG.Voteskips	= "Vota per saltare"
LANG.Loading	= "CARICAMENTO..."
LANG.Invalid	= "[NON VALIDO]"
LANG.NoVideoPlaying	= "NESSUN VIDEO IN RIPRODUZIONE"
LANG.Cancel	= "Cancella"
LANG.Set	= "Setta"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy = C("Video corrente richiesto da ",ColHighlight,"%s",ColDefault,".")
LANG.Theater_InvalidRequest = "Richiesta non valida."
LANG.Theater_AlreadyQueued = "Il video richiesto è gia in coda."
LANG.Theater_ProcessingRequest = C("Processando la richiesta di ",ColHighlight,"%s",ColDefault," ...")
LANG.Theater_RequestFailed = "Si è verificato un problema nella richiesta del video."
LANG.Theater_Voteskipped = "Il seguente video è stato saltato a causa di un voto."
LANG.Theater_ForceSkipped = C(ColHighlight,"%s",ColDefault," ha forzato il salto del video.")
LANG.Theater_PlayerReset = C(ColHighlight,"%s",ColDefault," ha resettato il teatro.")
LANG.Theater_LostOwnership = "Hai perso la proprietà del teatro perchè lo hai abbandonato."
LANG.Theater_NotifyOwnership = "Sei il padrone di questo teatro."
LANG.Theater_OwnerLockedQueue = "Il propietario del teatro ha bloccato la fila di riproduzione."
LANG.Theater_LockedQueue = C(ColHighlight,"%s",ColDefault," ha bloccato la fila di riproduzione.")
LANG.Theater_UnlockedQueue = C(ColHighlight,"%s",ColDefault," ha sbloccato la fila di riproduzione.")
LANG.Theater_OwnerUseOnly = "Solo il propietario del teatro puo usare questa funzione."
LANG.Theater_PublicVideoLength = "Le richieste in un teatro publico sono limitate a una durata di %s second(s) secondi."
LANG.Theater_PlayerVoteSkipped = C(ColHighlight,"%s",ColDefault," ha votato per saltare ",ColHighlight,"(%s/%s)",ColDefault,".")
LANG.Theater_VideoAddedToQueue = C(ColHighlight,"%s",ColDefault," è stato aggiunto alla coda.")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1	= "La corrente mappa non è supportata da cinema gamemode"
LANG.Warning_Unsupported_Line2	= "Premi f1 per aprire la mappa officiale nel Workshop steam"
LANG.Warning_OSX_Line1	= "Utenti mac possono incontrare schermi bianchi all interno del cinema"
LANG.Warning_OSX_Line2	= "Premi f1 per visionare i consigli e rimuovere questo messaggio"

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title	= "CODA"
LANG.Request_Video = "Richiedi Video"
LANG.Vote_Skip = "Vota per saltare"
LANG.Toggle_Fullscreen = "Schermo intero"
LANG.Refresh_Theater	= "Ricarica teatro"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin	= "AMMINISTRATORE"
LANG.Theater_Owner	= "PROPIETARIO"
LANG.Theater_Skip	= "Skip"
LANG.Theater_Seek	= "Seek"
LANG.Theater_Reset	= "Reset"
LANG.Theater_ChangeName	= "Change Name"
LANG.Theater_QueueLock	= "Toggle Queue Lock"
LANG.Theater_SeekQuery	= "HH:MM:SS o numero di secondi (es. 1:30:00 o 5400)"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing	= "IN RIPRODUZIONE"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History	= "CRONOLOGIA"
LANG.Request_Clear	= "Pulisci"
LANG.Request_DeleteTooltip	= "Rimuovi video dalla cronologia"
LANG.Request_PlayCount	= "%d request(s)" -- es. 10 richieste
LANG.Request_Url	= "Richiedi URL"
LANG.Request_Url_Tooltip	= "Premi per richiedere un URL valido.\nil bottone sarà rosso quando l' URL sarà valido"

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title	= "IMPOSTAZIONE"
LANG.Settings_ClickActivate	= "CLICCA PER ATTIVARE IL MUOSE"
LANG.Settings_VolumeLabel	= "Volume"
LANG.Settings_VolumeTooltip	= "Usa i tasti +/- per aumentare/diminuire il volume."
LANG.Settings_HDLabel	= "Video in HD"
LANG.Settings_HDTooltip	= "Abilita la riproduzione in HD per i video che ne dispongono."
LANG.Settings_HidePlayersLabel	= "Nascondi giocatori nel teatro"
LANG.Settings_HidePlayersTooltip = "Riduce la visibilità dei giocatori nel teatro."
LANG.Settings_MuteFocusLabel	= "Silenzia l'audio alla pressione di alt-tab"
LANG.Settings_MuteFocusTooltip	= "Silenzia Gmod quando il gioco non è la finestra principale (es. premendo alt-tab)."

-- Video Services
LANG.Service_EmbedDisabled = "Il video richiesto non è abilitato all incorporazione."
LANG.Service_PurchasableContent = "Il video richiesto è acquistabile e non puo essere riprodotto."
LANG.Service_StreamOffline = "Lo stream richiesto è correntemente offline."

-- Version 1.1
LANG.TranslationsCredit = "Traduzioni di %s"