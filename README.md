# 💰 Mini Système Bancaire COBOL

Un petit projet de **gestion de comptes bancaires** développé en **COBOL** avec **GnuCOBOL**.  
Ce programme simule un mini système bancaire permettant d’ajouter, afficher, rechercher, modifier et supprimer des comptes.

---

## 🧠 Objectif du projet
Ce projet a pour but de :
- pratiquer la programmation structurée en **COBOL** ;
- manipuler la **lecture et l’écriture de fichiers séquentiels** ;
- comprendre la **gestion des données** d’un petit système bancaire ;
- montrer une base concrète de maîtrise du langage COBOL dans un contexte professionnel (secteur bancaire).

---

## ⚙️ Fonctionnalités
✅ **Ajouter un compte** — saisie du nom, type de compte et solde initial  
✅ **Afficher tous les comptes** — lecture complète du fichier `comptes.txt`  
✅ **Rechercher un compte** — par nom du client  
✅ **Effectuer un dépôt ou un retrait** — mise à jour du solde  
✅ **Supprimer un compte** — gestion d’un fichier temporaire `temp.txt`  
✅ **Stockage persistant** — toutes les données sont enregistrées dans `comptes.txt`

---

## 🧩 Structure du projet
📁 mini-banque-cobol/
│
├── banque.cob # Code source COBOL principal
├── comptes.txt # Fichier contenant les comptes bancaires
├── temp.txt # Fichier temporaire utilisé pour la suppression
├── comptes_backup.txt # Sauvegarde du fichier de comptes
└── README.md # Documentation du projet

---

## 🚀 Lancer le projet

### 1️⃣ Installer GnuCOBOL
#### macOS
```bash
brew install gnucobol
Linux (Ubuntu / Debian)
sudo apt install open-cobol
Windows
Installer via Winget :
winget install gnucobol
2️⃣ Compiler le programme
Dans le terminal, place-toi dans le dossier du projet :
cobc -x banque.cob
Cela génère un exécutable nommé banque.
3️⃣ Exécuter le programme
./banque
Le menu suivant apparaîtra :
================================
   MINI SYSTEME BANCAIRE COBOL
================================
1 - Ajouter un compte
2 - Afficher tous les comptes
3 - Rechercher un compte
4 - Dépôt / Retrait
5 - Supprimer un compte
6 - Quitter
Votre choix :
🧾 Exemple de données (comptes.txt)
00001Inès Kezadri       Epargne   00030000020251014
00002David Florella     Courant   00080000020251014
🧱 Concepts COBOL utilisés
Divisions (IDENTIFICATION, ENVIRONMENT, DATA, PROCEDURE)
Gestion de fichiers séquentiels (READ, WRITE, REWRITE)
Boucles et conditions (PERFORM UNTIL, EVALUATE, IF)
Appels système pour remplacer les fichiers (CALL "SYSTEM")
Variables déclarées dans la WORKING-STORAGE SECTION
👩🏽‍💻 Auteur
Linda Florella
Développeuse COBOL junior — passionnée par les systèmes bancaires et la logique métier.
📫 LinkedIn (ajoute ton lien ici)
🐙 GitHub

🧡 Remerciements
Merci à GnuCOBOL et à la communauté open source qui permet de continuer à faire vivre ce langage mythique utilisé dans le monde bancaire.
🏦 Ce projet est un exercice d’apprentissage mais reflète une logique réelle de gestion de comptes en COBOL.

---
