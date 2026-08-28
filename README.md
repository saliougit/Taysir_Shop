# Taysir Shop — PrestaShop (AngarTheme personnalisé)

Boutique en ligne PrestaShop 8.2.1 — cosmétiques, habillement et articles de
spiritualité mouride. Thème `AngarTheme` fortement personnalisé (palette,
header, menu, carrousel, icônes) pour la marque **Taysir Shop**.

Ce document couvre tout ce qu'il faut savoir pour **passer de l'environnement
de développement local (Docker) à un hébergement en production**, avec
**Hostinger** comme hébergeur de référence.

---

## 1. Environnement local actuel

Défini dans [`docker-compose.yml`](docker-compose.yml) :

| Élément | Valeur |
|---|---|
| Image PrestaShop | `prestashop/prestashop:8.2.1` |
| Image MySQL | `mysql:8.0` |
| Port local | `8080` (→ `localhost:8080`) |
| Nom de la base | `prestashop` |
| Utilisateur / mot de passe DB | `root` / `prestashop` |
| Email admin | `admin@example.com` |
| Mot de passe admin | `PrestaAdmin123!` |
| Thème | `AngarTheme`, monté en volume depuis `./theme-local` |
| Devise | XOF (Franc CFA), voir `Configuration::PS_CURRENCY_DEFAULT` |
| Langue | Français (`fr`) |

Commandes de base :

```bash
docker compose up -d          # démarrer
docker compose down           # arrêter
docker compose logs -f        # logs
```

Après toute modification de fichier PHP/Smarty/config (pas les CSS/JS,
servis directement) :

```bash
docker exec prestashop-app sh -c "rm -rf /var/www/html/var/cache/*"
```

⚠️ **Avant tout déploiement**, changez `ADMIN_PASSWD` et `MYSQL_ROOT_PASSWORD`
pour des valeurs fortes — celles ci-dessus ne sont valables qu'en local.

---

## 2. Check-list avant mise en ligne

Ne pas déployer tant que ces points ne sont pas réglés :

- [ ] **Coordonnées réelles** : adresse, téléphone, email pro (actuellement
      "à compléter" dans Préférences → Boutique)
- [ ] **Comptes réseaux sociaux** : liens Facebook/Instagram/WhatsApp réels
      (actuellement décoratifs, sans lien)
- [ ] **Mentions légales / CGV** : à écrire réellement (actuellement des
      pages CMS vides ou génériques)
- [ ] **Moyen de paiement** : PayTech configuré (voir §6)
- [ ] **Nom de domaine** acheté et pointé (voir §5)
- [ ] **`PS_DEV_MODE`** désactivé en production (voir §4.6)
- [ ] **Mot de passe admin** changé, email admin réel
- [ ] Catalogue produits complet (au moins Cosmétiques ; Habillement et
      Spiritualité Mouride à compléter)

---

## 3. Choisir l'offre chez Hostinger

PrestaShop 8 a besoin de :

- PHP 8.1 ou 8.2
- MySQL 5.7+/8.0 ou MariaDB équivalent
- Au moins 256 Mo de mémoire PHP (512 Mo+ recommandé)
- Accès SSH pratique mais non obligatoire (FTP + gestionnaire de fichiers
  suffisent)

Chez **Hostinger**, deux familles de plans conviennent :

- **Hébergement Web "Business" ou "Cloud Startup"** : le plus simple, PHP/MySQL
  géré automatiquement, SSL gratuit inclus, suffisant pour démarrer une
  boutique de cette taille.
- **Hébergement Cloud / VPS** : si vous prévoyez beaucoup de trafic ou voulez
  plus de contrôle (accès root, possibilité de faire tourner Docker si vous
  préférez répliquer l'environnement actuel tel quel).

Pour démarrer, l'hébergement **Business** (mutualisé) est largement
suffisant et le plus simple à administrer.

---

## 4. Déploiement pas à pas

### 4.1 Exporter la base de données locale

```bash
docker exec prestashop-mysql mysqldump -u root -pprestashop prestashop > taysirshop_export.sql
```

### 4.2 Préparer les fichiers à transférer

Deux choses à transférer vers l'hébergement :

1. **Le cœur PrestaShop** : tout le contenu du volume `prestashop_data`
   (dossier `/var/www/html` du conteneur). Pour le récupérer :
   ```bash
   docker cp prestashop-app:/var/www/html ./prestashop_export
   ```
2. **Le thème personnalisé** : le contenu de [`theme-local/`](theme-local)
   doit remplacer `themes/AngarTheme/` dans l'export ci-dessus (il est
   normalement déjà à jour dedans puisqu'il est monté en volume direct).

### 4.3 Créer la base de données et l'utilisateur chez Hostinger

Dans hPanel Hostinger → **Bases de données MySQL** : créer une base et un
utilisateur dédiés (ne pas utiliser `root` en production). Noter le nom
d'hôte de la base fourni par Hostinger (souvent `localhost` en mutualisé).

### 4.4 Importer la base

Via **phpMyAdmin** (fourni dans hPanel) ou en ligne de commande si SSH
disponible :

```bash
mysql -u VOTRE_USER -p -h VOTRE_HOTE VOTRE_BASE < taysirshop_export.sql
```

### 4.5 Transférer les fichiers

Via le **gestionnaire de fichiers Hostinger** ou FTP/SFTP (identifiants dans
hPanel → Fichiers → FTP) : uploader le contenu de `prestashop_export/` à la
racine du domaine (souvent `public_html/`).

### 4.6 Reconfigurer PrestaShop pour le nouvel environnement

Éditer `app/config/parameters.php` (racine du site) avec les identifiants de
la base Hostinger (`database_host`, `database_name`, `database_user`,
`database_password`).

Mettre à jour l'URL de la boutique dans la base — table `ps_shop_url` :

```sql
UPDATE ps_shop_url SET domain = 'votredomaine.com', domain_ssl = 'votredomaine.com'
WHERE id_shop = 1;
```

Désactiver le mode debug (table `ps_configuration`) :

```sql
UPDATE ps_configuration SET value = '0' WHERE name = 'PS_DEV_MODE' OR name = 'PS_DISPLAY_ERRORS';
```

Vider le cache : supprimer le contenu de `var/cache/` sur le serveur (via le
gestionnaire de fichiers ou SSH).

### 4.7 Permissions fichiers

Certains dossiers doivent rester inscriptibles par PHP : `var/`, `img/`,
`upload/`, `download/`, `config/`. En mutualisé Hostinger, `755` sur les
dossiers et `644` sur les fichiers suffit généralement (PHP tourne déjà avec
les bons droits utilisateur).

### 4.8 Vérifier

- Le front (`https://votredomaine.com/`) charge sans erreur
- Le back-office (`https://votredomaine.com/adminXXXXXXXXXX/`, garder un nom
  de dossier admin non devinable) répond et permet la connexion
- Les images produits et le thème s'affichent correctement
- Passer une commande test (avant activation réelle du paiement)

---

## 5. Nom de domaine

1. Acheter le domaine (chez Hostinger directement, ou ailleurs — un domaine
   externe peut toujours pointer vers Hostinger).
2. Si le domaine est acheté ailleurs : dans hPanel → **Domaines**, récupérer
   les serveurs de noms (nameservers) Hostinger, puis les renseigner chez le
   registrar du domaine. La propagation DNS peut prendre jusqu'à 24-48h.
3. Une fois le domaine actif sur Hostinger, activer le **SSL gratuit**
   (Let's Encrypt, automatique dans hPanel → Sécurité → SSL) pour avoir
   `https://` — indispensable pour le paiement en ligne.

---

## 6. Paiement — PayTech

[PayTech](https://paytech.sn) est une passerelle de paiement sénégalaise
(Orange Money, Wave, cartes bancaires, etc.), adaptée à une boutique en FCFA.

Étapes générales (à affiner une fois le compte marchand créé) :

1. Créer un compte marchand sur [paytech.sn](https://paytech.sn) et récupérer
   la clé API (`API_KEY`) et la clé secrète (`API_SECRET`).
2. Installer un module de paiement PayTech pour PrestaShop (module officiel
   ou communautaire selon disponibilité pour PS 8.x — à vérifier sur
   l'Addons Marketplace PrestaShop ou le dépôt GitHub de PayTech).
3. Configurer le module avec les clés API, en mode test d'abord.
4. Renseigner l'URL de callback/IPN fournie par PayTech dans leur dashboard
   pour que les paiements soient confirmés automatiquement côté boutique.
5. Basculer en mode production une fois les paiements test validés.

On reviendra dessus en détail une fois prêts à le brancher.

---

## 7. Après le lancement

- **Sauvegardes** : Hostinger propose des sauvegardes automatiques selon le
  plan — vérifier la fréquence et, si besoin, planifier des exports manuels
  réguliers de la base (`mysqldump`) en plus.
- **Mises à jour PrestaShop/modules** : à faire depuis le back-office
  (Améliorer → Mise à jour), toujours après une sauvegarde.
- **Ajout de produits/catégories** : un guide dédié sera ajouté ici une fois
  le catalogue plus avancé.

---

## Contact technique

Ce projet a été construit avec Claude Code. Pour reprendre le travail, se
référer à ce README et à l'historique du dépôt.
