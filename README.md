# Huginn avec Selenium pour Cloudflare

Ce projet permet de déployer [Huginn](https://github.com/huginn/huginn) avec Selenium pour surveiller des sites protégés par Cloudflare et effectuer des actions automatisées.

## 🎯 Objectif

Surveiller la présence d'un texte spécifique sur une page protégée par Cloudflare et envoyer une requête HTTP POST vers une URL lorsque le texte est détecté.

## 🛠️ Composants

- **Huginn** : Plateforme d'automatisation pour créer des agents qui surveillent et agissent sur le web
- **Selenium** : Outil d'automatisation de navigateur pour contourner les protections Cloudflare
- **MySQL** : Base de données pour Huginn
- **Redis** : Stockage en cache pour Huginn

## 🚀 Installation

1. Clonez ce dépôt :

   ```bash
   git clone https://github.com/votre-utilisateur/huginn-selenium.git
   cd huginn-selenium
   ```

2. Configurez les variables d'environnement dans le fichier `.env` :

   ```
   # Modifiez ces valeurs selon vos besoins
   MYSQL_ROOT_PASSWORD=password
   MYSQL_DATABASE=huginn
   MYSQL_USER=huginn
   MYSQL_PASSWORD=password
   APP_SECRET_TOKEN=your_secret_token_at_least_30_chars_long
   DOMAIN=localhost
   PORT=3000
   ```

3. Lancez les conteneurs avec Docker Compose :

   ```bash
   docker-compose up -d
   ```

4. Accédez à Huginn dans votre navigateur :

   ```
   http://localhost:3000
   ```

5. Connectez-vous avec les identifiants par défaut :
   - Utilisateur : admin
   - Mot de passe : password

## 📋 Configuration des agents

Voir le fichier `tofo.md` pour un exemple complet de configuration des agents Huginn pour surveiller une page protégée par Cloudflare.

## 🔄 Différences entre les fichiers docker-compose

- `docker-compose.yaml` : Utilise une image Selenium personnalisée avec support de proxy
- `docker-compose.yml` : Utilise l'image Selenium officielle sans proxy

Choisissez celui qui convient le mieux à vos besoins.

## 📝 Notes

- Le service Selenium est configuré pour contourner les détections d'automatisation
- L'image Selenium personnalisée télécharge automatiquement une liste de proxies pour éviter les blocages
- Vous pouvez personnaliser les agents Huginn selon vos besoins spécifiques

## 🔒 Sécurité

Modifiez les mots de passe par défaut dans le fichier `.env` avant de déployer en production.
