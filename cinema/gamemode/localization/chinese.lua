-- Basic information
LANG.Name		= "Chinese 台灣正體"	-- Native name for language
LANG.Id			= "zh-TW"	-- Find corresponding ID in garrysmod/resource/localization
LANG.Author		= "Poheart"		-- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema						= "電影院"
LANG.Volume						= "音量"
LANG.Voteskips					= "投票跳過"
LANG.Loading					= "載入中..."
LANG.Invalid					= "[無效]"
LANG.NoVideoPlaying				= "沒有影片播放中"
LANG.Cancel						= "取消"
LANG.Set						= "設定"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy 		= C("目前的影片由 ",ColHighlight,"%s",ColDefault,"提出.")
LANG.Theater_InvalidRequest 		= "無效的影片請求."
LANG.Theater_AlreadyQueued 			= "所請求的影片已經在佇列中."
LANG.Theater_ProcessingRequest 		= C("正在處理 ",ColHighlight,"%s",ColDefault," 的請求...")
LANG.Theater_RequestFailed 			= "處理所請求的影片時出現了問題."
LANG.Theater_Voteskipped 			= "目前的的影片已經被投票跳過."
LANG.Theater_ForceSkipped 			= C(ColHighlight,"%s",ColDefault," 已強制跳過目前的影片.")
LANG.Theater_PlayerReset 			= C(ColHighlight,"%s",ColDefault," 已重設影院.")
LANG.Theater_LostOwnership 			= "由於你已經離開影院,你失去了影院的擁有權."
LANG.Theater_NotifyOwnership 		= "你現在是本私人影院的擁有者."
LANG.Theater_OwnerLockedQueue 		= "影院擁有者已鎖定了本影院的影片佇列."
LANG.Theater_LockedQueue 			= C(ColHighlight,"%s",ColDefault," 已鎖定了本影院的影片佇列.")
LANG.Theater_UnlockedQueue 			= C(ColHighlight,"%s",ColDefault," 已解鎖了本影院的影片佇列.")
LANG.Theater_OwnerUseOnly 			= "只有影院擁有者才能使用."
LANG.Theater_PublicVideoLength 		= "公眾影院的影片請求只能播放 %s 秒內的長度"
LANG.Theater_PlayerVoteSkipped 		= C(ColHighlight,"%s",ColDefault," 已投票跳過目前的影片 ",ColHighlight,"(%s/%s)",ColDefault,".")
LANG.Theater_VideoAddedToQueue 		= C(ColHighlight,"%s",ColDefault," 已加入到佇列.")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1	= "目前地圖不支援Cinema模式"
LANG.Warning_Unsupported_Line2	= "請按F1打開Steam Workship的Cinema模式官方地圖"
LANG.Warning_OSX_Line1			= "Mac OS X 用戶可能會在影院中出現黑屏問題"
LANG.Warning_OSX_Line2			= "按F1查看疑難排解提示並移除此信息"

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title				= "佇列"
LANG.Request_Video 				= "請求影片"
LANG.Vote_Skip 					= "投票跳過"
LANG.Toggle_Fullscreen 			= "切換全屏模式"
LANG.Refresh_Theater			= "刷新影院"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin				= "管理員"
LANG.Theater_Owner				= "擁有者"
LANG.Theater_Skip				= "跳過"
LANG.Theater_Seek				= "跳至"
LANG.Theater_Reset				= "重設"
LANG.Theater_ChangeName			= "更改名稱"
LANG.Theater_QueueLock			= "切換佇列鎖定"
LANG.Theater_SeekQuery			= "HH:MM:SS 或秒數 (e.g. 1:30:00 或 5400)"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing		= "現正放映"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History			= "播放記錄"
LANG.Request_Clear				= "清除"
LANG.Request_DeleteTooltip		= "從播放記錄中移除"
LANG.Request_PlayCount			= "%d 個請求" -- e.g. 10 request(s)
LANG.Request_Url				= "請求網址"
LANG.Request_Url_Tooltip		= "按下請求一個有效的視頻網址.\n按鈕將會變成紅色當您提供一個有效的URL"

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title				= "設定"
LANG.Settings_ClickActivate		= "按一下顯示你的鼠標"
LANG.Settings_VolumeLabel		= "音量"
LANG.Settings_VolumeTooltip		= "利用 +/- 鍵以 增加/減小 音量."
LANG.Settings_HDLabel			= "播放高清視頻"
LANG.Settings_HDTooltip			= "啟用高清視頻播放在高清支援的影片"
LANG.Settings_HidePlayersLabel	= "隱藏影院內其他玩家"
LANG.Settings_HidePlayersTooltip = "減低影院內的玩家可見性."
LANG.Settings_MuteFocusLabel	= "當Alt-Tab時靜音"
LANG.Settings_MuteFocusTooltip	= "當你Alt-tab 切換窗口時靜音影院內播放的視頻."

-- Video Services
LANG.Service_EmbedDisabled 		= "所請求的影片禁用了嵌入式播放的使用."
LANG.Service_PurchasableContent = "所請求的影片是可購買內容因此不能被播放."
LANG.Service_StreamOffline 		= "所請求的直播已離線."

-- Act command (don't bother translating this)
-- modules/taunts/sv_commands.lua
LANG.ActCommand = C(ColHighlight,"%s",ColDefault," %ss") -- e.g. Sam dances

-- Version 1.1
LANG.TranslationsCredit = "由 %s 翻譯"
