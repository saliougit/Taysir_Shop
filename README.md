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

## 3. Offre retenue chez Hostinger : VPS KVM 2 (Docker)

Plutôt que de migrer vers un hébergement mutualisé classique (PHP/MySQL sans
Docker), le choix retenu est un **VPS** chez Hostinger : accès root complet,
donc on fait tourner **le même projet Docker** qu'en local (mêmes images,
même thème monté en volume), avec un fichier
[`docker-compose.prod.yml`](docker-compose.prod.yml) dédié à la prod
(HTTPS, mots de passe via `.env`, pas d'exposition directe du port 8080—
détail dans [PRODUCTION_STACK.md](PRODUCTION_STACK.md)). C'est le
déploiement le plus simple et le plus fidèle à ce qui a été testé jusqu'ici
— pas de migration vers une structure de fichiers différente.

### Comparatif des plans (pack 12 mois, prix promo Hostinger)

| | KVM 1 | **KVM 2 (retenu)** |
|---|---|---|
| Prix promo / mois | 5,99 € | 8,49 € |
| Prix pack 12 mois | 71,88 € | 101,88 € |
| ≈ FCFA (~656 F/€) | ~47 150 F | **~66 830 F** |
| vCPU | 1 | 2 |
| RAM | 4 Go | 8 Go |
| NVMe | 50 Go | 100 Go |
| Bande passante | 4 To | 8 To |
| Renouvellement (an 2) | 12,99 €/mois → ~102 300 F/an | 16,99 €/mois → ~133 750 F/an |

Pour ~19 700 F CFA de plus sur la première année, le KVM 2 double le CPU et
la RAM — nécessaire pour PrestaShop + MySQL + un reverse proxy tournant en
containers sur la même machine. **KVM 2 retenu.**

⚠️ Les montants FCFA sont des estimations (taux ~656 F/€) ; le montant réel
débité dépend du taux du jour et d'éventuels frais/taxes de la carte utilisée.

### Nom de domaine

`taysirshop.shop` — 0,99 € (~650 F CFA) la 1ʳᵉ année chez Hostinger (prix
normal affiché 32,99 €/an). **Avant d'acheter**, vérifier la ligne
« Renouvellement » dans le panier Hostinger pour connaître le tarif réel de
l'année 2 (le 32,99 € affiché à côté du prix promo n'est pas forcément ce
tarif de renouvellement).

### Budget infrastructure (année 1)

| Poste | Coût |
|---|---|
| VPS KVM 2 — 12 mois | ~66 830 F CFA |
| Domaine `taysirshop.shop` — 1ʳᵉ année | ~650 F CFA |
| SSL Let's Encrypt (via certbot, voir [PRODUCTION_STACK.md](PRODUCTION_STACK.md)) | 0 F |
| **Total infrastructure** | **~67 480 F CFA** |

### Repère de facturation client

Si le forfait facturé au client pour la mise en production est de
**200 000 F CFA** (incluant 1 an de VPS + 1 an de domaine) :

```
200 000 F − 67 480 F (infra) = ~132 520 F CFA de marge / rémunération
```

À ajuster selon ce qui est réellement convenu avec le client (ce chiffre
n'est qu'un repère de calcul, pas une recommandation tarifaire figée).

---

## 4. Déploiement pas à pas (VPS Docker)

Contrairement à un hébergement mutualisé classique, il n'y a pas de FTP ni
de `parameters.php` à éditer à la main : on reproduit l'environnement Docker
local sur le VPS, avec un reverse proxy devant pour le HTTPS.

### 4.1 Préparer le VPS

1. Commander le VPS KVM 2 (image de base : Ubuntu 22.04/24.04 recommandé).
2. Se connecter en SSH (`ssh root@IP_DU_VPS`).
3. Installer Docker + Docker Compose :
   ```bash
   curl -fsSL https://get.docker.com | sh
   apt-get install -y docker-compose-plugin
   ```
4. Pointer le domaine vers l'IP du VPS (chez Hostinger → **Domaines** →
   DNS → enregistrement `A` vers l'IP du VPS ; ajouter aussi `www`).

### 4.2 Ajouter le reverse proxy + HTTPS (certbot)

Le détail (Traefik ou Nginx + certbot, config exacte) est dans
**[PRODUCTION_STACK.md](PRODUCTION_STACK.md)** — c'est ce qui remplace le
`ports: 8080:80` local par du HTTPS propre sur le domaine réel.

### 4.3 Transférer le projet

```bash
# Sur le VPS
git clone <votre-repo> /opt/taysirshop   # ou scp/rsync depuis le PC local
cd /opt/taysirshop
```

C'est `docker-compose.prod.yml` (déjà prêt, pas `docker-compose.yml` qui
reste le fichier de dev local) qui est utilisé en prod — il lit ses valeurs
depuis un fichier `.env` à créer sur le VPS :
```bash
cp .env.example .env
nano .env   # PS_DOMAIN=taysirshop.shop, mots de passe forts (jamais ceux du local), etc.
```
`PS_DEV_MODE` y est déjà à `0` et le port 8080 n'est pas exposé (nginx
écoute sur 80/443) — rien d'autre à adapter. Détail pas à pas de la
génération du certificat HTTPS : [PRODUCTION_STACK.md](PRODUCTION_STACK.md).

### 4.4 Migrer les données locales (catalogue, thème, images)

```bash
# Depuis le PC local : export de la base
docker exec prestashop-mysql mysqldump -u root -pprestashop prestashop > taysirshop_export.sql

# Copier vers le VPS
scp taysirshop_export.sql root@IP_DU_VPS:/opt/taysirshop/
```

Sur le VPS, après le premier démarrage de `mysql` (qui crée une base
neuve — voir §1 étape 2 de PRODUCTION_STACK.md) :
```bash
docker exec -i taysirshop-mysql mysql -u root -pVOTRE_NOUVEAU_MDP prestashop < taysirshop_export.sql
```

Mettre à jour l'URL de la boutique dans la base importée :
```sql
UPDATE ps_shop_url SET domain = 'taysirshop.shop', domain_ssl = 'taysirshop.shop' WHERE id_shop = 1;
UPDATE ps_configuration SET value = '0' WHERE name IN ('PS_DEV_MODE', 'PS_DISPLAY_ERRORS');
```

Les dossiers `theme-local/` (thème AngarTheme personnalisé) et `images/`
(logos, bannières, visuels produits) sont versionnés avec le projet —
rien de spécial à migrer séparément s'ils partent avec le `git clone`/`scp`
de l'étape 4.3 : les deux sont montés en volume dans `docker-compose.prod.yml`
exactement comme en local.

### 4.5 Démarrer et vérifier

Suivre la marche à suivre complète (ordre des services, certificat HTTPS)
dans [PRODUCTION_STACK.md §1](PRODUCTION_STACK.md#1-reverse-proxy--https-nginx--certbot).
Une fois tout démarré :
```bash
docker exec taysirshop-app sh -c "rm -rf /var/www/html/var/cache/*"
```

- `https://taysirshop.shop/` charge sans erreur, cadenas SSL présent
- Back-office accessible (`https://taysirshop.shop/adminXXXXXXXXXX/`)
- Images produits et thème s'affichent correctement
- Commande test avant d'activer le paiement réel

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

## 8. Comment le vendeur sait qu'il a une commande

PrestaShop notifie **par email**, pas par SMS/notification push nativement :

- **Email automatique à chaque commande** : envoyé à l'adresse configurée
  dans Préférences → Boutique (`PS_SHOP_EMAIL`) — c'est le même paramètre
  que "Email admin" plus haut. Prévoir une vraie adresse email pro plutôt
  que `admin@example.com` avant le lancement.
- **Back-office** : la page d'accueil de l'admin (tableau de bord) affiche
  les commandes récentes et un badge avec le nombre de commandes non
  traitées. La page **Commandes** liste tout, avec un filtre par statut
  ("En attente de paiement", "Paiement accepté", etc.).
- **Le serveur doit pouvoir envoyer des emails** : par défaut PrestaShop
  utilise la fonction mail() du serveur PHP, souvent peu fiable (fort
  risque de finir en spam ou de ne jamais partir). Sur le VPS, configurer
  un envoi SMTP réel dans Préférences → Boutique → Emails (ex. compte SMTP
  fourni par Hostinger, ou un service comme Brevo/Mailjet qui a un plan
  gratuit) — sinon les notifications de commande risquent de ne jamais
  arriver.
- **Notifications mobiles/WhatsApp** : PrestaShop ne le fait pas nativement.
  Si le vendeur veut être alerté sur WhatsApp/téléphone, il faudrait un
  module tiers (ou un petit webhook personnalisé) qui appelle l'API
  WhatsApp Business à chaque nouvelle commande — pas fait pour l'instant,
  à évaluer plus tard si le besoin se confirme.

---

## Contact technique

Ce projet a été construit avec Claude Code. Pour reprendre le travail, se
référer à ce README et à l'historique du dépôt.
