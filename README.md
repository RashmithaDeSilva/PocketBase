# PocketBase Docker Setup

This repository provides a ready-to-use setup for running PocketBase in Docker, with optional Docker Compose and Nginx reverse proxy configuration.

It includes:

* Dockerfile — custom PocketBase image
* docker-compose.yml — container + volume setup
* nginx.conf — optional reverse proxy for production
* Any other configs needed to run PocketBase smoothly

---
### 📦 1. PocketBase Dockerfile

The `Dockerfile` builds a lightweight PocketBase image using Alpine Linux.

<b>What it does</b>

* Downloads the PocketBase binary based on the version you set
* Installs required dependencies
* Extracts the binary
* Exposes port 8090
* Runs PocketBase with a data folder /pb_data

<b>Build manually</b>
```sh
docker build -t pocketbase .
```

<b>Run manually</b>
```sh
docker run -p 8090:8090 pocketbase
```

---
### 🐳 2. Docker Compose Setup

The `docker-compose.yml` file makes running PocketBase easier and persistent.

<b>Features</b>

* Uses the custom PocketBase image
* Automatically mounts a volume for persistent data
* Exposes port 8090
* Runs PocketBase in detached mode

<b>Start with Compose:</b>
```sh
docker compose up -d
```

<b>Stop:</b>
```sh
docker compose down
```

<b>Persistent data location:</b>
```sh
./pb_data → stored on your host machine
```

---
### 🌐 3. Nginx Reverse Proxy (Optional)
For production, you can run PocketBase behind Nginx to add:

* SSL / HTTPS
* Better performance
* Clean domain routing

Your `nginx.conf` maps a domain to the PocketBase container.

<b>Example setup</b>

Requests to your domain → Nginx → PocketBase (port 8910)

* Install nginx with certbot
    ```sh
    sudo apt update
    sudo apt install nginx certbot python3-certbot-nginx -y
    sudo apt autoremove
    ```

* Alow firewall
    ```sh
    sudo apt install firewalld -y
    ```
    ```sh
    sudo systemctl start firewalld
    sudo systemctl enable firewalld
    sudo firewall-cmd --state
    sudo firewall-cmd --permanent --add-port=80/tcp
    sudo firewall-cmd --permanent --add-port=443/tcp
    sudo firewall-cmd --reload
    sudo firewall-cmd --list-all
    ```

* Activate SSL
    * with nginx
        ```sh
        sudo certbot --nginx -d <your.domain.com>
        ```
        Certbot will:
        - Automatically configure SSL for your domain.
        - Create a config file at `/etc/nginx/sites-available/your.domain.com` (or edit the default one).
        - Install a certificate and enable HTTPS.

    * with certbot
        ```sh
        sudo apt-get remove certbot
        sudo snap install --classic certbot
        sudo ln -s /snap/bin/certbot /usr/bin/certbot
        sudo certbot certonly --standalone
        ```

* Nginx server setup
    * Delete default nginx config
        ```sh
        sudo rm -rf /etc/nginx/sites-available/default
        sudo rm -rf /etc/nginx/sites-enabled/default
        ```

    * Create new config for pocketBase
        ```sh
        sudo nano /etc/nginx/sites-available/<your.domain.com>.conf
        ```

    * Add symlink
        ```sh
        sudo ln -s /etc/nginx/sites-available/<your.domain.com>.conf /etc/nginx/sites-enabled/
        ```

    * Set configarations
        ```sh
        sudo nginx -t
        sudo systemctl reload nginx
        ```

Make sure to update:
* Your domain
* SSL certificates (e.g., via Let’s Encrypt)

---
### 🛠 Folder Structure

```sh
.
├── Dockerfile
├── docker-compose.yml
├── nginx.conf
└── pb_data/     # auto created for PocketBase database files
```

---
### 🚀 How to Use

1. Clone this repository
2. Edit environment variables if needed
3. Start using Docker Compose:
    ```sh
    docker compose up -d
    ```
4. (Optional) Set up Nginx for production

---
### ✔️ Ready to Deploy

This setup gives you a clean, production-ready PocketBase environment using:

* Docker
* Docker Compose
* Nginx (optional)

You can now use PocketBase as your backend with persistent storage, easy scaling, and secure HTTPS support.
