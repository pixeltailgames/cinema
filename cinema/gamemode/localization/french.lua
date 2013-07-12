-- Basic information
LANG.Name		= "French"	-- Native name for language
LANG.Id			= "fr"		-- Find corresponding ID in garrysmod/resource/localization
LANG.Author		= "Raphy"		-- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema						= "CINEMA"
LANG.Volume						= "Volume"
LANG.Voteskips					= "Votes"
LANG.Loading					= "Chargement..."
LANG.Invalid					= "[INVALIDE]"
LANG.NoVideoPlaying				= "Aucune vidéos en lecture"
LANG.Cancel						= "Annuler"
LANG.Set						= "Régler"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy 		= C("Vidéo ajouté par",ColHighlight,"%s",ColDefault,".")
LANG.Theater_InvalidRequest 		= "Requête vidéo invalide."
LANG.Theater_AlreadyQueued 			= "Cette vidéo est déja dans la liste d'attente."
LANG.Theater_ProcessingRequest 		= C("Traitement de ",ColHighlight,"%s",ColDefault," en cours...")
LANG.Theater_RequestFailed 			= "Un problème est survenu lors du traitement de la vidéo"
LANG.Theater_Voteskipped 			= "Une nouvelle vidéo vient d'être votée"
LANG.Theater_ForceSkipped 			= C(ColHighlight,"%s",ColDefault," a imposé une nouvelle vidéo")
LANG.Theater_PlayerReset 			= C(ColHighlight,"%s",ColDefault," a réinitialiser le théatre")
LANG.Theater_LostOwnership 			= "Vous avez perdu la propriété du théatre puisque vous avez quitté"
LANG.Theater_NotifyOwnership 		= "Vous êtes maintenant le propriétaire du théatre"
LANG.Theater_OwnerLockedQueue 		= "Le propriétaire du théatre a bloqué la liste d'attente"
LANG.Theater_LockedQueue 			= C(ColHighlight,"%s",ColDefault," a bloqué la liste d'attente du théatre")
LANG.Theater_UnlockedQueue 			= C(ColHighlight,"%s",ColDefault," a débloqué la liste d'attente du théatre")
LANG.Theater_OwnerUseOnly 			= "Seul le propriétaire du théatre peux utiliser ceci"
LANG.Theater_PublicVideoLength 		= "Les requêtes du théatre public sont limité à %s seconde(s)"
LANG.Theater_PlayerVoteSkipped 		= C(ColHighlight,"%s",ColDefault," a voté pour changer la vidéo : ",ColHighlight,"(%s/%s)",ColDefault,".")
LANG.Theater_VideoAddedToQueue 		= C(ColHighlight,"%s",ColDefault," a été ajouté à la liste d'attente")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1	= "La map actuelle n'est pas compatible avec Cinéma"
LANG.Warning_Unsupported_Line2	= "Appuyer sur F1 pour ouvrir la map officiel sur le workshop"
LANG.Warning_OSX_Line1			= "Les utilisateurs de Mac OS X peuvent éprouver des écrans vide sur Cinema"
LANG.Warning_OSX_Line2			= "Appuyer sur F1 pour voir le dépannage et comment enlever ce message"

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title				= "LISTE D'ATTENTE"
LANG.Request_Video 				= "Ajouter une vidéo"
LANG.Vote_Skip 					= "Voter pour une nouvelle vidéo"
LANG.Toggle_Fullscreen 			= "Activer le mode Plein Écran"
LANG.Refresh_Theater			= "Rafraichir le théatre"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin				= "ADMIN"
LANG.Theater_Owner				= "OWNER"
LANG.Theater_Skip				= "Suivant"
LANG.Theater_Seek				= "Mettre à"
LANG.Theater_Reset				= "Réinitialiser"
LANG.Theater_ChangeName			= "Changer le nom"
LANG.Theater_QueueLock			= "Bloquer la liste d'attente"
LANG.Theater_SeekQuery			= "HH:MM:SS ou le nombre de secondes (e.g. 1:30:00 ou 5400)"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing		= "EN LECTURE"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History			= "HISTORIQUE"
LANG.Request_Clear				= "Nettoyer"
LANG.Request_DeleteTooltip		= "Enlever la vidéo de l'historique"
LANG.Request_PlayCount			= "%d demande(s)" -- e.g. 10 request(s)
LANG.Request_Url				= "Ajouter l'URL"
LANG.Request_Url_Tooltip		= "Appuyer pour ajouter une URL valide d'une vidéo.\nLe bouton sera rouge si l'URL est valide"

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title				= "PARAMÈTRES"
LANG.Settings_ClickActivate		= "APPUYER POUR ACTIVER LA SOURIS"
LANG.Settings_VolumeLabel		= "Volume"
LANG.Settings_VolumeTooltip		= "Utiliser les touches +/- pour augmenter ou diminuer le volume"
LANG.Settings_HDLabel			= "Activer la lecture HD"
LANG.Settings_HDTooltip			= "Activer la lecture vidéo HD pour les vidéos HD compatibles"
LANG.Settings_HidePlayersLabel	= "Cachez les joueurs dans le théatre"
LANG.Settings_HidePlayersTooltip = "Réduire la visibilité du joueur à l'intérieur des théatres"
LANG.Settings_MuteFocusLabel	= "Désactiver le son lorsque réduit"
LANG.Settings_MuteFocusTooltip	= "Désactive le son de la vidéo lorsque Garry's Mod est rédruit(e.g. Alt+Tab)."

-- Video Services
LANG.Service_EmbedDisabled 		= "La vidéo demandé est désactivé"
LANG.Service_PurchasableContent = "La vidéo demandé est un contenu achetable, il ne peut donc pas être ajouté"
LANG.Service_StreamOffline 		= "Le stream demandé est hors-ligne"

-- Version 1.1
LANG.TranslationsCredit = "Translations by %s"