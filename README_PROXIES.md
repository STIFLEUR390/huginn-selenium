# Mise à jour automatique des proxies pour Huginn-Selenium

Ce document explique comment utiliser le script `update_proxies.bat` pour mettre à jour automatiquement la liste des proxies dans votre configuration Huginn-Selenium.

## Fonctionnement du script

Le script `update_proxies.bat` effectue les opérations suivantes :

1. Télécharge une liste de proxies HTTP depuis l'API GeoNode
2. Filtre les 50 premiers proxies HTTP fonctionnels
3. Formate la liste au format CSV (valeurs séparées par des virgules)
4. Met à jour la variable `PROXY_LIST` dans le fichier `.env`

## Utilisation manuelle

Pour mettre à jour manuellement la liste des proxies :

1. Double-cliquez sur le fichier `update_proxies.bat`
2. Attendez que le script termine son exécution
3. Vérifiez que le fichier `.env` a été mis à jour avec la nouvelle liste de proxies

## Automatisation

Vous pouvez automatiser la mise à jour des proxies en ajoutant le script au Planificateur de tâches Windows :

1. Ouvrez le Planificateur de tâches Windows
2. Créez une nouvelle tâche
3. Dans l'onglet "Actions", ajoutez une nouvelle action :
   - Action : Démarrer un programme
   - Programme/script : `C:\Users\Dev Master\Documents\huginn-selenium\update_proxies.bat`
   - Démarrer dans : `C:\Users\Dev Master\Documents\huginn-selenium`
4. Configurez le déclencheur selon vos besoins (par exemple, tous les jours à 6h00)

## Redémarrage des conteneurs

Après la mise à jour des proxies, vous devrez redémarrer le conteneur Selenium pour que les changements prennent effet :

```batch
docker-compose -f docker-compose.yaml restart selenium
```

Vous pouvez également ajouter cette commande à la fin du script `update_proxies.bat` si Docker est installé et accessible via la ligne de commande.

## Dépannage

Si le script ne fonctionne pas correctement :

1. Vérifiez que `curl` est installé et accessible dans le PATH Windows
2. Vérifiez que PowerShell est disponible sur votre système
3. Assurez-vous que le fichier `.env` existe et contient une ligne commençant par `PROXY_LIST=`

## Remarques

Ce script est l'équivalent Windows du script `entrypoint.sh` utilisé dans le conteneur Selenium. Il permet de mettre à jour les proxies sans avoir à reconstruire l'image Docker.
