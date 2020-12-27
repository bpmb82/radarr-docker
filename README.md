# radarr-docker

Radarr image, updated weekly, running the latest stable version of Radarr. 

Automatically grabs the API key to do a healthcheck

## Environment

| Environment variable | Description |
| --- | --- |
| `ENABLE_BACKUP` | Set to `1` to enable daily backups of the database. Last 30 days are kept. |

## docker-compose

```
version: '3.3'

services:


  radarr:
    image: bpmbee/docker-radarr:latest
    container_name: radarr
    environment:
      - TZ=Europe/Amsterdam
      - ENABLE_BACKUP=1 # Optional
    volumes:
      - /local_path/config:/config/
      - /local_path/backups:/backups
      - /path_to_your_movies_dir:/movies
      - /path_to_your_completed_downloads_dir:/downloads
    ports:
      - 7878:7878
    restart: unless-stopped
```
