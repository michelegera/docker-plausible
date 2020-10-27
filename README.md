# Plausible.io on HTTPS

The [Plausible.io][plausible] [documentation on self-hosting][self-hosting]
states that…

> The Plausible server itself does not perform SSL termination (yet, feel free
> to contribute). It only runs on unencrypted HTTP. If you want to run on HTTPS
> you also need to set up a reverse proxy in front of the server. We have
> instructions and examples of how to do that below.

…but the instructions and examples are nowhere to be found. 😕

This [Docker Compose][docker-compose] configuration will run a self-hosted
instance of Plausible.io with geolocation enabled and [Traefik][traefik] as a
reverse-proxy, allowing you to serve the app on HTTPS.

## Pre-requisites

You will need is a server with [Docker][docker] and Docker Compose
installed.

I recommend a cheap [Digital Ocean][digital-ocean] (referral code) instance,
they have great step-by-step documentation on how to
[set up your server][do-server], [install Docker][do-docker] and
[Docker Compose][do-compose].

To enable geolocation, you will need a [MaxMind][maxmind] **free** account. Sign
up and log in, then go to `Services ▸ My License Key` and generate a new license
key. You will need the Account/User ID and key later.

## Configuration

- Set up your server as described above and SSH into it
- Clone this repository
  ```shell
  git clone https://github.com/michelegera/docker-plausible.git
  ```
- Edit the `geoip/geoip.conf` file and replace placeholders with the
  credentials from MaxMind
- Change the `traefik/acme.json` file permissions
  ```shell
  chmod 600 traefik/acme.json
  ```
- Edit the `traefik/traefik.toml` file and change the placeholder email address
  with your own
- Edit the `docker-compose.yml` file and change the placeholder domain name with
  your own
- Edit the `plausible-conf.env` file and replace placeholders with your desired
  values
  - Remember to set the `https` protocol for your `BASE_URL`
  - To generate a good `SECRET_KEY_BASE` use this command
    ```
    openssl rand -base64 64
    ```

## Run

To start all services, just run the startup script: `./start.sh`.

You can verify that the the reverse-proxy is up and running by visiting
`<http://your.domain.com:8080>`.

## After the first successful run

Disable Traefik dashboard, or it will be publicly availabe in production.

To do that:

- Edit `traefik/traefik.toml` and remove the `[api]` section
- Edit `traefik/docker-compose.traefik.yml` and remove the line `"8080:8080"`

## Credits

This configuration is based on the [awesome][morycorp-repo-01]
[work][morycorp-repo-02] by [MoryCorp][morycorp].

[plausible]: https://plausible.io
[self-hosting]: https://docs.plausible.io/self-hosting/
[docker-compose]: https://docs.docker.com/compose/
[traefik]: https://traefik.io
[docker]: https://docker.com
[digital-ocean]: https://m.do.co/c/2f19c210b485
[do-server]: https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-20-04
[do-docker]: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04
[do-compose]: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04
[maxmind]: https://www.maxmind.com
[morycorp-repo-01]: https://github.com/MoryCorp/plausible.io-behind-Traefik2
[morycorp-repo-02]: https://github.com/MoryCorp/traefik2-minimalist-configuration
[morycorp]: https://github.com/MoryCorp
