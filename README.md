# PlanQR — PostgreSQL

Compose PostgreSQL 15, konfiguracja lokalna i schemat referencyjny sprzed modułu kart. Wersjonowane migracje aplikacji są w repozytorium `planqr-app`. Użytkownik `zut` jest właścicielem bazy `planqr-db-prod` w konfiguracji startowej.

## Lokalny zestaw

Umieść `planqr-db` i `planqr-app` obok siebie. Skrypt `planqr-app/local/start.ps1` uruchamia osobne projekty Compose i łączy je siecią `planqr-local`. PostgreSQL jest dostępny z hosta na `127.0.0.1:55433`, a hasło lokalne znajduje się w `.env.local`.

## Odtworzenie kopii

Do próby ze zrzutem produkcji użyj osobnego projektu, portu i wolumenu. Podaj nazwę projektu przez `-p`, lokalne hasło i wolny `POSTGRES_PORT`. Gdy baza jest pusta, skopiuj zrzut do kontenera i wykonaj:

```sh
pg_restore --single-transaction --no-owner --no-privileges -U zut -d planqr-db-prod /tmp/planqr-db-prod.dump
```

Po odtworzeniu sprawdź schemat względem migracji bazowej w repozytorium aplikacji, oznacz migrację bazową jako zastosowaną i uruchom kolejne. Zrzuty, wolumeny i konfiguracja z hasłami są lokalne. Git ignoruje `.production/` i `.env.local`.
