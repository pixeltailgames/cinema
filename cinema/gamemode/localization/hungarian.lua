-- Basic information
LANG.Name       = "Hungarian" -- Native name for language
LANG.Id         = "hu"      -- Find corresponding ID in garrysmod/resource/localization
LANG.Author     = "David Tamas"        -- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema                     = "MOZI"
LANG.Volume                     = "Hangerő"
LANG.Voteskips                  = "Leszavazások"
LANG.Loading                    = "Betöltés..."
LANG.Invalid                    = "[ÉRVÉNYTELEN]"
LANG.NoVideoPlaying             = "Nincs videó lejátszás alatt"
LANG.Cancel                     = "Mégse"
LANG.Set                        = "Beállít"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy       = C("A jelenlegi videót kérte: ",ColHighlight,"%s",ColDefault,".")
LANG.Theater_InvalidRequest         = "Érvénytelen videókérés."
LANG.Theater_AlreadyQueued          = "A kért videó már a sorban van."
LANG.Theater_ProcessingRequest      = C(ColHighlight,"%s",ColDefault,"kérésének feldolgozása...")
LANG.Theater_RequestFailed          = "Hiba törén a kért videó feldolgozása közben."
LANG.Theater_Voteskipped            = "A jelenlegi videót leszavazták."
LANG.Theater_ForceSkipped           = C(ColHighlight,"%s",ColDefault," kényszerítette a következő videó lejátszását.")
LANG.Theater_PlayerReset            = C(ColHighlight,"%s",ColDefault," a mozitermet alaphelyzetbe állította.")
LANG.Theater_LostOwnership          = "Elvesztetted a terem feletti tulajdonjogot, mert kiléptél belőle."
LANG.Theater_NotifyOwnership        = "Te vagy a tulajdonosa a privát teremnek."
LANG.Theater_OwnerLockedQueue       = "A terem tulajdonosa lezárta a sort."
LANG.Theater_LockedQueue            = C(ColHighlight,"%s",ColDefault," lezárta a terem várakozósorát.")
LANG.Theater_UnlockedQueue          = C(ColHighlight,"%s",ColDefault," feloldotta a terem várakozósorát.")
LANG.Theater_OwnerUseOnly           = "Csak a teremtulajdonos képes ezt megcsinálni."
LANG.Theater_PublicVideoLength      = "A nyilvános termek kérései korlátozva vannak %s másodperc hosszúságra."
LANG.Theater_PlayerVoteSkipped      = C(ColHighlight,"%s",ColDefault," szavazott, hogy továbblépjen a következő videóra.",ColHighlight,"(%s/%s)",ColDefault,".")
LANG.Theater_VideoAddedToQueue      = C(ColHighlight,"%s",ColDefault," hozzáadva a sorhoz.")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1  = "A jelenlegi térképet nem támogatja a Mozi játékmód."
LANG.Warning_Unsupported_Line2  = "Nyomd meg az F1 gombot és megnyílik a Műhely a hivatalos pályával."
LANG.Warning_OSX_Line1          = "A Mac OS X felhasználók fekete képernyőt tapasztalhatnak a Moziban."
LANG.Warning_OSX_Line2          = "Az F1 gomb megnyomására hibaelhárító tippeket lehet megtekinteni és ez az üzenet is törlésre kerül."

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title                = "LEJÁTSZÁSI SOR"
LANG.Request_Video              = "Videó kérése"
LANG.Vote_Skip                  = "Szavazás továbblépésről"
LANG.Toggle_Fullscreen          = "Váltás teljes képernyőre"
LANG.Refresh_Theater            = "Terem alaphelyzetbe"

-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin              = "ADMINISZTRÁTOR"
LANG.Theater_Owner              = "TULAJDONOS"
LANG.Theater_Skip               = "Átugrás"
LANG.Theater_Seek               = "Beletekerés"
LANG.Theater_Reset              = "Alaphelyzet"
LANG.Theater_ChangeName         = "Név megváltoztatása"
LANG.Theater_QueueLock          = "Várakozási sor zárása be/ki"
LANG.Theater_SeekQuery          = "ÓÓ:PP:MM vagy a másodpercek száma (1:30:00 vagy 5400)"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing     = "JELENLEG FUT"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History            = "ELŐZMÉNYEK"
LANG.Request_Clear              = "Kitakarítás"
LANG.Request_DeleteTooltip      = "Videó törlése az előzményekből"
LANG.Request_PlayCount          = "%d kérés" -- e.g. 10 request(s)
LANG.Request_Url                = "Eme URL kérése"
LANG.Request_Url_Tooltip        = "Nyomd meg, hogy kérj egy érvényes videót.\nA gomb csak akkor lesz piros, ha az URL érvényes."

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title             = "BEÁLLÍTÁSOK"
LANG.Settings_ClickActivate     = "KATTINTS AZ EGÉR AKTIVÁLÁSÁHOZ"
LANG.Settings_VolumeLabel       = "Hangerő"
LANG.Settings_VolumeTooltip     = "Használd a +/- gombokat a hangerő növeléséhez/csökkentéséhez.."
LANG.Settings_HDLabel           = "HD videólejátszás"
LANG.Settings_HDTooltip         = "HD videólejátszás engedélyezése a HD videóknál."
LANG.Settings_HidePlayersLabel  = "Lejátszó elrejtése a moziban"
LANG.Settings_HidePlayersTooltip = "A lejátszó láthatósága csökkentve van."
LANG.Settings_MuteFocusLabel    = "Alt-Tab esetén némítás"
LANG.Settings_MuteFocusTooltip  = "A mozi hangja némítva lesz, ha a Garry's Mod ablaka nem aktív (pl. Alt-Tab esetén)."

-- Video Services
LANG.Service_EmbedDisabled      = "A kért videó beágyazása nem megengedett."
LANG.Service_PurchasableContent = "A kért videó egy megvásárolandó elem és nem lejátszható."
LANG.Service_StreamOffline      = "A kért stream jelenleg offline."

-- Version 1.1
LANG.TranslationsCredit = "A fordítást készítette: %s"
