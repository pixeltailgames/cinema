-- Basic information
LANG.Name       = "日本語" -- Native name for language
LANG.Id         = "ja"      -- Find corresponding ID in garrysmod/resource/localization
LANG.Author     = "f122apg"        -- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema                     = "CINEMA"
LANG.Volume                     = "音量"
LANG.Voteskips                  = "スキップの投票数" -- I'm not sure what voteskips means, this says number of votes to skip
LANG.Loading                    = "読み込み中..."
LANG.Invalid                    = "【無効】"
LANG.NoVideoPlaying             = "再生中の動画はありません。"
LANG.Cancel                     = "キャンセル"
LANG.Set                        = "セット"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy       = C("",ColHighlight,"%s",ColDefault,"は動画をリクエストしました。")
LANG.Theater_InvalidRequest         = "無効なリクエスト"
LANG.Theater_AlreadyQueued          = "この動画は既にキューに存在しています。"
LANG.Theater_ProcessingRequest      = C("",ColHighlight,"%s",ColDefault,"はリクエスト処理中です。")
LANG.Theater_RequestFailed          = "リクエスト処理が失敗しました。"
LANG.Theater_Voteskipped            = "この動画は投票により、スキップされました。"
LANG.Theater_ForceSkipped           = C(ColHighlight,"%s",ColDefault,"は動画を強制的にスキップしました。")
LANG.Theater_PlayerReset            = C(ColHighlight,"%s",ColDefault,"はtheaterをリセットしました。")
LANG.Theater_LostOwnership          = "あなたはPrivate theaterを抜けた為、オーナー権限が失われました。"
LANG.Theater_NotifyOwnership        = "あなたはPrivate theaterのオーナーになりました。"
LANG.Theater_OwnerLockedQueue       = "オーナーがキューにロックをかけました。"
LANG.Theater_LockedQueue            = C(ColHighlight,"%s",ColDefault," はキューにロックをかけました。")
LANG.Theater_UnlockedQueue          = C(ColHighlight,"%s",ColDefault," はキューのロックを解除しました。")
LANG.Theater_OwnerUseOnly           = "オーナーだけが使用できます。"
LANG.Theater_PublicVideoLength      = "Public theaterは%s秒に1度リクエストできます。"
LANG.Theater_PlayerVoteSkipped      = C(ColHighlight,"%s",ColDefault,"は",ColHighlight,"(%s/%s)",ColDefault,"をスキップ投票しました。")
LANG.Theater_VideoAddedToQueue      = C(ColHighlight,"%s",ColDefault,"はキューを追加しました。")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1  = "このマップはCinema gamemodeに対応していません。"
LANG.Warning_Unsupported_Line2  = "F1を押すとワークショップにある公式のマップを開きます。"
LANG.Warning_OSX_Line1          = "Mac OS Xユーザーは画面に何も表示されないかもしれません。"
LANG.Warning_OSX_Line2          = "F1を押してトラブルシューティングを開いて、このメッセージを消します。"

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title                = "キュー"
LANG.Request_Video              = "動画をリクエストする"
LANG.Vote_Skip                  = "スキップに投票する"
LANG.Toggle_Fullscreen          = "フルスクリーンに変更する"
LANG.Refresh_Theater            = "theaterを更新する"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin              = "管理者"
LANG.Theater_Owner              = "オーナー"
LANG.Theater_Skip               = "スキップ"
LANG.Theater_Seek               = "シーク"
LANG.Theater_Reset              = "リセット"
LANG.Theater_ChangeName         = "名前を変更"
LANG.Theater_QueueLock          = "キューをロック"
LANG.Theater_SeekQuery          = "HH:MM:SSまたは秒数【例 1:30:00または5400】"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing     = "上映中"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History            = "履歴"
LANG.Request_Clear              = "クリア"
LANG.Request_DeleteTooltip      = "履歴から削除する"
LANG.Request_PlayCount          = "リクエスト回数：%d" -- e.g. 10 request(s)
LANG.Request_Url                = "リクエストURL"
LANG.Request_Url_Tooltip        = "URLが有効な時にリクエストを押します。\nこのボタンが赤い時はリクエスト可能な動画です。"

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title             = "設定"
LANG.Settings_ClickActivate     = "マウスをアクティブにするにはクリックします。"
LANG.Settings_VolumeLabel       = "音量"
LANG.Settings_VolumeTooltip     = "+/-キーで音量の上げ/下げが可能です。"
LANG.Settings_HDLabel           = "HD動画を再生"
LANG.Settings_HDTooltip         = "有効にするとHD動画が再生されます。"
LANG.Settings_HidePlayersLabel  = "プレイヤーを非表示"
LANG.Settings_HidePlayersTooltip = "theater内にいるプレイヤーを非表示にします。"
LANG.Settings_MuteFocusLabel    = "ウィンドウ切り替え時、ミュートにする"
LANG.Settings_MuteFocusTooltip  = "Garry's Modから別ウィンドウに切り替えた時にミュートします。(Alt+Tabを押した時など)"

-- Video Services
LANG.Service_EmbedDisabled      = "リクエストされた動画は埋め込みを無効にしています。"
LANG.Service_PurchasableContent = "リクエストされた動画は有料の動画なので再生できません。"
LANG.Service_StreamOffline      = "リクエストされたストリームはオフラインです。"

-- Act command (don't bother translating this)
-- modules/taunts/sv_commands.lua
LANG.ActCommand = C(ColHighlight,"%s",ColDefault," %ss") -- e.g. Sam dances

-- Version 1.1
LANG.TranslationsCredit = "翻訳者：%s"
