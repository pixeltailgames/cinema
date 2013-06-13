-- Basic information
LANG.Name		= "Español"					-- Native name for language
LANG.Id			= "es-ES"					-- Find corresponding ID in garrysmod/resource/localization
LANG.Author		= "Robert Lind (ptown2)"	-- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Volume						= "Volumen"
LANG.Voteskips					= "Omitido por votos"
LANG.Loading					= "Cargando..."
LANG.Invalid					= "[INVALIDO]"
LANG.NoVideoPlaying				= "No hay videos en seguimiento"
LANG.Cancel						= "Cancelar"
LANG.Set						= "Establecer"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy		= C("Video actual solicitado por ",ColHighlight,"%s",ColDefault,".")
LANG.Theater_InvalidRequest			= "Solicitud del video esta invalido."
LANG.Theater_AlreadyQueued			= "El video solicitado está ya en la lista."
LANG.Theater_ProcessingRequest		= C("Procesando ",ColHighlight,"%s",ColDefault," solicitud...")
LANG.Theater_RequestFailed			= "Hubo un problema al procesar el video solicitado."
LANG.Theater_Voteskipped			= "El video actual fue omitido por voto."
LANG.Theater_ForceSkipped			= C(ColHighlight,"%s",ColDefault," ha obligado a omitir el video actual.")
LANG.Theater_PlayerReset			= C(ColHighlight,"%s",ColDefault," ha reiniciado el teatro.")
LANG.Theater_LostOwnership			= "Usted ha perdido la propiedad y poder por salir de su teatro privado."
LANG.Theater_NotifyOwnership		= "Usted es ahora el propietario de este teatro privado."
LANG.Theater_OwnerLockedQueue		= "El dueño de este teatro ha cerrado la lista."
LANG.Theater_LockedQueue			= C(ColHighlight,"%s",ColDefault," ha cerrado la lista del teatro.")
LANG.Theater_UnlockedQueue			= C(ColHighlight,"%s",ColDefault," ha abierto la lista del teatro.")
LANG.Theater_OwnerUseOnly			= "Solamente el propietario de este teatro puede usar eso."
LANG.Theater_PublicVideoLength		= "Las solicitudes en teatros públicos son limitados a %s segundo(s) largo de video."
LANG.Theater_PlayerVoteSkipped		= C(ColHighlight,"%s",ColDefault," ha votado para omitir ",ColHighlight,"(%s/%s)",ColDefault,".")
LANG.Theater_VideoAddedToQueue		= C(ColHighlight,"%s",ColDefault," fue añadido a la lista.")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1	= "Este mapa no está respaldado por el modo de juego Cinema."
LANG.Warning_Unsupported_Line2	= "Pulse el botón F1 para ver los mapas oficiales en el Steam Workshop."
LANG.Warning_OSX_Line1			= "Los usuarios Mac OS X podrán tener problemas tecnicos (pantallas a blanco) en Cinema."
LANG.Warning_OSX_Line2			= "Pulse el botón F1 para resolver los problemas y remover este mensaje."

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title				= "LISTA"
LANG.Request_Video				= "Solicitar video"
LANG.Vote_Skip					= "Omitir el video"
LANG.Toggle_Fullscreen			= "Alternar a pantalla completa"
LANG.Refresh_Theater			= "Actualizar teatro"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin				= "ADMIN"
LANG.Theater_Owner				= "DUEÑO"
LANG.Theater_Skip				= "Omitir"
LANG.Theater_Seek				= "Brincar"
LANG.Theater_Reset				= "Reiniciar"
LANG.Theater_ChangeName			= "Cambiar el nombre"
LANG.Theater_QueueLock			= "Alternar la lista de videos"
LANG.Theater_SeekQuery			= "HH:MM:SS o en segundos totales (ej. 1:30:00 ó 5400)"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing		= "MOSTRANDO AHORA"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History			= "HISTORIAL"
LANG.Request_Clear				= "Eliminar"
LANG.Request_DeleteTooltip		= "Remover el historial de este video"
LANG.Request_PlayCount			= "%d solicitud(es)" -- e.g. 10 request(s)
LANG.Request_Url				= "Solicitar el enlace"
LANG.Request_Url_Tooltip		= "Pulsar para solicitar un enlace de video.\nEl botón será rojo cuando el enlace es válido."

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title					= "AJUSTES"
LANG.Settings_ClickActivate			= "PULSAR CON EL BOTON IZQUIERDO PARA ACTIVAR"
LANG.Settings_VolumeLabel			= "Volumen"
LANG.Settings_VolumeTooltip			= "Pulsar los teclados +/- para incrementar o disminuir el volumen."
LANG.Settings_HDLabel				= "Reproducir videos en alta-definición"
LANG.Settings_HDTooltip				= "Habilite la selección para ver videos en alta-definición. (Si necesario)"
LANG.Settings_HidePlayersLabel		= "Ocultar jugadores en el teatro"
LANG.Settings_HidePlayersTooltip	= "Habilite la selección para reducir la visibilidad de los jugadores en los teatros."
LANG.Settings_MuteFocusLabel		= "Desactivar el audio mientras fuera de foco."
LANG.Settings_MuteFocusTooltip		= "Habilite la selección para desactivar el audio en el teatro cuando Garry's Mod este fuera de foco. (ej. Minimizado)"

-- Video Services
LANG.Service_EmbedDisabled			= "El video solicitado esta deshabilitado."
LANG.Service_PurchasableContent		= "El video solicitado esta para compra y no se puede habilitar."
LANG.Service_StreamOffline			= "El video en vivo solicitado está fuera de servicio."