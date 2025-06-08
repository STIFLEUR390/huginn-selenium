Parfait ! Voici un exemple complet de scénario Huginn composé de deux agents :

---

## 🧠 Objectif

> Surveiller la présence d’un texte spécifique sur une page protégée par Cloudflare et envoyer une requête HTTP POST vers une URL lorsque le texte est détecté.

---

## 🧩 1. `BrowserAgent` (avec Selenium)

Ce premier agent utilise le WebDriver Selenium (via Chrome) pour charger dynamiquement une page et rechercher un texte.

```json
{
  "type": "Agents::BrowserAgent",
  "name": "Surveillance de texte avec Selenium",
  "options": {
    "url": "https://exemple.com/page",
    "expected_update_period_in_days": "1",
    "selenium_url": "http://selenium:4444/wd/hub",
    "script": "return document.body.innerText.includes('Texte attendu');",
    "extract": {
      "texte_trouve": {
        "path": "result",
        "value": "Texte détecté"
      }
    }
  },
  "schedule": "every_1h",
  "propagate_immediately": true
}
```

> 📝 Cette configuration exécute un script JS (`document.body.innerText.includes(...)`) sur la page rendue par le navigateur headless.

---

## 🧩 2. `TriggerAgent`

Déclenché uniquement si le texte est trouvé. Il déclenchera un `WebhookAgent`.

```json
{
  "type": "Agents::TriggerAgent",
  "name": "Déclenchement si texte trouvé",
  "options": {
    "expected_update_period_in_days": "1",
    "rules": [
      {
        "type": "regex",
        "value": "Texte détecté",
        "path": "texte_trouve"
      }
    ],
    "message": "Texte trouvé"
  }
}
```

---

## 🧩 3. `HttpRequestAgent`

Ce dernier agent envoie une notification via requête HTTP POST vers l’URL de ton choix.

```json
{
  "type": "Agents::HttpRequestAgent",
  "name": "Notification API externe",
  "options": {
    "expected_update_period_in_days": "1",
    "method": "post",
    "url": "https://ton-api.com/endpoint",
    "headers": {
      "Content-Type": "application/json",
      "Authorization": "Bearer VOTRE_JETON"
    },
    "payload": {
      "message": "Texte détecté sur la page !",
      "url": "{{url}}",
      "timestamp": "{{_created_at}}"
    },
    "emit_events": false
  }
}
```

---

## 🔗 Connexion des agents dans Huginn

1. Va dans l’onglet **Scénarios**
2. Crée un **Scénario** nommé "Surveillance texte Cloudflare"
3. Ajoute les 3 agents dedans
4. Relie :

   * `BrowserAgent` → `TriggerAgent`
   * `TriggerAgent` → `HttpRequestAgent`

---

Souhaite-tu que je t’exporte tout cela en un fichier JSON à importer directement dans Huginn ?
