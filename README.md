# server-pulse
Outil de monitoring serveur gratuit, fonctionnant sous Windows (PowerShell + interface web), ultra-léger et déployable en une minute.

=====================================================
          SERVER PULSE - MONITORING DASHBOARD V1.5
=====================================================

Ce système de monitoring local permet de surveiller la santé 
réseau et applicative de vos serveurs en toute confidentialité.

---
1. CONFIGURATION DU FICHIER SITES.TXT
---
Le fichier 'sites.txt' accepte désormais jusqu'à 4 colonnes. 
[cite_start]Format : URL, MOT-CLEF, OPTION1, OPTION2 [cite: 9]

Scénarios de configuration :
* Ping + Web :
  [cite_start]google.com,Google [cite: 9]
* Web uniquement (Serveur sous pare-feu ICMP) :
  [cite_start]monserveur.com,Bienvenue,noping [cite: 9]
* Ping uniquement (Serveur non-web, ex: Active Directory) :
  192.168.1.10,AD,noweb
* Invisible (Affiche N/A partout) :
  interne.local,Stats,noping,noweb

---
2. COMPRENDRE LES INDICATEURS
---
* [cite_start]CYCLE : Nombre de scans effectués depuis l'ouverture du script. [cite: 1]
* OK (Vert) : Le serveur est totalement opérationnel (ou opérationnel 
  selon les options choisies).
* WARNING (Orange) : Le serveur répond au Ping, mais le service Web est 
  en panne ou le mot-clef est introuvable.
* OFFLINE (Rouge) : Le serveur est totalement injoignable.
* N/A (Gris) : Le test a été volontairement désactivé pour ce serveur.

---
3. FONCTIONNALITÉS DE L'INTERFACE
---
* FAVORIS (★) : Épingle les serveurs critiques en haut de page.
* LIEN DIRECT (🔗) : Ouvre l'URL du serveur dans un nouvel onglet.
* GRAPHIQUE DE TENDANCE : Affiche l'historique de disponibilité du parc. 
  La légende permet de distinguer la santé Réseau (Ping) de la santé 
  Applicative (Web).

---
4. NOTES TECHNIQUES
---
* PERSISTANCE : Vos favoris sont stockés dans le 'Local Storage' de votre 
  navigateur.
* HISTORIQUE : Le graphique se réinitialise si vous fermez et relancez 
  le fichier 'monitor.bat'.
* SÉCURITÉ : Aucune donnée n'est transmise à l'extérieur de votre réseau. 
  L'application fonctionne exclusivement via le fichier local 'data.js'.

=====================================================
Optimisé pour une surveillance haute densité.
=====================================================

Besoin d'un logiciel CRM pour votre entreprise ? Visitez : https://simple-crm.ai
