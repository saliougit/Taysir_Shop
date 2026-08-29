# Stack de production — conteneurs à ajouter

Ce document liste les services Docker **à ajouter au `docker-compose.yml`
actuel** pour passer de l'environnement de développement local (juste
`prestashop` + `mysql`, exposé sur `localhost:8080`) à une mise en
production propre sur le VPS (HTTPS réel, nom de domaine, meilleures
performances). Voir [README.md](README.md) pour le contexte général de
déploiement (VPS Hostinger KVM 2).

En local, **rien de tout ceci n'est nécessaire** — ce doc ne sert qu'au
moment du déploiement sur le VPS.

---

## 1. Reverse proxy + HTTPS (nginx + certbot)

En local, PrestaShop est exposé directement sur le port 8080 sans HTTPS. En
production il faut :
- Un nom de domaine qui pointe vers le port 80/443 (pas 8080)
- Un certificat SSL valide (Let's Encrypt, gratuit, renouvelé automatiquement)
- Le renouvellement automatique du certificat tous les ~90 jours

**Deux façons de faire, une seule à choisir :**

### Option A — nginx + certbot (classique, contrôle total)

Ajouter au `docker-compose.yml` :

```yaml
  nginx:
    image: nginx:stable
    container_name: taysirshop-nginx
    restart: unless-stopped
    depends_on:
      - prestashop
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx/conf.d:/etc/nginx/conf.d:ro
      - ./certbot/www:/var/www/certbot:ro
      - ./certbot/conf:/etc/letsencrypt:ro
    networks:
      - prestashop_network

  certbot:
    image: certbot/certbot
    container_name: taysirshop-certbot
    volumes:
      - ./certbot/www:/var/www/certbot
      - ./certbot/conf:/etc/letsencrypt
    # Genere le certificat la 1ere fois (voir commande plus bas), puis
    # renouvelle automatiquement tous les 12h (no-op si pas encore l'heure)
    entrypoint: "/bin/sh -c 'trap exit TERM; while :; do certbot renew; sleep 12h & wait $${!}; done;'"
```

Fichier `nginx/conf.d/taysirshop.conf` (à créer) — redirige le HTTP vers le
HTTPS et fait le proxy vers le conteneur `prestashop` (port 80 interne, pas
8080 — retirer/adapter le mapping `ports: 8080:80` du service `prestashop`
en production puisque c'est nginx qui écoute désormais sur 80/443) :

```nginx
server {
    listen 80;
    server_name taysirshop.shop www.taysirshop.shop;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }
    location / {
        return 301 https://$host$request_uri;
    }
}

server {
    listen 443 ssl;
    server_name taysirshop.shop www.taysirshop.shop;

    ssl_certificate     /etc/letsencrypt/live/taysirshop.shop/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/taysirshop.shop/privkey.pem;

    client_max_body_size 64M;

    location / {
        proxy_pass http://prestashop:80;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Génération du tout premier certificat (une fois le DNS du domaine pointé
vers le VPS, et nginx démarré en HTTP simple pour valider le challenge) :

```bash
docker compose run --rm certbot certonly --webroot -w /var/www/certbot \
  -d taysirshop.shop -d www.taysirshop.shop \
  --email VOTRE_EMAIL --agree-tos --no-eff-email
```

Puis redémarrer nginx pour qu'il prenne le certificat en compte :
```bash
docker compose restart nginx
```

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

```yaml
  redis:
    image: redis:7-alpine
    container_name: taysirshop-redis
    restart: unless-stopped
    volumes:
      - redis_data:/data
    networks:
      - prestashop_network
```

Puis activer le cache Redis côté PrestaShop : back-office → Paramètres
avancés → Performance → Cache → choisir "Redis", hôte `redis`, port `6379`.

**Ne pas ajouter maintenant** — à faire seulement si un ralentissement
réel est constaté après le lancement.

---

## 3. Sauvegardes automatiques — recommandé dès le lancement

Un petit service qui exporte la base régulièrement, en plus des
sauvegardes Hostinger (défense en profondeur) :

```yaml
  backup:
    image: mysql:8.0
    container_name: taysirshop-backup
    restart: unless-stopped
    depends_on:
      - mysql
    volumes:
      - ./backups:/backups
    entrypoint: >
      /bin/sh -c '
      while true; do
        mysqldump -h mysql -u root -p"$$MYSQL_ROOT_PASSWORD" prestashop | gzip > /backups/prestashop_$$(date +%Y%m%d_%H%M%S).sql.gz;
        find /backups -name "*.sql.gz" -mtime +14 -delete;
        sleep 86400;
      done'
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
    networks:
      - prestashop_network
```

Sauvegarde quotidienne, conservée 14 jours glissants. Adapter le mot de
passe (idéalement via un fichier `.env` plutôt qu'en clair dans
`docker-compose.yml`).

---

## Résumé — quoi ajouter, quand

| Service | Quand |
|---|---|
| nginx + certbot (ou Traefik) | **Au déploiement**, indispensable pour le HTTPS |
| backup | **Au déploiement**, recommandé dès le premier jour |
| redis | **Plus tard**, seulement si ralentissement constaté |
