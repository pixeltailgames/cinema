-- Basic information
LANG.Name       = "Português"  -- Native name for language
LANG.Id         = "pt-br"       -- Find corresponding ID in garrysmod/resource/localization
LANG.Author     = "Skorpion"        -- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema                     = "CINEMA"
LANG.Volume                     = "Volume"
LANG.Voteskips                  = "Vote para pular" 
LANG.Loading                    = "Carregando..."
LANG.Invalid                    = "[INVÁLIDO]"
LANG.NoVideoPlaying             = "Nenhum vídeo sendo reproduzido"
LANG.Cancel                     = "Cancelar"
LANG.Set                        = "Definir"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy       = C("O vídeo atual foi solicitado por ",ColHighlight,"%s",ColDefault,".")
LANG.Theater_InvalidRequest         = "Pedido de vídeo inválido."
LANG.Theater_AlreadyQueued          = "O vídeo solicitado já esta na fila de espera."
LANG.Theater_ProcessingRequest      = C("Processando ",ColHighlight,"%s",ColDefault," solicitação...")
LANG.Theater_RequestFailed          = "Erro ao processar solicitação."
LANG.Theater_Voteskipped            = "O vídeo atual foi pulado."
LANG.Theater_ForceSkipped           = C(ColHighlight,"%s",ColDefault," obrigou a pular de vídeo.")
LANG.Theater_PlayerReset            = C(ColHighlight,"%s",ColDefault," reiniciou o cinema.")
LANG.Theater_LostOwnership          = "Você perdeu a posse do cinema ao deixar a sala."
LANG.Theater_NotifyOwnership        = "Agora você é o dono do teatro privado."
LANG.Theater_OwnerLockedQueue       = "O dono do cinema travou a fila de espera."
LANG.Theater_LockedQueue            = C(ColHighlight,"%s",ColDefault," travou a fila de espera da sala.")
LANG.Theater_UnlockedQueue          = C(ColHighlight,"%s",ColDefault," destravou a fila de espera da sala.")
LANG.Theater_OwnerUseOnly           = "Apenas o dono do cinema pode usar isso."
LANG.Theater_PublicVideoLength      = "Solicitações em cinemas públicos são limitados em %s segundo(s) de duração."
LANG.Theater_PlayerVoteSkipped      = C(ColHighlight,"%s",ColDefault," votou para pular o vídeo ",ColHighlight,"(%s/%s)",ColDefault,".")
LANG.Theater_VideoAddedToQueue      = C(ColHighlight,"%s",ColDefault," foi adicionado para a fila de espera.")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1  = "O modo de jogo Cinema não tem suporte para o mapa atual"
LANG.Warning_Unsupported_Line2  = "Pressione F1 para conferir o mapa oficial na oficina da Steam"
LANG.Warning_OSX_Line1          = "Usuários de Mac OS X podem experienciar telas brancas no Cinema"
LANG.Warning_OSX_Line2          = "Pressione F1 para ver dicas de soluções de problemas e para remover esta mensagem"

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title                = "Fila de Espera"
LANG.Request_Video              = "Solicitar Vídeo"
LANG.Vote_Skip                  = "Vote para pular"
LANG.Toggle_Fullscreen          = "Habilita/Desabilita Tela cheia" 
LANG.Refresh_Theater            = "Atualizar Cinema"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin              = "ADMIN" 
LANG.Theater_Owner              = "DONO"
LANG.Theater_Skip               = "Pular"
LANG.Theater_Seek               = "Buscar"
LANG.Theater_Reset              = "Resetar"
LANG.Theater_ChangeName         = "Mudar de Nome"
LANG.Theater_QueueLock          = "Travar/Destravar fila de espera"
LANG.Theater_SeekQuery          = "HH:MM:SS or number of seconds (e.g. 1:30:00 or 5400)"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing     = "EXIBINDO AGORA"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History            = "HISTÓRICO"
LANG.Request_Clear              = "Limpar"
LANG.Request_DeleteTooltip      = "Remove este vídeo do histórico"
LANG.Request_PlayCount          = "%d solicitações(s)" -- e.g. 10 request(s)
LANG.Request_Url                = "Solicitar Link"
LANG.Request_Url_Tooltip        = "Pressione para solicitar um Link de um vídeo válido.\nO botão se tornará vermelho quando o Link for válido."

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title             = "CONFIGURAÇÕES"
LANG.Settings_ClickActivate     = "CLIQUE PARA ATIVAR SEU MOUSE"
LANG.Settings_VolumeLabel       = "Volume"
LANG.Settings_VolumeTooltip     = "Use as teclas +/- para aumentar/reduzir o volume."
LANG.Settings_HDLabel           = "Reproduzir em HD"
LANG.Settings_HDTooltip         = "Habilita vídeos em alta definição quando disponível." LANG.Settings_HidePlayersLabel = "Esconder jogadores dentro da sala"
LANG.Settings_HidePlayersTooltip = "Torna os jogadores invisíveis dentro da sala."
LANG.Settings_MuteFocusLabel    = "Áudio mudo durante o alt-tab"
LANG.Settings_MuteFocusTooltip  = "Deixar o som do cinema mudo quando o Garry's Mod estiver fora de foco (ex: quando você da alt-tab)."

-- Video Services
LANG.Service_EmbedDisabled      = "A incorporação do vídeo solicitado esta desativada."
LANG.Service_PurchasableContent = "O vídeo solicitado é de conteúdo pago e não pode ser exibido."
LANG.Service_StreamOffline      = "O stream solicitado está fora do ar."

-- Version 1.1
LANG.TranslationsCredit = "Translations by %s"