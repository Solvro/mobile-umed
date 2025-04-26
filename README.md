# Umed x Solvro – Zdrowie gra pierwsze skrzypce

## Opis projektu

**Umed x Solvro – Zdrowie gra pierwsze skrzypce** to aplikacja mobilna rozwijana przez zespół Solvro, której głównym celem jest wspieranie użytkowników w dbaniu o zdrowie. Projekt skupia się na dostarczaniu narzędzi i funkcjonalności, które pomagają monitorować, analizować i poprawiać stan zdrowia na co dzień.

## Spis treści

- [Uruchomienie aplikacji](#uruchomienie-aplikacji)
- [Ważne linki](#wa%C5%BCne-linki)
- [Technologie](#technologie)
- [Zasady współpracy](#zasady-wsp%C3%B3%C5%82pracy)
- [Kontakt](#kontakt)


## Uruchomienie aplikacji

1. Uruchom instalację hooków:

```bash
dart run husky install
```

2. Zainstaluj git-crypt według [instrukcji](https://github.com/AGWA/git-crypt/blob/master/INSTALL.md), umieść klucz symetryczny i odblokuj repozytorium:

```bash
git-crypt unlock <path-to-the-key>
```

3. Wygeneruj pliki build runnera:

```bash
dart run build_runner build -d
```

4. Uruchom Fluttera jak zawsze.

## Ważne linki

- **Zalecane ustawienia do VS Code:** [Solvro Mobile Settings](https://docs.solvro.pl/sections/mobile/)
- **Instrukcja pracy z GitHubem:** [Solvro GitHub Guide](https://docs.solvro.pl/github)
- **Konwencja commitów:** [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
- **Kanał na Discordzie:** \#mobile w kategorii Umed x Solvro


## Technologie

- Flutter (Dart)
- git-crypt (do zarządzania kluczami)
- Husky (hooki gitowe)
- build_runner


## Zasady współpracy

- Pracujemy zgodnie z konwencją commitów [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).
- Szczegółowe instrukcje dotyczące branchowania, obsługi zadań i pull requestów znajdziesz w [Solvro GitHub Guide](https://docs.solvro.pl/github).
- Wszelkie pytania i dyskusje prowadzimy na Discordzie, kanał \#mobile.

## Kontakt

W przypadku pytań lub sugestii skontaktuj się z zespołem na Discordzie lub przez e-mail zespołu Solvro.
