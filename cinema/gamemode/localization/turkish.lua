LANG.Name                = "Turkish"        -- Native name for language
LANG.Id                        = "tr"                -- Find corresponding ID in garrysmod/resource/localization
LANG.Author                = "Arda Turkmen"                -- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema                                                = "CINEMA"
LANG.Volume                                                = "Ses"
LANG.Voteskips                                        = "Gecmek icin oyla"
LANG.Loading                                        = "Yukleniyor..."
LANG.Invalid                                        = "[Bilinmiyor]"
LANG.NoVideoPlaying                                = "Herhangi bir video oynamiyor"
LANG.Cancel                                                = "Iptal"
LANG.Set                                                = "Ayarla"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy                 = C("Suanki video su kisi tarafindan acildi ",ColHighlight,"%s",ColDefault,".")
LANG.Theater_InvalidRequest                 = "Bilinmeyen video istegi."
LANG.Theater_AlreadyQueued                         = "Belirtilen video zaten oynatiliyor."
LANG.Theater_ProcessingRequest                 = C("Su kisi tarafindan video isleniyor ",ColHighlight,"%s",ColDefault,"")
LANG.Theater_RequestFailed                         = "Belirtilen video ile ilgili bir problem var."
LANG.Theater_Voteskipped                         = "Suanki video oy istegiyle gecildi."
LANG.Theater_ForceSkipped                         = C(ColHighlight,"%s",ColDefault," vidoyu gecmek icin zor kullandi.")
LANG.Theater_PlayerReset                         = C(ColHighlight,"%s",ColDefault," adli oyuncu sahneyi resetledi.")
LANG.Theater_LostOwnership                         = "Tiyatrodan ayrildigi icin yonetmeni kaybettin."
LANG.Theater_NotifyOwnership                 = "Su anda tiyatro baskani sensin."
LANG.Theater_OwnerLockedQueue                 = "Tiyatro sahibi odayi kitledi."
LANG.Theater_LockedQueue                         = C(ColHighlight,"%s",ColDefault," adli kisi odayi kitledi.")
LANG.Theater_UnlockedQueue                         = C(ColHighlight,"%s",ColDefault," adli kisi kilidi kaldirdi.")
LANG.Theater_OwnerUseOnly                         = "Sadece tiyatro sahibi bunu kullanabilir."
LANG.Theater_PublicVideoLength                 = "Bu acik tiyatrodaki videolar sadece %s saniye oynatilabilir."
LANG.Theater_PlayerVoteSkipped                 = C(ColHighlight,"%s",ColDefault," adli kisi videoyu gecmek icin oylama baslatti ",ColHighlight,"(%s/%s)",ColDefault,".")
LANG.Theater_VideoAddedToQueue                 = C(ColHighlight,"%s",ColDefault," adli kisi kuyruga girdi.")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1        = "Suanki harita Cinema tarafindan desteklenmiyor"
LANG.Warning_Unsupported_Line2        = "Resmi haritayi acmak icin F1 tusuna basin"
LANG.Warning_OSX_Line1                        = "Mac OS X kullanicilari Cinema'da siyah ekran ile karsilasabilir"
LANG.Warning_OSX_Line2                        = "Sorun giderme mesajlarini ve bu mesaji silmek icin F1 tusuna basin"

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title                                = "KUYRUK"
LANG.Request_Video                                 = "Video Ac"
LANG.Vote_Skip                                         = "Oylama Baslat"
LANG.Toggle_Fullscreen                         = "Tam ekran yap"
LANG.Refresh_Theater                        = "Tiyatroyu yenile"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin                                = "ADMIN"
LANG.Theater_Owner                                = "SAHIP"
LANG.Theater_Skip                                = "Gec"
LANG.Theater_Seek                                = "Ara"
LANG.Theater_Reset                                = "Yeniden baslat"
LANG.Theater_ChangeName                        = "Isim degistir"
LANG.Theater_QueueLock                        = "Kurugu kitle/ac"
LANG.Theater_SeekQuery                        = "HH:MM:SS veya su kadar sure (e.g. 1:30:00 or 5400)"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing                = "SU ANDA GOSTERILIYOR"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History                        = "GECMIS"
LANG.Request_Clear                                = "Temizle"
LANG.Request_DeleteTooltip                = "Bu videoyu gecmisten temizle"
LANG.Request_PlayCount                        = "%d talep" -- e.g. 10 talep var
LANG.Request_Url                                = "URL Sec"
LANG.Request_Url_Tooltip                = "Lutfen gecerli bir URL girin.\nEger URL gecerliyse buton kirmizi yanacaktir"

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title                                = "AYARLAR"
LANG.Settings_ClickActivate                = "MOUSEYI AKTIF ETMEK ICIN TIKLA"
LANG.Settings_VolumeLabel                = "Ses Seviyesi"
LANG.Settings_VolumeTooltip                = "Sesi yukseltmek icin +/- tuslarini kullanin."
LANG.Settings_HDLabel                        = "HD Videolar"
LANG.Settings_HDTooltip                        = "HD olan videolari en yuksek kalitede oynat."
LANG.Settings_HidePlayersLabel        = "Tiyatrodaki oyunculari gizle"
LANG.Settings_HidePlayersTooltip = "Tiyatro icinde oyuncularin gorunurluklerini azalt."
LANG.Settings_MuteFocusLabel        = "Alt-tab yapildiginda sesi kapat"
LANG.Settings_MuteFocusTooltip        = "Garry's Mod kapaliyken sesi kapat (e.g. you alt-tabbed)."

-- Video Services
LANG.Service_EmbedDisabled                 = "Talep edilen videoda gomme kapalidir."
LANG.Service_PurchasableContent = "Talep edilen video satin alinabilir icerik icerdigi icin acilamamaktadir."
LANG.Service_StreamOffline                 = "Sectiginiz canli yayin aktif degil."

-- Version 1.1
LANG.TranslationsCredit = "Ceviri %s tarafindan yapildi"