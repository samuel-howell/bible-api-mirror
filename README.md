# Bible API Mirror

This is a local mirror of the [HelloAOLab Bible API](https://github.com/HelloAOLab/bible-api) hosted on Coolify.

## Overview

This repository provides a simple nginx-based Docker container that:
- Downloads pre-generated Bible API data from HelloAOLab's public endpoint
- Serves the data as a static JSON API
- Provides CORS support for browser access
- Includes compression and caching headers

## Architecture

- **Base**: nginx:alpine (~5MB)
- **API Data**: Downloaded from https://bible.helloao.org/api.zip (~1.5GB)
- **Runtime Resources**: ~10-50MB RAM
- **Build Time**: ~2-3 minutes

## Deployment

This is designed to be deployed via Coolify:

1. Add this repository as a new application in Coolify
2. Configure domain: `bibleapiv2.samuelhowell.com`
3. Port: 80
4. Health check: `/health`
5. Deploy!

## Updating API Data

To get the latest Bible translations:
1. Click "Rebuild" in Coolify UI
2. Fresh API data is downloaded during build
3. Container is redeployed with latest data

## API Endpoints

- `/health` - Health check endpoint
- `/api/translations.json` - List of all translations
- `/api/{TRANSLATION_ID}/books.json` - Books in translation
- `/api/{TRANSLATION_ID}/{BOOK_ID}/{CHAPTER}.json` - Specific chapter

## Local Testing

```bash
docker build -t bible-api-mirror .
docker run -p 8080:80 bible-api-mirror
curl http://localhost:8080/health
curl http://localhost:8080/api/translations.json
```

## Credits

- API Data: [HelloAOLab Bible API](https://bible.helloao.org)
- Source Repository: https://github.com/HelloAOLab/bible-api
- License: MIT
