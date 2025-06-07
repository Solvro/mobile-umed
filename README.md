# Umed x Solvro – Zdrowie gra pierwsze skrzypce

## 🇵🇱

**Umed x Solvro – Zdrowie gra pierwsze skrzypce** to aplikacja mobilna rozwijana przez zespół Solvro, której głównym celem jest wspieranie użytkowników w dbaniu o zdrowie. Projekt skupia się na dostarczaniu narzędzi i funkcjonalności, które pomagają monitorować, analizować i poprawiać stan zdrowia na co dzień.

## 🇬🇧

**Umed x Solvro – Health Takes Center Stage** is a mobile application developed by the Solvro team. Its main goal is to support users in taking care of their health. The project focuses on providing tools and features that help monitor, analyze, and improve your health on a daily basis.

---

## Table of Contents

- [Getting Started](#getting-started)
- [Important Links](#important-links)
- [Technologies](#technologies)
- [Team](#team)
- [Collaboration Guidelines](#collaboration-guidelines)
- [Git Workflow](#git-workflow)
- [Before You Commit](#before-you-commit)
- [Additional Notes](#additional-notes)
- [Contact](#contact)

---

## Getting Started

1. Install git hooks:

```bash
dart run husky install
```

2. Install git-crypt according to the [instructions](https://github.com/AGWA/git-crypt/blob/master/INSTALL.md), place the symmetric key, and unlock the repository:

```bash
git-crypt unlock <path-to-the-key>
```

3. Generate build runner files:

```bash
dart run build_runner build -d
```

4. Run the Flutter app as usual.

---

## Important Links

- **Recommended VS Code settings:** [Solvro Mobile Settings](https://docs.solvro.pl/sections/mobile/)
- **GitHub workflow guide:** [Solvro GitHub Guide](https://docs.solvro.pl/github)
- **Commit convention:** [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
- **Discord channel:** \#mobile in the Umed x Solvro category

---

## Technologies

- Flutter (Dart)
- git-crypt (for key management)
- Husky (git hooks)
- build_runner

---

## Team


- [@tomasz-trela](https://github.com/tomasz-trela) – Flutter Techlead 
- [@24bartixx](https://github.com/24bartixx) – Flutter Techlead 
- [@simplyNoOne](https://github.com/simplyNoOne) – Flutter Developer
- [@BombardierBulge](https://github.com/BombardierBulge) – Flutter Developer
- [@eTraveler04](https://github.com/eTraveler04) – Flutter Developer
- [@marekpolanowski](https://github.com/marekpolanowski) – UI/UX Designer



---

## Collaboration Guidelines

- We follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) convention.
- Detailed instructions for branching, task management, and pull requests can be found in the [Solvro GitHub Guide](https://docs.solvro.pl/github).
- All questions and discussions take place on Discord, \#mobile channel.

---

## Git Workflow

1. **Create a new branch for each task/feature:**

```bash
git checkout main
git pull origin main
git checkout -b feature/your-feature-name
```

2. **Work on your changes, then commit:**

```bash
git add .
git commit -m "feat: short description of your change"
```

3. **Push your branch and open a Pull Request:**

```bash
git push origin feature/your-feature-name
```

4. **After code review and merge, clean up:**

```bash
git branch -d feature/your-feature-name
git push origin --delete feature/your-feature-name
```


> **Do not push directly to the main branch! Always use Pull Requests and code review.**

---

## Before You Commit

- Run the linter:

```bash
flutter analyze
```

- Autofix issues:

```bash
dart fix --apply
```

- Format the code:

```bash
dart format .
```

- Run custom linter (if available):

```bash
dart run custom_lint
```


---

## Additional Notes

- For theme usage, see: `/lib/app/theme`
- For internationalization: [Flutter Internationalization Guide](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization)
- For asset generation, we use [flutter_gen](https://pub.dev/packages/flutter_gen)
- For navigation, we use [go_router](https://pub.dev/packages/go_router)
---

## Contact

If you have any questions or suggestions, contact the team via Discord or by emailing the Solvro team.

---
