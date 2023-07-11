# Docker Rails Webapp Nginx

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

## Note

In linux, docker creates files with root user. So, you may need to change the ownership of the files created by docker. If not, this can cause an error when the `bootstrap.sh` tries to shred the `master.key` file.
