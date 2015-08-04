-- Podstawowe informacje
LANG.Name       = "Polski" -- Native name for language
LANG.Id         = "pl"      -- Find corresponding ID in garrysmod/resource/localization
LANG.Author     = "Halamix2"        -- Chain authors if necessary (e.g. "Sam, MacDGuy, Foohy")

-- Ogólne
LANG.Cinema                     = "KINO"
LANG.Volume                     = "Głośność"
LANG.Voteskips                  = "Voteskips" --I don't know how to translate it in short, "Żądania pominięcia" is too long, plus I haven't seen this in-game
LANG.Loading                    = "Ładowanie..."
LANG.Invalid                    = "[NIEPRAWIDŁOWE]"
LANG.NoVideoPlaying             = "Brak odtwarzanego filmu"
LANG.Cancel                     = "Anuluj"
LANG.Set                        = "Ustaw"

-- Ogłoszenia sal kinowych
-- modules/theater/cl_init.lua
-- modules/theater/sh_commands.lua
-- modules/theater/sh_theater.lua
LANG.Theater_VideoRequestedBy       = C("Obecny film został zażądany przez ",ColHighlight,"%s",ColDefault,".")
LANG.Theater_InvalidRequest         = "Nieprawidłowe żądanie filmu."
LANG.Theater_AlreadyQueued          = "Żądany film jest już w kolejce."
LANG.Theater_ProcessingRequest      = C("Przetwarzanie żądania ",ColHighlight,"%s",ColDefault,"...")
LANG.Theater_RequestFailed          = "Wystąpił problem podczas przetwarzania żądanego filmu."
LANG.Theater_Voteskipped            = "Zostało przegłosowane pominięcie obecnego filmu."
LANG.Theater_ForceSkipped           = C(ColHighlight,"%s",ColDefault," wymusił pominięcie obecnego filmu.")
LANG.Theater_PlayerReset            = C(ColHighlight,"%s",ColDefault," zresetował salę kinową.")
LANG.Theater_LostOwnership          = "Straciłeś posiadanie sali kinowej z powodu opuszczenia jej."
LANG.Theater_NotifyOwnership        = "Jesteś teraz właścicielem prywatnej sali kinowej."
LANG.Theater_OwnerLockedQueue       = "Właściciel sali kinowej zablokował kolejkę."
LANG.Theater_LockedQueue            = C(ColHighlight,"%s",ColDefault," zablokował kolejkę sali kinowej.")
LANG.Theater_UnlockedQueue          = C(ColHighlight,"%s",ColDefault," odblokował kolejkę sali kinowej.")
LANG.Theater_OwnerUseOnly           = "Tylko właściciel sali kinowej może tego używać."
LANG.Theater_PublicVideoLength      = "Żądania w publicznych salach kinowych są ograniczone do długości %s sekund."
LANG.Theater_PlayerVoteSkipped      = C(ColHighlight,"%s",ColDefault," zagłosował na pominięcie ",ColHighlight,"(%s/%s)",ColDefault,".")
LANG.Theater_VideoAddedToQueue      = C(ColHighlight,"%s",ColDefault," zostało dodane do kolejki.")

-- Ostrzeżenia
-- cl_init.lua
LANG.Warning_Unsupported_Line1  = "Obecna mapa jest niewspierana przez tryb gry Cinema"
LANG.Warning_Unsupported_Line2  = "Naciśnij F1 aby otworzyć oficjalną mapę w workshopie"
LANG.Warning_OSX_Line1          = "Użytkownicy Mac OS X mogą doświadczyć pustych ekranów w Kinie"
LANG.Warning_OSX_Line2          = "Naciśnij F1 aby zobaczyć porady jak rozwiązać problem oraz zamknąć tę wiadomość"

-- Kolejka
-- modules/scoreboard/cl_queue.lua
LANG.Queue_Title                = "KOLEJKA"
LANG.Request_Video              = "Zażądaj wideo"
LANG.Vote_Skip                  = "Głosuj pominięcie"
LANG.Toggle_Fullscreen          = "Przełącz pełny ekran"
LANG.Refresh_Theater            = "Odśwież ekran kinowy"

-- Sterowanie salą kinową
-- modules/scoreboard/cl_admin.lua
LANG.Theater_Admin              = "ADMINISTRATOR"
LANG.Theater_Owner              = "WŁAŚCICIEL"
LANG.Theater_Skip               = "Pomiń"
LANG.Theater_Seek               = "Szukaj"
LANG.Theater_Reset              = "Resetuj"
LANG.Theater_ChangeName         = "Zmień nazwę"
LANG.Theater_QueueLock          = "Przełącz blokadę kolejki"
LANG.Theater_SeekQuery          = "HH:MM:SS lub liczba w sekundach (np. 1:30:00 lub 5400)"

-- Lista sal kinowych
-- modules/scoreboard/cl_theaterlist.lua
LANG.TheaterList_NowShowing     = "OBECNIE GRAMY"

-- Panel żądań
-- modules/scoreboard/cl_request.lua
LANG.Request_History            = "HISTORIA"
LANG.Request_Clear              = "Wyczyść"
LANG.Request_DeleteTooltip      = "Usuwa filmy z historii"
LANG.Request_PlayCount          = "%d żądań" -- np. 10 żądań
LANG.Request_Url                = "Zażądaj URL"
LANG.Request_Url_Tooltip        = "Naciśnij aby zażądać prawidłowego URL wideo.\nPrzycisk będzie czerwony gdy link jest prawidłowy"

-- Panel ustawień tablicy wyników
-- modules/scoreboard/cl_settings.lua
LANG.Settings_Title             = "USTAWIENIA"
LANG.Settings_ClickActivate     = "KLIKNIJ ABY AKTYWOWAĆ MYSZ"
LANG.Settings_VolumeLabel       = "Głośność"
LANG.Settings_VolumeTooltip     = "Użyj klawiszy +/- aby zwiększyć/zmniejszyć głośność."
LANG.Settings_HDLabel           = "Odtwarzanie wideo w HD"
LANG.Settings_HDTooltip         = "Włącz odtwarzanie wideo w HD dla wideo z włączonym HD."
LANG.Settings_HidePlayersLabel  = "Ukryj graczy w sali kinowej"
LANG.Settings_HidePlayersTooltip = "Zmniejsza widoczność graczy w środku sal kinowych."
LANG.Settings_MuteFocusLabel    = "Wycisz audio podczas alt-tabowania"
LANG.Settings_MuteFocusTooltip  = "Wycisza salę kinową podczas gdy Garry's Mod jest nieaktywne (np. alt-tabowałeś)."

-- Serwisy wideo
LANG.Service_EmbedDisabled      = "Żądany film ma wyłączone osadzanie."
LANG.Service_PurchasableContent = "Żądany film jest zawartością do kupienia i nie może zostać odtworzony."
LANG.Service_StreamOffline      = "Żądany stream jest offline."

-- Komendy zachowań (nie przejmuj się tłumaczeniem tego)
-- modules/taunts/sv_commands.lua
LANG.ActCommand = C(ColHighlight,"%s",ColDefault," %ss") -- np. Sam dances (untranslable, at least for now)

-- Werrsja 1.1
LANG.TranslationsCredit = "Tłumaczenie przez %s"