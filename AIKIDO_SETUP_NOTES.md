# Aikido Zen Firewall - Manual Setup Step Required

## ⚠️ Important: Middleware File Location

The Aikido middleware file has been created at:
```
app/AikidoMiddleware_temp.php
```

**Action Required:** Please move this file to the correct location:
```bash
mkdir -p app/Http/Middleware
mv app/AikidoMiddleware_temp.php app/Http/Middleware/AikidoMiddleware.php
```

This manual step is needed because Laravel 11+ does not create the `app/Http/Middleware` directory by default, and the automated tooling cannot create new directories.

## ✅ Completed Changes

All other Aikido Zen firewall changes have been applied automatically:

### 1. Middleware Registration
- ✅ `bootstrap/app.php` - Added AikidoMiddleware import and registered it in the web middleware group

### 2. Environment Configuration
- ✅ `.env.example` - Added AIKIDO_TOKEN and AIKIDO_BLOCK configuration variables

### 3. Docker Setup
- ✅ `Dockerfile` - Added Aikido PHP extension installation (version 1.5.4)
- ✅ `docker-compose.yml` - Added environment variable configuration for the app service

## 🚀 Next Steps

1. **Move the middleware file** (see command above)

2. **Set your Aikido token:**
   - Create a `.env` file from `.env.example` if you haven't already
   - Get your token from: https://help.aikido.dev/doc/creating-an-aikido-zen-firewall-token/doc6vRJNzC4u
   - Add it to your `.env` file:
     ```
     AIKIDO_TOKEN=your-actual-token-here
     AIKIDO_BLOCK=false
     ```

3. **Rebuild and restart Docker containers:**
   ```bash
   docker compose down
   docker compose up -d --build
   ```

4. **Verify the installation:**
   ```bash
   # Check if the Aikido extension is loaded
   docker compose exec app php -m | grep aikido
   
   # Check the logs
   docker compose logs -f app
   ```

## 🛡️ What's Protected

Once installed, Aikido Zen automatically protects against:
- SQL injection
- Command injection
- Path traversal
- SSRF (Server-Side Request Forgery)

The middleware enables additional features:
- User blocking
- Rate limiting (per user and per IP)

## 📝 Notes

- The Aikido extension is installed as a native PHP extension, not a Composer package
- Environment variables are passed from docker-compose.yml to the PHP-FPM container
- Zen logs are written to `/var/log/aikido-*/` inside the container for troubleshooting
- If you change the PHP version in the Dockerfile, you'll need to reinstall the Aikido package

