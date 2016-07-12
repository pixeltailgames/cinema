-- Basic information
LANG.Name       = "한국어" -- Native name for language
LANG.Id         = "ko"      -- Find corresponding ID in garrysmod/resource/localization
LANG.Author     = "ChiNo"        -- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema                     = "시네마"
LANG.Volume                     = "음량"
LANG.Voteskips                  = "투표 건너뛰기"
LANG.Loading                    = "불러오는 중..."
LANG.Invalid                    = "[인식 불가능]"
LANG.NoVideoPlaying             = "재생 중인 비디오 없음"
LANG.Cancel                     = "취소"
LANG.Set                        = "확인"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy       = C("현재 비디오를 신청한 플레이어는 ",ColHighlight,"%s",ColDefault," 입니다.")
LANG.Theater_InvalidRequest         = "인식 불가능한 비디오 정보."
LANG.Theater_AlreadyQueued          = "선택하신 비디오는 이미 대기 열에 있습니다."
LANG.Theater_ProcessingRequest      = C("스트리밍 서비스 ",ColHighlight,"%s",ColDefault,"를 불러오는 중...")
LANG.Theater_RequestFailed          = "선택하신 비디오를 불러오는 중 문제가 생겼습니다."
LANG.Theater_Voteskipped            = "현재 재생 중이었던 비디오는 투표로 인해 건너뛰어졌습니다."
LANG.Theater_ForceSkipped           = C(ColHighlight,"%s",ColDefault," 님이 강제로 건너뛰기 하였습니다.")
LANG.Theater_PlayerReset            = C(ColHighlight,"%s",ColDefault," 님이 극장을 초기화하였습니다.")
LANG.Theater_LostOwnership          = "극장을 떠나서 가지고 있던 주인 권한을 잃으셨습니다."
LANG.Theater_NotifyOwnership        = "당신은 이 개인 극장의 주인 권한을 얻으셨습니다."
LANG.Theater_OwnerLockedQueue       = "극장의 주인이 대기 열을 잠갔습니다."
LANG.Theater_LockedQueue            = C(ColHighlight,"%s",ColDefault," 님이 대기 열을 잠갔습니다.")
LANG.Theater_UnlockedQueue          = C(ColHighlight,"%s",ColDefault," 님이 대기 열을 잠금 해제하였습니다.")
LANG.Theater_OwnerUseOnly           = "오로지 주인만이 이것을 사용할 수 있습니다."
LANG.Theater_PublicVideoLength      = "공용 극장은 %s 초의 길이 제한이 있습니다."
LANG.Theater_PlayerVoteSkipped      = C(ColHighlight,"%s",ColDefault," 님이 건너뛰기 투표를 하였습니다. ",ColHighlight,"(%s/%s)",ColDefault,".")
LANG.Theater_VideoAddedToQueue      = C(ColHighlight,"%s",ColDefault," 비디오가 대기열에 추가되었습니다.")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1  = "선택하신 맵은 시네마 게임 모드에 호환되지 않습니다."
LANG.Warning_Unsupported_Line2  = "F1을 눌러 시네마 공식 맵을 창작 마당에서 확인하세요."
LANG.Warning_OSX_Line1          = "맥 OS X 플레이어들은 검은 화면이 출력될 수 도 있습니다."
LANG.Warning_OSX_Line2          = "F1을 눌러 이 메시지를 제거하고 문제 해결 팁을 얻을 수 있습니다."

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title                = "대기 열"
LANG.Request_Video              = "비디오 신청"
LANG.Vote_Skip                  = "투표 건너뛰기"
LANG.Toggle_Fullscreen          = "항상 전체 화면"
LANG.Refresh_Theater            = "극장 새로 고침"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin              = "관리자"
LANG.Theater_Owner              = "서버 주인"
LANG.Theater_Skip               = "건너뛰기"
LANG.Theater_Seek               = "시간 건너뛰기"
LANG.Theater_Reset              = "초기화"
LANG.Theater_ChangeName         = "이름 바꾸기"
LANG.Theater_QueueLock          = "항상 대기 열 잠구기"
LANG.Theater_SeekQuery          = "HH:MM:SS 의 양식으로 숫자를 입력하십시오. (예. 1:30:00 또는 5400)"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing     = "지금 재생 중"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History            = "최근 기록"
LANG.Request_Clear              = "초기화"
LANG.Request_DeleteTooltip      = "비디오를 최근 기록에서 삭제합니다."
LANG.Request_PlayCount          = "%d 개 신청됨" -- e.g. 10 request(s)
LANG.Request_Url                = "URL 요청"
LANG.Request_Url_Tooltip        = "올바른 URL을 요청하십시오.\n버튼 색깔이 빨간색일때 올바른 URL입니다."

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title             = "설정"
LANG.Settings_ClickActivate     = "마우스를 클릭하여 활성화합니다."
LANG.Settings_VolumeLabel       = "음량"
LANG.Settings_VolumeTooltip     = "+/- 키를 사용해 음량을 올리거나 내리세요."
LANG.Settings_HDLabel           = "HD 비디오 재생"
LANG.Settings_HDTooltip         = "비디오가 재생될 때 HD로 재생됩니다."
LANG.Settings_HidePlayersLabel  = "극장에서 다른 플레이어 숨김"
LANG.Settings_HidePlayersTooltip = "다른 플레이어들을 숨겨서 안 보이게 합니다."
LANG.Settings_MuteFocusLabel    = "ALT + TAB 음소거"
LANG.Settings_MuteFocusTooltip  = "ALT + TAB을 사용해 다른 시점으로 갔을때 음소거 합니다."

-- Video Services
LANG.Service_EmbedDisabled      = "신청하신 비디오는 해제되있습니다"
LANG.Service_PurchasableContent = "신청된 비디오는 매수할 수 있는 콘텐츠와 연주가 될 수 없습니다."
LANG.Service_StreamOffline      = "스트리밍 서비스가 오프라인입니다."

-- Act command (don't bother translating this)
-- modules/taunts/sv_commands.lua
LANG.ActCommand = C(ColHighlight,"%s",ColDefault," %ss") -- e.g. Sam dances

-- Version 1.1
LANG.TranslationsCredit = "번역 %s"
