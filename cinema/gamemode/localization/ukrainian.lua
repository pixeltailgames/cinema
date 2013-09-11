-- Basic information
LANG.Name               = "Ukrainian"     -- Native name for language
LANG.Id                 = "uk"          -- Find corresponding ID in garrysmod/resource/localization
LANG.Author             = "Joker[Rus]"         -- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Common
LANG.Cinema                                     = "CINEMA"
LANG.Volume                                     = "Гучність"
LANG.Voteskips                                  = "Пропуск"
LANG.Loading                                    = "Завантаження..."
LANG.Invalid                                    = "[НЕПРАВИЛЬНО]"
LANG.NoVideoPlaying                             = "Немае Відео"
LANG.Cancel                                     = "Відміна"
LANG.Set                                        = "Встановити"

-- Theater Announcements
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy           = C("Це відео поставив ",ColHighlight,"%s",ColDefault,".")
LANG.Theater_InvalidRequest             = "Неправильний запит відео."
LANG.Theater_AlreadyQueued                      = "Выбранне відео вже е в черзі."
LANG.Theater_ProcessingRequest          = C("Обробка ",ColHighlight,"%s",ColDefault," запита...")
LANG.Theater_RequestFailed                      = "Виникла проблема під час обробки выбранного видео."
LANG.Theater_Voteskipped                        = "Це відео було пропущено із за голосування."
LANG.Theater_ForceSkipped                       = C(ColHighlight,"%s",ColDefault," вимкнув це відео.")
LANG.Theater_PlayerReset                        = C(ColHighlight,"%s",ColDefault," перезавантажив театр.")
LANG.Theater_LostOwnership                      = "Ви втратили володіння над театром із за виходу з театру."
LANG.Theater_NotifyOwnership            = "Ви стали власником цього приватного театру."
LANG.Theater_OwnerLockedQueue           = "Власник театру відключив можливість вставку відео в чергу."
LANG.Theater_LockedQueue                        = C(ColHighlight,"%s",ColDefault," закрив можливість вставки відео.")
LANG.Theater_UnlockedQueue                      = C(ColHighlight,"%s",ColDefault," відкрив возможность вставки видео.")
LANG.Theater_OwnerUseOnly                       = "Тільки власник театру може використовувати це."
LANG.Theater_PublicVideoLength          = "Максимальний ліміт відео в Публічному Театрі %s секунд(и) в довжину."
LANG.Theater_PlayerVoteSkipped          = C(ColHighlight,"%s",ColDefault," проголосував за пропуск ",ColHighlight,"(%s/%s)",ColDefault,".")
LANG.Theater_VideoAddedToQueue          = C(ColHighlight,"%s",ColDefault," було додано в чергу.")

-- Warnings
-- cl_init.lua
LANG.Warning_Unsupported_Line1  = "ця карта не підтримується ігровим режимом Cinema"
LANG.Warning_Unsupported_Line2  = "Натисніть F1 щоб знайти офіційні карти в ВоркШопе"
LANG.Warning_OSX_Line1          = "У Mac OS X користувачів можуть виникнути порожні екрани в Кінотеатрі"
LANG.Warning_OSX_Line2         = "Натисніть F1 щоб отримати поради щодо усунення неполадок і приховати це повідомлення"

-- Queue
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title                                = "Черга"
LANG.Request_Video                              = "Встановити Відео"
LANG.Vote_Skip                                  = "Голосувати За Пропуск"
LANG.Toggle_Fullscreen                  = "Повноекранний Режим"
LANG.Refresh_Theater                    = "Перезавантажити Театр"
 
-- Theater controls
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin                              = "Адмін"
LANG.Theater_Owner                              = "Власник"
LANG.Theater_Skip                               = "Прибрати Відео"
LANG.Theater_Seek                               = "Перемотати"
LANG.Theater_Reset                              = "Перезавантажити"
LANG.Theater_ChangeName                 = "змінити ім'я"
LANG.Theater_QueueLock                  = "Закрити Вставку Відео"
LANG.Theater_SeekQuery                  = "ЧЧ:ММ:СС або число в секундах (приклад. 1:30:00 або 5400)"

-- Theater list
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing             = "Зараз Показують"

-- Request Panel
-- modules/scoreboard/cl_request.lua
LANG.Request_History                    = "Історія"
LANG.Request_Clear                              = "Очистити"
LANG.Request_DeleteTooltip              = "Видалити відео з історії"
LANG.Request_PlayCount                  = "%d переглядів(да)" -- e.g. 10 request(s)
LANG.Request_Url                                = "Вибрати Відео"
LANG.Request_Url_Tooltip                = "Натисніть сюди щоб ​​додати відео в чергу.\nКнопка буде червона якщо ссилка не правильна."

-- Scoreboard settings panel
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title                             = "Налаштування"
LANG.Settings_ClickActivate             = "Клік щоб активувати мишку"
LANG.Settings_VolumeLabel               = "Гучність"
LANG.Settings_VolumeTooltip             = "Використовуйте +/- кнопки щоб ​​збільшити / зменшити гучність."
LANG.Settings_HDLabel                   = "Програвати відео в HD"
LANG.Settings_HDTooltip                 = "Включити відтворення відео високої чіткості на HD, якщо відео в HD."
LANG.Settings_HidePlayersLabel  = "Ховати гравців у театрі"
LANG.Settings_HidePlayersTooltip = "У театрах гравці стануть невидимі для вас."
LANG.Settings_MuteFocusLabel    = "Глушити звук у не ігри"
LANG.Settings_MuteFocusTooltip  = "Відключення звуку театру коли ви в не ігри (наприклад. гра згорнута)."

-- Video Services
LANG.Service_EmbedDisabled              = "Заборонено вставляти вбранне відео."
LANG.Service_PurchasableContent = "Дане відео має заборонений контент, і не може бути поставлено в чергу."
LANG.Service_StreamOffline              = "Запитуваний стрім оффлайн."

-- Version 1.1
LANG.TranslationsCredit = "Переклад виконав %s"