# Ecommerce Deployment Guide - Render (All-in-One)

This guide deploys **Backend + Frontend + Admin** all on Render with automatic deployment on every git push.

---

## Architecture

| Service | Type | URL Pattern | Description |
|---------|------|-------------|-------------|
| Backend | Web Service | `https://ecommerce-backend.onrender.com` | Node.js API + image serving |
| Frontend | Static Site | `https://ecommerce-frontend.onrender.com` | Customer store (Vite) |
| Admin | Static Site | `https://ecommerce-admin.onrender.com` | Admin dashboard (Vite) |
| MongoDB | Atlas | `mongodb+srv://...` | Database (external) |

---

## Prerequisites

1. **GitHub account** with this repo pushed
2. **Render account** (free tier works)
3. **MongoDB Atlas cluster** (free tier M0 works)

---

## Step 1: Prepare MongoDB Atlas

1. Go to [https://cloud.mongodb.com](https://cloud.mongodb.com)
2. Create a free M0 cluster (any region)
3. In **Database Access**: Create a user with `readWriteAnyDatabase` role
4. In **Network Access**: Add IP `0.0.0.0/0` (allows Render to connect)
5. In **Database**: Click "Connect" → Drivers → Node.js → Copy connection string

   ```
   mongodb+srv://username:password@cluster0.xxxxx.mongodb.net/ecommerce?retryWrites=true&w=majority
   ```

---

## Step 2: Push to GitHub

If not already on GitHub:

```bash
git init
git add .
git commit -m "Initial commit with Render deployment config"
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main
```

---

## Step 3: Deploy via Render Blueprint (One-Click Setup)

### 3.1 Connect Repository

1. Go to [https://dashboard.render.com/blueprints](https://dashboard.render.com/blueprints)
2. Click **"New Blueprint Instance"**
3. Connect your GitHub repo
4. Select the `main` branch

### 3.2 Configure Environment Variables

After the blueprint creates the services, you MUST fill in these env vars in the Render dashboard:

#### Backend (`ecommerce-backend`)

| Variable | Value | Source |
|----------|-------|--------|
| `DATABASE` | `mongodb+srv://...` | MongoDB Atlas connection string |
| `ALLOWED_ORIGINS` | `https://ecommerce-frontend.onrender.com,https://ecommerce-admin.onrender.com` | Your Render URLs |
| `FRONTEND_URL` | `https://ecommerce-frontend.onrender.com` | Frontend URL |
| `SENDGRID_API_KEY` | `SG.xxx...` | (Optional) Get from sendgrid.com |
| `EMAIL_FROM` | `noreply@yourdomain.com` | Verified sender in SendGrid |
| `EMAIL_FROM_NAME` | `Your Store Name` | Display name |
| `RAZORPAY_KEY_ID` | `rzp_test_...` | (Optional) Get from razorpay.com |
| `RAZORPAY_KEY_SECRET` | `secret_...` | (Optional) Razorpay secret |

> **Note**: `JWT_SECRET` auto-generates if empty. You can also set your own.

#### Frontend (`ecommerce-frontend`)

| Variable | Value |
|----------|-------|
| `VITE_API_BASE` | `https://ecommerce-backend.onrender.com/api` |

#### Admin (`ecommerce-admin`)

| Variable | Value |
|----------|-------|
| `VITE_API_BASE` | `https://ecommerce-backend.onrender.com/api` |

### 3.3 Update render.yaml Routes (IMPORTANT!)

After first deploy, get your actual Render URLs and edit `render.yaml`:

```yaml
# In frontend and admin routes, replace:
destination: https://ecommerce-backend.onrender.com/api/*
# With your actual backend URL, e.g.:
destination: https://your-backend-name.onrender.com/api/*
```

Then commit and push — this updates the proxy routes.

---

## Step 4: Verify Deployment

### 4.1 Check Health Endpoints

```bash
# Backend health
curl https://your-backend.onrender.com/api/health

# Should return: {"success":true,"message":"OK"}
```

### 4.2 Check Frontend

1. Open `https://your-frontend.onrender.com`
2. Verify products load from API
3. Check browser Network tab for `/api/*` calls

### 4.3 Check Admin

1. Open `https://your-admin.onrender.com`
2. Login with admin credentials
3. Verify dashboard loads data

---

## Step 5: Seed Database (Optional)

If you have existing data to import:

```bash
# Local script to seed
node backend/scripts/seedDatabase.js
# OR use MongoDB Compass to import JSON collections
```

---

## Automatic Deployment

**Enabled by default.** Every `git push` to `main`:

1. Triggers Render auto-deploy
2. Runs `npm ci && npm run build`
3. Deploys new version
4. Runs health checks

Monitor at: `https://dashboard.render.com`

---

## Manual Deploy (Script)

If you need to force a redeploy:

```powershell
# Set your Render API key
$env:RENDER_API_KEY = "rnd_xxxxxxxxxxxx"
$env:RENDER_BACKEND_SERVICE_ID = "srv-xxxxxxxx"
$env:RENDER_FRONTEND_SERVICE_ID = "srv-xxxxxxxx"
$env:RENDER_ADMIN_SERVICE_ID = "srv-xxxxxxxx"

# Run deploy script
.\deploy.ps1
```

Get Service IDs from your Render dashboard URLs or via API:
```bash
curl -s https://api.render.com/v1/services \
  -H "Authorization: Bearer $RENDER_API_KEY"
```

---

## Troubleshooting

### CORS Errors

Check `ALLOWED_ORIGINS` in backend env vars includes both frontend URLs exactly (including `https://`).

### Images Not Loading

The `render.yaml` routes proxy `/images/*` to the backend. Verify:
1. Backend has images in the `images/` folder
2. Routes in render.yaml are correct
3. `VITE_API_BASE` is set (for image URL construction)

### Backend Won't Start

Check Render logs:
- `DATABASE` env var set correctly
- MongoDB Atlas Network Access allows `0.0.0.0/0`
- Database user has correct password

### Frontend Build Fails

```bash
# Test locally
cd frontend
npm ci
npm run build
```

---

## Cost Overview

| Service | Render Plan | Monthly Cost |
|---------|-------------|--------------|
| Backend | Free | $0 (sleeps after 15min idle) |
| Frontend | Free | $0 |
| Admin | Free | $0 |
| MongoDB | M0 Free | $0 |
| **Total** | | **$0** |

To avoid cold starts on backend: Upgrade to "Starter" ($7/mo).

---

## Custom Domain (Optional)

1. In Render dashboard: Service → Settings → Custom Domain
2. Add your domain (e.g., `shop.yourdomain.com`)
3. Update `ALLOWED_ORIGINS` and `FRONTEND_URL` env vars
4. Update CORS settings

---

## Files Added for Deployment

```
├── render.yaml              # Blueprint (3 services)
├── .github/workflows/
│   └── deploy.yml           # GitHub Actions CI/CD
├── deploy.ps1               # Manual deploy script
├── DEPLOYMENT.md            # This guide
├── backend/
│   └── server.js            # Patched for production
└── frontend/adminfrontend/
    └── (uses VITE_API_BASE env var)
```

---

## Next Steps

1. ✅ Push to GitHub
2. ✅ Create MongoDB Atlas cluster + get connection string
3. ✅ Deploy via Render Blueprint
4. ✅ Fill in environment variables in Render dashboard
5. ✅ Verify all 3 services work
6. 🎉 Done! Future pushes auto-deploy.

Need help? Check Render logs or run health checks above.
