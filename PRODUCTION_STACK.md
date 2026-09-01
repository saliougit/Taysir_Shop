# Stack de production — conteneurs à ajouter

Les fichiers sont **déjà prêts** dans le projet, pas seulement documentés :

- [`docker-compose.prod.yml`](docker-compose.prod.yml) — stack complète VPS
  (mysql + prestashop + nginx + certbot + sauvegarde quotidienne)
- [`nginx/conf.d/taysirshop.conf`](nginx/conf.d/taysirshop.conf) — actif par
  défaut (HTTP simple, pour le tout premier lancement)
- [`nginx/conf.d/taysirshop.conf.full`](nginx/conf.d/taysirshop.conf.full) —
  la version HTTPS, à activer une fois le certificat obtenu (§1 ci-dessous)
- [`.env.example`](.env.example) — à copier en `.env` sur le VPS avec les
  vrais mots de passe/domaine (jamais commité tel quel)

Ce document explique **comment les utiliser**. Voir [README.md](README.md)
pour le contexte général de déploiement (VPS Hostinger KVM 2).

En local, **rien de tout ceci n'est nécessaire** — le `docker-compose.yml`
actuel (sans HTTPS, sur `localhost:8080`) suffit pour développer. Cette
stack "prod" ne sert qu'au moment du déploiement sur le VPS.

---

## 1. Reverse proxy + HTTPS (nginx + certbot)

En local, PrestaShop est exposé directement sur le port 8080 sans HTTPS. En
production il faut :
- Un nom de domaine qui pointe vers le port 80/443 (pas 8080)
- Un certificat SSL valide (Let's Encrypt, gratuit, renouvelé automatiquement)
- Le renouvellement automatique du certificat tous les ~90 jours

**Deux façons de faire, une seule à choisir :**

### Option A — nginx + certbot (classique, contrôle total)

Tous les fichiers existent déjà (`docker-compose.prod.yml`, `nginx/conf.d/`).
Marche à suivre complète, une seule fois, au tout premier déploiement :

**0. Préparer `.env`** (sur le VPS, à côté de `docker-compose.prod.yml`) :
```bash
cp .env.example .env
nano .env   # renseigner MYSQL_ROOT_PASSWORD, ADMIN_PASSWD, etc.
```

**1. Pointer le DNS** du domaine (`taysirshop.shop` et `www.taysirshop.shop`)
vers l'IP du VPS (chez le registrar du domaine, pas sur le VPS).

**2. Démarrer sans HTTPS d'abord** — `nginx/conf.d/taysirshop.conf` est déjà
la version HTTP simple par défaut, ça marche tel quel :
```bash
docker compose -f docker-compose.prod.yml --env-file .env up -d mysql prestashop nginx
```

**3. Générer le premier certificat** (le DNS doit déjà pointer vers le VPS) :
```bash
docker compose -f docker-compose.prod.yml --env-file .env run --rm certbot \
  certonly --webroot -w /var/www/certbot \
  -d taysirshop.shop -d www.taysirshop.shop \
  --email adamadiou05@gmail.com --agree-tos --no-eff-email
```

**4. Basculer vers la config HTTPS** et redémarrer nginx :
```bash
cp nginx/conf.d/taysirshop.conf.full nginx/conf.d/taysirshop.conf
docker compose -f docker-compose.prod.yml --env-file .env restart nginx
```

**5. Démarrer le reste de la stack** (certbot pour le renouvellement auto,
sauvegardes) :
```bash
docker compose -f docker-compose.prod.yml --env-file .env up -d
```

Le site est alors accessible en `https://taysirshop.shop`. Le conteneur
`certbot` vérifie toutes les 12h si le certificat approche de l'expiration
(~90 jours) et le renouvelle tout seul — rien à refaire manuellement après
ce premier lancement.

### Option B — Traefik (plus simple à maintenir, HTTPS automatique)

Traefik gère lui-même la demande et le renouvellement des certificats
Let's Encrypt sans conteneur `certbot` séparé ni fichier de conf nginx à
écrire à la main — un seul service en plus, configuré par labels Docker.
Recommandé si vous ajoutez d'autres sites/sous-domaines plus tard sur le
même VPS. Plus abstrait à déboguer la première fois qu'on ne l'a jamais
utilisé — d'où le choix de documenter nginx+certbot en option A, plus
classique. À évaluer si le besoin de multi-sites se confirme.

---

## 2. Redis (cache PrestaShop) — optionnel, à activer si besoin

PrestaShop fonctionne très bien sans Redis pour un catalogue de cette
taille (quelques dizaines de produits). Utile plus tard si :
- Le trafic augmente sensiblement
- Le back-office ou le front deviennent lents (cache objet PHP par défaut
  = fichiers, plus lent que Redis en mémoire)

Déjà présent, **commenté**, dans `docker-compose.prod.yml` (service
`redis` + volume `redis_data`). Le jour où c'est nécessaire : décommenter
le service et le volume, `docker compose -f docker-compose.prod.yml
--env-file .env up -d redis`, puis activer côté PrestaShop : back-office →
Paramètres avancés → Performance → Cache → choisir "Redis", hôte `redis`,
port `6379`.

**Ne pas activer maintenant** — à faire seulement si un ralentissement
réel est constaté après le lancement.

---

## 3. Sauvegardes automatiques — recommandé dès le lancement

Déjà dans `docker-compose.prod.yml` (service `backup`) : exporte la base
dans `./backups/` toutes les 24h, conserve 14 jours glissants, supprime les
plus anciennes automatiquement. Se lance avec le reste de la stack (§1
étape 5), rien à configurer en plus que le `.env`.

Pour restaurer une sauvegarde en cas de besoin :
```bash
gunzip < backups/prestashop_AAAAMMJJ_HHMMSS.sql.gz | \
  docker compose -f docker-compose.prod.yml --env-file .env exec -T mysql \
  mysql -u root -p"$MYSQL_ROOT_PASSWORD" prestashop
```

Ceci s'ajoute aux sauvegardes automatiques Hostinger (défense en
profondeur) — voir README.md pour l'offre VPS retenue.

---

## Résumé — quoi ajouter, quand

| Service | Quand |
|---|---|
| nginx + certbot (ou Traefik) | **Au déploiement**, indispensable pour le HTTPS |
| backup | **Au déploiement**, recommandé dès le premier jour |
| redis | **Plus tard**, seulement si ralentissement constaté |
