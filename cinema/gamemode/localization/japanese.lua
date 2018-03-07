-- Basic information
LANG.Name       = "日本語" -- Native name for language
LANG.Id         = "ja"      -- Find corresponding ID in garrysmod/resource/localization
LANG.Author     = "トム"        -- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema                     = "映画館"
LANG.Volume                     = "音量"
LANG.Voteskips                  = "スキップの投票数" -- I'm not sure what voteskips means, this says number of votes to skip
LANG.Loading                    = "読み込み"
LANG.Invalid                    = "【不有効】"
LANG.NoVideoPlaying             = "ビデオを演じてではない"
LANG.Cancel                     = "キャンセル"
LANG.Set                        = "セット"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy       = C("",ColHighlight,"%s",ColDefault,"はこのビデオを依頼しました。")
LANG.Theater_InvalidRequest         = "不有効なビデオの依頼"
LANG.Theater_AlreadyQueued          = "もうこのビデオはキューにです"
LANG.Theater_ProcessingRequest      = C("",ColHighlight,"%s",ColDefault,"の依頼を処理します。")
LANG.Theater_RequestFailed          = "それはビデオの依頼を処理していての問題でした。"
LANG.Theater_Voteskipped            = "当面のビデオがスキップをしました。"
LANG.Theater_ForceSkipped           = C(ColHighlight,"%s",ColDefault,"は当面のビデオをスキップして強制しました。")
LANG.Theater_PlayerReset            = C(ColHighlight,"%s",ColDefault,"は映画館をリセットしました。")
LANG.Theater_LostOwnership          = "あなたは映画館所有権が無くなってので映画館が出ました。"
LANG.Theater_NotifyOwnership        = "今あなたは個人の映画館の持ち主です。"
LANG.Theater_OwnerLockedQueue       = "映画館の持ち主はキューの鍵をかけました。"
LANG.Theater_LockedQueue            = C(ColHighlight,"%s",ColDefault," は映画館キューの鍵をかけました。")
LANG.Theater_UnlockedQueue          = C(ColHighlight,"%s",ColDefault," は映画館キューの鍵をかけませんでした。")
LANG.Theater_OwnerUseOnly           = "それは持ち主だけを使うことができます。"
LANG.Theater_PublicVideoLength      = "公共のビデオの依頼は%s 秒ほどです。"
LANG.Theater_PlayerVoteSkipped      = C(ColHighlight,"%s",ColDefault,"は",ColHighlight,"(%s/%s)",ColDefault,"をスキップして投票しました。")
LANG.Theater_VideoAddedToQueue      = C(ColHighlight,"%s",ColDefault,"はキューに足しました。")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1  = "このマップは映画館ゲームモードで非対応です。"
LANG.Warning_Unsupported_Line2  = "F1を押してにはオフィシャルなマップはワークショップで見えます。"
LANG.Warning_OSX_Line1          = "Mac OS Xユーザーはブランクなスクリーンを経験かもしれない。"
LANG.Warning_OSX_Line2          = "F1を押してには助けてのページで見えてこのメッセージを除きます。"

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title                = "キュー"
LANG.Request_Video              = "ビデオを依頼します"
LANG.Vote_Skip                  = "スキップを投票します"
LANG.Toggle_Fullscreen          = "全画面をトグルします"
LANG.Refresh_Theater            = "映画館をリフレッシュします"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin              = "アドミン"
LANG.Theater_Owner              = "持ち主"
LANG.Theater_Skip               = "スキップ"
LANG.Theater_Seek               = "探して"
LANG.Theater_Reset              = "リセット"
LANG.Theater_ChangeName         = "名前を変更します"
LANG.Theater_QueueLock          = "キューロックをトグルします"
LANG.Theater_SeekQuery          = "HH:MM:SSか何秒です。【例え1:30:00か5400】"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing     = "今上映"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History            = "ビデオ史"
LANG.Request_Clear              = "消して"
LANG.Request_DeleteTooltip      = "ビデオ史からビデオを除きます"
LANG.Request_PlayCount          = "%d 依頼" -- e.g. 10 request(s)
LANG.Request_Url                = "URLを依頼します"
LANG.Request_Url_Tooltip        = "有効なビデオURLを依頼してには押します。いつURLは有効でこのボタンは赤です。"

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title             = "設定"
LANG.Settings_ClickActivate     = "マウスがアクティブ化にはクリックします。"
LANG.Settings_VolumeLabel       = "音量"
LANG.Settings_VolumeTooltip     = "+と-のキーを使ってには音量を変更します。"
LANG.Settings_HDLabel           = "HDビデオプレイバック"
LANG.Settings_HDTooltip         = "HDビデオプレイバックをイネーブルしてにはHDビデオです。"
LANG.Settings_HidePlayersLabel  = "映画館の内にプレイヤーを隠します。"
LANG.Settings_HidePlayersTooltip = "映画館の内に視界のプレイヤーを下げます。"
LANG.Settings_MuteFocusLabel    = "いつでもaltとtabを押して音を黙々します。"
LANG.Settings_MuteFocusTooltip  = "いつでもGarry's Modはアウトフォーカスで映画館の音量を黙々します。"

-- Video Services
LANG.Service_EmbedDisabled      = "このビデオは組み込みことができませんでした。"
LANG.Service_PurchasableContent = "このビデオは不無料で演じことができませんでした。"
LANG.Service_StreamOffline      = "このストリームは非直結です。"

-- Act command (don't bother translating this)
-- modules/taunts/sv_commands.lua
LANG.ActCommand = C(ColHighlight,"%s",ColDefault," %ss") -- e.g. Sam dances

-- Version 1.1
LANG.TranslationsCredit = "%sはこの訳文を書きました。"
