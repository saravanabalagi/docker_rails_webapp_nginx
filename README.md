# Docker Rails Webapp Nginx

Ready-to-use Docker boilerplate for a Ruby on Rails API server and a static web frontend served by NGINX. The Rails API server is configured to use PostgreSQL database. The web frontend can built using modern JS frameworks like Svelte, React or Vue.

## Quick Start

Update `APP_NAME` and other variables as required in `.env.example` file and then run:

```bash
sh ./bootstrap.sh
```

The script will do the following:
- create a `.env` file from `.env.example`
- create new rails api app
- move the `master.key` to `.env`
- start rails server at `http://localhost:3000`
- start web server at `http://localhost:80`

You can later start the servers simply using:

```bash
docker-compose up
```

## Folder Structure

```
.
├── client_web     # web frontend src code
│   └── build      # static build output to be served by nginx
├── nginx          # nginx config files
└── server         # rails api server
```

## Note

Tested on macOS. In linux, docker creates files with root user. So, you may need to change the ownership of the files created by docker. If not, this can cause an error when the `bootstrap.sh` tries to shred the `master.key` file.
