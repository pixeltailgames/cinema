-- Basic information
LANG.Name                = "Euskera"        -- Native name for language
LANG.Id                        = "eu"                -- Find corresponding ID in garrysmod/resource/localization
LANG.Author                = "Julortizw"                -- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema                                                = "ZINEMA"
LANG.Volume                                                = "Bolumena"
LANG.Voteskips                                        = "Saltatzeko bozkatu"
LANG.Loading                                        = "Kargatzen..."
LANG.Invalid                                        = "[BALIOGABEA]"
LANG.NoVideoPlaying                                = "Ez dago bideorik erreproduzitzen"
LANG.Cancel                                                = "Ezeztatu"
LANG.Set                                                = "Ezarri"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy                 = C("Horaingo bideoa eskatu du ",ColHighlight,"%s",ColDefault,".")
LANG.Theater_InvalidRequest                 = "Eskatutako bideoa baliogabea da."
LANG.Theater_AlreadyQueued                         = "Eskatutako bideoa jadanik ilaran dago."
LANG.Theater_ProcessingRequest                 = C("Prozesatzen ",ColHighlight,"%s",ColDefault," eskaera...")
LANG.Theater_RequestFailed                         = "Arazo bat egon da eskatutako bideoa prozesatzen."
LANG.Theater_Voteskipped                         = "Oraingo bideoak bozkatu hondoren saltatu da."
LANG.Theater_ForceSkipped                         = C(ColHighlight,"%s",ColDefault," bideoa pasatzera behartu du.")
LANG.Theater_PlayerReset                         = C(ColHighlight,"%s",ColDefault," zinema berrezarri da.")
LANG.Theater_LostOwnership                         = "Aretoaren jabetza galdu duzu irtetearen ondorioz."
LANG.Theater_NotifyOwnership                 = "Orain zu zara zinema pribatuko jabe berria."
LANG.Theater_OwnerLockedQueue                 = "Zinemaren jabeak ilara blokeatu du."
LANG.Theater_LockedQueue                         = C(ColHighlight,"%s",ColDefault," zinemako ilara blokeatu du.")
LANG.Theater_UnlockedQueue                         = C(ColHighlight,"%s",ColDefault," antzerkiaren ilara desblokeatu du.")
LANG.Theater_OwnerUseOnly                         = "Zinemaren jabeak bakarrik egin dezake hori."
LANG.Theater_PublicVideoLength                 = "Zinema publikoko eskaerak mugiatua du %s segundu(ak) in luzeeran."
LANG.Theater_PlayerVoteSkipped                 = C(ColHighlight,"%s",ColDefault," saltatzeko bozkatu du ",ColHighlight,"(%s/%s)",ColDefault,".")
LANG.Theater_VideoAddedToQueue                 = C(ColHighlight,"%s",ColDefault," ilerara gehitua izan da.")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1        = "Hurrengo mapa onartu gabea dago cinema joku moduarengatik"
LANG.Warning_Unsupported_Line2        = "Sakatu F1 workshop-en mapa ofiziala irekitzeko"
LANG.Warning_OSX_Line1                        = "Mac OS X-eko usuarioak problemak izan ditzazkete (pantaila beltzak edo zuriak)"
LANG.Warning_OSX_Line2                        = "Sakatu F1 arazoak konpontzeko aholkuak ikusteko ata mezu hau kentzeko"

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title                                = "ILARA"
LANG.Request_Video                                 = "Bideo baten eskaera egin"
LANG.Vote_Skip                                         = "Saltatzeko bazkatu"
LANG.Toggle_Fullscreen                         = "Pantaila osoan ezarri"
LANG.Refresh_Theater                        = "Zinema frexkatu"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin                                = "ADMIN"
LANG.Theater_Owner                                = "JABEA"
LANG.Theater_Skip                                = "Saltatu"
LANG.Theater_Seek                                = "Bilatu"
LANG.Theater_Reset                                = "Berrezarri"
LANG.Theater_ChangeName                        = "Izena aldatu"
LANG.Theater_QueueLock                        = "Ilara bloqueatu"
LANG.Theater_SeekQuery                        = "HH:MM:SS edo segunduetan (Adb. 1:30:00 edo 5400)"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing                = "Orain erreproduzitzen"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History                        = "HISTORIALA"
LANG.Request_Clear                                = "Garbitu"
LANG.Request_DeleteTooltip                = "Bideoa historialetik kendu"
LANG.Request_PlayCount                        = "%d request(s)" -- e.g. 10 request(s)
LANG.Request_Url                                = "Bideo baten eskaera egin"
LANG.Request_Url_Tooltip                = "Klikatu bideo baliagarri bat erreproduzitzeko.\nBotoia gorria izango da URL-a baliagarria bada."

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title                                = "AUKERAK"
LANG.Settings_ClickActivate                = "KIKATU SAGUA AKTIBATZEKO"
LANG.Settings_VolumeLabel                = "Bolumena"
LANG.Settings_VolumeTooltip                = "Erabili +/- botoiak bolumena igotzeko/jaisteko."
LANG.Settings_HDLabel                        = "HD bideo erreprodukzioa"
LANG.Settings_HDTooltip                        = "Aktibatu HD bideoen erreprodukzioa HD kalitazteko duten bideoetan."
LANG.Settings_HidePlayersLabel        = "Ezkutatu jokalariak antzoki"
LANG.Settings_HidePlayersTooltip = "Murriztu jokalarien ikusgarritasuna antzoki"
LANG.Settings_MuteFocusLabel        = "Mututu audioa alt botia sakaturik"
LANG.Settings_MuteFocusTooltip        = "Mututu zinemako audioa Garry's Mod  is ikuspegitik kanpoan dagoenean (Adb. alt botoia sakaturik edukita)."

-- Video Services
LANG.Service_EmbedDisabled                 = "Eskatutako bideoa ezin izan da txertaua izan."
LANG.Service_PurchasableContent = "Eskatutako bideoa orosi egin behar da eta ezin da erreproduzitu."
LANG.Service_StreamOffline                 = "Eskatutako bideoa ez dago."