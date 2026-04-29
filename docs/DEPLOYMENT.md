# 🚀 Deployment & Operations Guide

<div align="center">

![Deployment](https://img.shields.io/badge/Deployment-Production%20Ready-success)
![DevOps](https://img.shields.io/badge/DevOps-CI%2FCD-blue)
![Monitoring](https://img.shields.io/badge/Monitoring-Active-green)

**NutriNuts E-Commerce Platform - Production Deployment Guide**

</div>

---

## 📋 Table of Contents

- [Pre-Deployment Checklist](#-pre-deployment-checklist)
- [Environment Configuration](#-environment-configuration)
- [Deployment Options](#-deployment-options)
- [Database Setup](#-database-setup)
- [SSL/TLS Configuration](#-ssltls-configuration)
- [Monitoring & Logging](#-monitoring--logging)
- [Backup & Recovery](#-backup--recovery)
- [Performance Optimization](#-performance-optimization)
- [Troubleshooting](#-troubleshooting)

---

## ✅ Pre-Deployment Checklist

### Security Checklist

<table>
<tr>
<th width="50%">Security Item</th>
<th width="20%">Priority</th>
<th width="30%">Status</th>
</tr>

<tr>
<td>✓ Change default admin password</td>
<td><span style="background:#ef4444;color:#fff;padding:2px 8px;border-radius:4px">CRITICAL</span></td>
<td>⬜ TODO</td>
</tr>

<tr>
<td>✓ Generate strong JWT_SECRET</td>
<td><span style="background:#ef4444;color:#fff;padding:2px 8px;border-radius:4px">CRITICAL</span></td>
<td>⬜ TODO</td>
</tr>

<tr>
<td>✓ Configure CORS origins</td>
<td><span style="background:#f59e0b;color:#000;padding:2px 8px;border-radius:4px">HIGH</span></td>
<td>⬜ TODO</td>
</tr>

<tr>
<td>✓ Set up HTTPS/SSL certificates</td>
<td><span style="background:#ef4444;color:#fff;padding:2px 8px;border-radius:4px">CRITICAL</span></td>
<td>⬜ TODO</td>
</tr>

<tr>
<td>✓ Configure rate limiting</td>
<td><span style="background:#f59e0b;color:#000;padding:2px 8px;border-radius:4px">HIGH</span></td>
<td>⬜ TODO</td>
</tr>

<tr>
<td>✓ Enable MongoDB authentication</td>
<td><span style="background:#ef4444;color:#fff;padding:2px 8px;border-radius:4px">CRITICAL</span></td>
<td>⬜ TODO</td>
</tr>

<tr>
<td>✓ Set secure cookie flags</td>
<td><span style="background:#f59e0b;color:#000;padding:2px 8px;border-radius:4px">HIGH</span></td>
<td>⬜ TODO</td>
</tr>

<tr>
<td>✓ Configure firewall rules</td>
<td><span style="background:#f59e0b;color:#000;padding:2px 8px;border-radius:4px">HIGH</span></td>
<td>⬜ TODO</td>
</tr>

<tr>
<td>✓ Set up automated backups</td>
<td><span style="background:#3b82f6;color:#fff;padding:2px 8px;border-radius:4px">MEDIUM</span></td>
<td>⬜ TODO</td>
</tr>

<tr>
<td>✓ Configure logging</td>
<td><span style="background:#3b82f6;color:#fff;padding:2px 8px;border-radius:4px">MEDIUM</span></td>
<td>⬜ TODO</td>
</tr>
</table>

### Performance Checklist

- [ ] Minify frontend assets
- [ ] Enable Gzip compression
- [ ] Configure CDN for static assets
- [ ] Set up database indexes
- [ ] Implement caching strategy
- [ ] Configure image optimization
- [ ] Enable lazy loading for images
- [ ] Set up load balancer (if multi-server)

### Operational Checklist

- [ ] Configure email service (SendGrid)
- [ ] Set up error tracking (Sentry)
- [ ] Configure monitoring (PM2, New Relic)
- [ ] Set up CI/CD pipeline
- [ ] Prepare rollback strategy
- [ ] Document deployment process
- [ ] Create maintenance page
- [ ] Set up health check endpoints

---

## ⚙️ Environment Configuration

### Production Environment Variables

#### Backend (.env)

```bash
# ===== SERVER CONFIGURATION =====
NODE_ENV=production
PORT=5001
API_URL=https://api.nutrinuts.com

# ===== DATABASE =====
DATABASE=mongodb://username:password@cluster.mongodb.net/ecommerce?retryWrites=true&w=majority
DB_LOCAL_URI=mongodb://localhost:27017/ecommerce

# ===== JWT CONFIGURATION =====
JWT_SECRET=GENERATE_STRONG_SECRET_HERE_32_CHARS_MIN
JWT_EXPIRE=7d
JWT_COOKIE_EXPIRE=7

# ===== EMAIL SERVICE (SendGrid) =====
SENDGRID_API_KEY=SG.your-api-key-here
SENDGRID_FROM_EMAIL=noreply@nutrinuts.com
SENDGRID_FROM_NAME=NutriNuts

# ===== CORS CONFIGURATION =====
FRONTEND_URL=https://nutrinuts.com
ADMIN_URL=https://admin.nutrinuts.com

# ===== FILE UPLOAD =====
MAX_FILE_SIZE=5242880
ALLOWED_FILE_TYPES=image/jpeg,image/png,image/webp

# ===== PAYMENT GATEWAY (Future) =====
RAZORPAY_KEY_ID=your_key_id
RAZORPAY_KEY_SECRET=your_key_secret

# ===== RATE LIMITING =====
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100

# ===== LOGGING =====
LOG_LEVEL=info
LOG_FILE_PATH=./logs/app.log

# ===== MONITORING =====
SENTRY_DSN=https://your-sentry-dsn
NEW_RELIC_LICENSE_KEY=your_license_key
```

#### Frontend (.env.production)

```bash
VITE_API_URL=https://api.nutrinuts.com
VITE_SITE_NAME=NutriNuts
VITE_GOOGLE_ANALYTICS_ID=G-XXXXXXXXXX
```

#### Admin Frontend (.env.production)

```bash
VITE_API_URL=https://api.nutrinuts.com
VITE_ADMIN_PANEL_NAME=NutriNuts Admin
```

### Generating Secure Secrets

```bash
# Generate JWT Secret (Node.js)
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"

# Generate JWT Secret (OpenSSL)
openssl rand -base64 32

# Generate JWT Secret (Linux)
head -c 32 /dev/urandom | base64
```

---

## 🌐 Deployment Options

### Option 1: Traditional VPS Deployment (DigitalOcean, AWS EC2)

#### Step 1: Server Setup

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Node.js 18.x
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install MongoDB
wget -qO - https://www.mongodb.org/static/pgp/server-7.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt update
sudo apt install -y mongodb-org

# Start MongoDB
sudo systemctl start mongod
sudo systemctl enable mongod

# Install Nginx
sudo apt install -y nginx

# Install PM2 globally
sudo npm install -g pm2
```

#### Step 2: Application Deployment

```bash
# Clone repository
git clone https://github.com/your-username/nutrinuts-ecommerce.git
cd nutrinuts-ecommerce

# Backend setup
cd backend
npm install --production
cp config.env.example config.env
# Edit config.env with production values

# Seed database
npm run seed
npm run seed:config
node scripts/createSuperAdmin.js

# Start with PM2
pm2 start server.js --name nutrinuts-api
pm2 save
pm2 startup

# Frontend build
cd ../frontend
npm install
npm run build

# Admin build
cd ../adminfrontend
npm install
npm run build
```

#### Step 3: Nginx Configuration

```nginx
# /etc/nginx/sites-available/nutrinuts

# Backend API
server {
    listen 80;
    server_name api.nutrinuts.com;

    location / {
        proxy_pass http://localhost:5001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

# Frontend Store
server {
    listen 80;
    server_name nutrinuts.com www.nutrinuts.com;
    root /var/www/nutrinuts/frontend/dist;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    # Cache static assets
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/plain text/css text/xml text/javascript application/x-javascript application/xml+rss application/json;
}

# Admin Dashboard
server {
    listen 80;
    server_name admin.nutrinuts.com;
    root /var/www/nutrinuts/adminfrontend/dist;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

```bash
# Enable site and restart Nginx
sudo ln -s /etc/nginx/sites-available/nutrinuts /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

### Option 2: Docker Deployment

#### docker-compose.yml

```yaml
version: '3.8'

services:
  # MongoDB Database
  mongodb:
    image: mongo:7.0
    container_name: nutrinuts-mongodb
    restart: always
    environment:
      MONGO_INITDB_ROOT_USERNAME: admin
      MONGO_INITDB_ROOT_PASSWORD: ${MONGO_PASSWORD}
      MONGO_INITDB_DATABASE: ecommerce
    ports:
      - "27017:27017"
    volumes:
      - mongodb-data:/data/db
      - ./mongo-init.js:/docker-entrypoint-initdb.d/mongo-init.js:ro
    networks:
      - nutrinuts-network

  # Backend API
  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile
    container_name: nutrinuts-backend
    restart: always
    environment:
      NODE_ENV: production
      DATABASE: mongodb://admin:${MONGO_PASSWORD}@mongodb:27017/ecommerce?authSource=admin
      JWT_SECRET: ${JWT_SECRET}
      SENDGRID_API_KEY: ${SENDGRID_API_KEY}
      SENDGRID_FROM_EMAIL: ${SENDGRID_FROM_EMAIL}
    ports:
      - "5001:5001"
    depends_on:
      - mongodb
    volumes:
      - uploads:/app/images
    networks:
      - nutrinuts-network

  # Frontend Store
  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile
      args:
        VITE_API_URL: https://api.nutrinuts.com
    container_name: nutrinuts-frontend
    restart: always
    ports:
      - "80:80"
    depends_on:
      - backend
    networks:
      - nutrinuts-network

  # Admin Dashboard
  admin:
    build:
      context: ./adminfrontend
      dockerfile: Dockerfile
      args:
        VITE_API_URL: https://api.nutrinuts.com
    container_name: nutrinuts-admin
    restart: always
    ports:
      - "8091:80"
    depends_on:
      - backend
    networks:
      - nutrinuts-network

  # Nginx Reverse Proxy
  nginx:
    image: nginx:alpine
    container_name: nutrinuts-nginx
    restart: always
    ports:
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./ssl:/etc/nginx/ssl:ro
    depends_on:
      - backend
      - frontend
      - admin
    networks:
      - nutrinuts-network

networks:
  nutrinuts-network:
    driver: bridge

volumes:
  mongodb-data:
  uploads:
```

#### Backend Dockerfile

```dockerfile
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy application code
COPY . .

# Expose port
EXPOSE 5001

# Start application
CMD ["node", "server.js"]
```

#### Frontend Dockerfile

```dockerfile
FROM node:18-alpine as build

WORKDIR /app

# Build arguments
ARG VITE_API_URL
ENV VITE_API_URL=$VITE_API_URL

# Copy package files
COPY package*.json ./
RUN npm ci

# Copy source code
COPY . .

# Build application
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

#### Deploy with Docker Compose

```bash
# Create .env file with secrets
cat > .env << EOF
MONGO_PASSWORD=your_strong_password
JWT_SECRET=your_jwt_secret
SENDGRID_API_KEY=your_sendgrid_key
SENDGRID_FROM_EMAIL=noreply@nutrinuts.com
EOF

# Build and start containers
docker-compose up -d

# View logs
docker-compose logs -f

# Stop containers
docker-compose down
```

### Option 3: Cloud Platform Deployment (Heroku)

```bash
# Install Heroku CLI
curl https://cli-assets.heroku.com/install.sh | sh

# Login
heroku login

# Create apps
heroku create nutrinuts-api
heroku create nutrinuts-frontend
heroku create nutrinuts-admin

# Add MongoDB
heroku addons:create mongolab:sandbox -a nutrinuts-api

# Set environment variables
heroku config:set JWT_SECRET=your_secret -a nutrinuts-api
heroku config:set SENDGRID_API_KEY=your_key -a nutrinuts-api

# Deploy backend
cd backend
git init
heroku git:remote -a nutrinuts-api
git add .
git commit -m "Initial deploy"
git push heroku master

# Deploy frontend
cd ../frontend
# Update package.json with build script
heroku git:remote -a nutrinuts-frontend
git push heroku master
```

---

## 🗄️ Database Setup

### MongoDB Atlas (Cloud)

1. **Create Cluster:**
   - Visit [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
   - Create free M0 cluster
   - Choose region closest to your users

2. **Configure Security:**
   ```bash
   # Network Access: Add IP addresses
   0.0.0.0/0  # Allow from anywhere (development)
   YOUR_SERVER_IP/32  # Production server only
   
   # Database Access: Create user
   Username: nutrinuts_user
   Password: Generate strong password
   Role: readWrite on ecommerce database
   ```

3. **Get Connection String:**
   ```
   mongodb+srv://nutrinuts_user:<password>@cluster0.xxxxx.mongodb.net/ecommerce?retryWrites=true&w=majority
   ```

4. **Seed Data:**
   ```bash
   # Update DATABASE in config.env
   DATABASE=mongodb+srv://...
   
   # Run seeds
   npm run seed
   npm run seed:config
   ```

### Local MongoDB Setup

```bash
# Install MongoDB
# Ubuntu/Debian
wget -qO - https://www.mongodb.org/static/pgp/server-7.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt update
sudo apt install -y mongodb-org

# Start MongoDB
sudo systemctl start mongod
sudo systemctl enable mongod

# Create database and user
mongosh
use ecommerce
db.createUser({
  user: "nutrinuts_user",
  pwd: "strong_password_here",
  roles: [{ role: "readWrite", db: "ecommerce" }]
})
```

### Database Indexes (Performance)

```javascript
// Run these in MongoDB shell or create migration script

// Users collection
db.users.createIndex({ email: 1 }, { unique: true })
db.users.createIndex({ phone: 1 })

// Products collection
db.products.createIndex({ title: "text", description: "text" })
db.products.createIndex({ category: 1 })
db.products.createIndex({ featured: 1, createdAt: -1 })
db.products.createIndex({ price: 1 })

// Orders collection
db.orders.createIndex({ orderNumber: 1 }, { unique: true })
db.orders.createIndex({ user: 1, createdAt: -1 })
db.orders.createIndex({ status: 1 })
db.orders.createIndex({ createdAt: -1 })

// Admin collection
db.admins.createIndex({ username: 1 }, { unique: true })
db.admins.createIndex({ email: 1 }, { unique: true })
```

---

## 🔒 SSL/TLS Configuration

### Let's Encrypt (Free SSL)

```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx

# Generate certificates
sudo certbot --nginx -d nutrinuts.com -d www.nutrinuts.com
sudo certbot --nginx -d api.nutrinuts.com
sudo certbot --nginx -d admin.nutrinuts.com

# Auto-renewal
sudo certbot renew --dry-run

# Add to crontab for auto-renewal
sudo crontab -e
# Add line:
0 12 * * * /usr/bin/certbot renew --quiet
```

### Updated Nginx Configuration (with SSL)

```nginx
# Redirect HTTP to HTTPS
server {
    listen 80;
    server_name nutrinuts.com www.nutrinuts.com;
    return 301 https://$server_name$request_uri;
}

# HTTPS Frontend
server {
    listen 443 ssl http2;
    server_name nutrinuts.com www.nutrinuts.com;
    
    ssl_certificate /etc/letsencrypt/live/nutrinuts.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/nutrinuts.com/privkey.pem;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    
    root /var/www/nutrinuts/frontend/dist;
    index index.html;
    
    location / {
        try_files $uri $uri/ /index.html;
    }
}

# HTTPS API
server {
    listen 443 ssl http2;
    server_name api.nutrinuts.com;
    
    ssl_certificate /etc/letsencrypt/live/api.nutrinuts.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/api.nutrinuts.com/privkey.pem;
    
    location / {
        proxy_pass http://localhost:5001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

---

## 📊 Monitoring & Logging

### PM2 Monitoring

```bash
# Start with PM2
pm2 start server.js --name nutrinuts-api

# Monitor in real-time
pm2 monit

# View logs
pm2 logs nutrinuts-api

# Advanced monitoring
pm2 install pm2-logrotate
pm2 set pm2-logrotate:max_size 10M
pm2 set pm2-logrotate:retain 7

# Web dashboard
pm2 web
```

### Winston Logging Setup

```javascript
// backend/src/config/logger.js
const winston = require('winston');

const logger = winston.createLogger({
  level: process.env.LOG_LEVEL || 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.errors({ stack: true }),
    winston.format.json()
  ),
  transports: [
    new winston.transports.File({ filename: 'logs/error.log', level: 'error' }),
    new winston.transports.File({ filename: 'logs/combined.log' }),
  ],
});

if (process.env.NODE_ENV !== 'production') {
  logger.add(new winston.transports.Console({
    format: winston.format.simple(),
  }));
}

module.exports = logger;
```

### Health Check Endpoint

```javascript
// backend/src/routes/healthRoutes.js
const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');

router.get('/health', async (req, res) => {
  const healthCheck = {
    uptime: process.uptime(),
    timestamp: Date.now(),
    status: 'OK',
    database: mongoose.connection.readyState === 1 ? 'Connected' : 'Disconnected'
  };
  
  try {
    res.status(200).json(healthCheck);
  } catch (error) {
    healthCheck.status = 'ERROR';
    res.status(503).json(healthCheck);
  }
});

module.exports = router;
```

---

## 💾 Backup & Recovery

### Automated MongoDB Backups

```bash
#!/bin/bash
# backup-mongodb.sh

BACKUP_DIR="/var/backups/mongodb"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="nutrinuts_backup_$DATE"

# Create backup
mongodump --uri="mongodb://localhost:27017/ecommerce" --out="$BACKUP_DIR/$BACKUP_NAME"

# Compress backup
tar -czf "$BACKUP_DIR/$BACKUP_NAME.tar.gz" "$BACKUP_DIR/$BACKUP_NAME"
rm -rf "$BACKUP_DIR/$BACKUP_NAME"

# Delete backups older than 7 days
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete

echo "Backup completed: $BACKUP_NAME.tar.gz"
```

```bash
# Add to crontab (daily at 2 AM)
0 2 * * * /path/to/backup-mongodb.sh
```

### Restore from Backup

```bash
# Extract backup
tar -xzf nutrinuts_backup_20260111.tar.gz

# Restore database
mongorestore --uri="mongodb://localhost:27017" nutrinuts_backup_20260111/
```

---

## ⚡ Performance Optimization

### Node.js Optimization

```javascript
// Use clustering for multi-core CPUs
const cluster = require('cluster');
const os = require('os');

if (cluster.isMaster) {
  const cpuCount = os.cpus().length;
  for (let i = 0; i < cpuCount; i++) {
    cluster.fork();
  }
} else {
  require('./server');
}
```

### Nginx Caching

```nginx
# Nginx cache configuration
proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=api_cache:10m max_size=1g inactive=60m;

server {
    location /api/products {
        proxy_cache api_cache;
        proxy_cache_valid 200 10m;
        proxy_cache_key "$request_uri";
        add_header X-Cache-Status $upstream_cache_status;
        
        proxy_pass http://localhost:5001;
    }
}
```

---

## 🔧 Troubleshooting

### Common Issues & Solutions

| Issue | Cause | Solution |
|-------|-------|----------|
| **Connection refused** | Backend not running | `pm2 restart nutrinuts-api` |
| **Database connection failed** | Wrong credentials | Check `DATABASE` in config.env |
| **502 Bad Gateway** | Nginx can't reach backend | Verify backend port and proxy_pass |
| **CORS errors** | Frontend URL not in whitelist | Add to CORS configuration |
| **JWT expired** | Token older than 7 days | Re-login to get new token |
| **Image upload fails** | File size/type restriction | Check `MAX_FILE_SIZE` setting |
| **Email not sending** | Invalid SendGrid API key | Verify `SENDGRID_API_KEY` |

---

<div align="center">

**Deployment Support**

[📧 DevOps Support](mailto:devops@nutrinuts.com) • [📖 Architecture Guide](ARCHITECTURE.md) • [🐛 Report Issue](issues)

---

*Last Updated: January 11, 2026*

</div>
