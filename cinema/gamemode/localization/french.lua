-- Basic information
LANG.Name       = "Français" -- Native name for language
LANG.Id         = "fr"      -- Find corresponding ID in garrysmod/resource/localization
LANG.Author     = "Raphy, Kcejalppe"        -- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema                     = "CINEMA"
LANG.Volume                     = "Volume"
LANG.Voteskips                  = "Votes de passage"
LANG.Loading                    = "Chargement..."
LANG.Invalid                    = "[INVALIDE]"
LANG.NoVideoPlaying             = "Pas de vidéo en lecture"
LANG.Cancel                     = "Annuler"
LANG.Set                        = "Régler"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy       = C("Vidéo actuelle proposée par ",ColHighlight,"%s",ColDefault,".")
LANG.Theater_InvalidRequest         = "Requête vidéo invalide."
LANG.Theater_AlreadyQueued          = "La vidéo proposée est déjà dans la liste d'attente."
LANG.Theater_ProcessingRequest      = C("Traitement de ",ColHighlight,"%s",ColDefault," en cours...")
LANG.Theater_RequestFailed          = "Un problème est servenu lors du traitement de la vidéo proposée."
LANG.Theater_Voteskipped            = "La vidéo actuelle a été passée."
LANG.Theater_ForceSkipped           = C(ColHighlight,"%s",ColDefault," a passé de force la vidéo actuelle.")
LANG.Theater_PlayerReset            = C(ColHighlight,"%s",ColDefault," a réinitialisé le théatre.")
LANG.Theater_LostOwnership          = "Vous avez perdu le statut de propriétaire du théatre car vous l'avez quitté."
LANG.Theater_NotifyOwnership        = "Vous êtes maintenant le propriétaire de ce théatre privé."
LANG.Theater_OwnerLockedQueue       = "Le propriétaire de ce théatre a verrouillé la liste d'attente."
LANG.Theater_LockedQueue            = C(ColHighlight,"%s",ColDefault," a verrouillé la liste d'attente.")
LANG.Theater_UnlockedQueue          = C(ColHighlight,"%s",ColDefault," a déverrouillé la liste d'attente.")
LANG.Theater_OwnerUseOnly           = "Seul le propriétaire du théatre peut utiliser cela."
LANG.Theater_PublicVideoLength      = "Les requêtes de théatres publics sont limitées à %s seconde(s)."
LANG.Theater_PlayerVoteSkipped      = C(ColHighlight,"%s",ColDefault," a voté pour passer ",ColHighlight,"(%s/%s)",ColDefault,".")
LANG.Theater_VideoAddedToQueue      = C(ColHighlight,"%s",ColDefault," a été ajoutée à la liste d'attente.")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1  = "La carte actuelle n'est pas supportée par le mode de jeu Cinema"
LANG.Warning_Unsupported_Line2  = "Appuyez sur F1 pour ouvrir la carte officielle dans le workshop"
LANG.Warning_OSX_Line1          = "Les utilisateurs de Mac OS X peuvent être sujets à des problèmes d'écrans noirs dans les théatres"
LANG.Warning_OSX_Line2          = "Appuyez sur F1 pour voir les astuces concernant les problèmes et pour fermer ce message"

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title                = "LISTE D'ATTENTE"
LANG.Request_Video              = "Proposer une vidéo"
LANG.Vote_Skip                  = "Voter pour passer"
LANG.Toggle_Fullscreen          = "Activer le plein-écran"
LANG.Refresh_Theater            = "Actualiser le théatre"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin              = "ADMIN"
LANG.Theater_Owner              = "PROPRIETAIRE"
LANG.Theater_Skip               = "Passer"
LANG.Theater_Seek               = "Chercher"
LANG.Theater_Reset              = "Réinitialiser"
LANG.Theater_ChangeName         = "Changer le nom"
LANG.Theater_QueueLock          = "Verrouiller la liste d'attente"
LANG.Theater_SeekQuery          = "HH:MM:SS ou un nombre en secondes (par exemple 1:30:00 ou 5400)"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing     = "EN LECTURE"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History            = "HISTORIQUE"
LANG.Request_Clear              = "Effacer"
LANG.Request_DeleteTooltip      = "Effacer la vidéo de l'historique"
LANG.Request_PlayCount          = "%d requête(s)" -- e.g. 10 request(s)
LANG.Request_Url                = "Proposer l'URL"
LANG.Request_Url_Tooltip        = "Appuyer pour proposer une URL de vidéo valide.\nLe bouton deviendra rouge si l'URL est valide."

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title             = "OPTIONS"
LANG.Settings_ClickActivate     = "CLIQUER POUR ACTIVER LA SOURIS"
LANG.Settings_VolumeLabel       = "Volume"
LANG.Settings_VolumeTooltip     = "Utilisez les touches +/- pour augmenter/diminuer le volume."
LANG.Settings_HDLabel           = "Lecture en HD"
LANG.Settings_HDTooltip         = "Activer la lecture en HD pour les vidéos compatibles."
LANG.Settings_HidePlayersLabel  = "Masquer les joueurs dans le théatre"
LANG.Settings_HidePlayersTooltip = "Réduire la visibilité des joueurs à l'intérieur du théatre."
LANG.Settings_MuteFocusLabel    = "Désactiver le son dans le menu ALT-TAB"
LANG.Settings_MuteFocusTooltip  = "Désactiver le son de la vidéo quand Garry's Mod n'est pas au premier-plan (si ALT-TAB, par exemple)."

-- Video Services
LANG.Service_EmbedDisabled      = "La vidéo proposée n'a pas l'intégration activée."
LANG.Service_PurchasableContent = "La vidéo proposée est un contenu payant et ne peut pas être lue."
LANG.Service_StreamOffline      = "Le stream proposé est hors-ligne."

-- Act command (don't bother translating this)
-- modules/taunts/sv_commands.lua
LANG.ActCommand = C(ColHighlight,"%s",ColDefault," %ss") -- e.g. Sam dances

-- Version 1.1
LANG.TranslationsCredit = "Traductions par %s"
