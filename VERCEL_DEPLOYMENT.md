# Vercel Deployment Guide - Frontend & Admin Dashboard

Deploy **Frontend** and **Admin Dashboard** on Vercel with automatic deployments on every push.

---

## Architecture

| App | Repository | Vercel URL | Status |
|-----|-----------|-----------|--------|
| **Frontend** | `srikrishnadeveloper/e-commerce-` | `https://ecommerce-store.vercel.app` | Ready |
| **Admin Dashboard** | `srikrishnadeveloper/e-commerce_adminfrontend` | `https://ecommerce-admin.vercel.app` | Ready |
| **Backend** | `srikrishnadeveloper/e-commerce-backend` | `https://ecommerce-backend.onrender.com` | (Keep on Render) |

---

## Prerequisites

1. **Vercel account** (free tier - sign up at https://vercel.com)
2. **GitHub account** with repos pushed
3. **Backend deployed** on Render (or accessible from somewhere)

---

## Option A: Deploy Each Project Separately (RECOMMENDED)

This is the **simplest approach** since your repos are already separate.

### Step 1: Deploy Frontend to Vercel

```powershell
# Go to frontend folder
cd frontend

# Login to Vercel CLI (first time only)
npm install -g vercel

# Deploy
vercel --prod
```

**Or via Web:**
1. Go to [https://vercel.com](https://vercel.com)
2. Click **"Add New Project"**
3. Select **GitHub** → Choose `srikrishnadeveloper/e-commerce-`
4. Configure:
   - **Framework Preset:** Vite
   - **Root Directory:** `.` (or leave empty)
   - **Build Command:** `npm run build`
   - **Output Directory:** `dist`
5. **Environment Variables:**
   ```
   VITE_API_BASE_URL=https://ecommerce-backend.onrender.com/api
   ```
6. Click **"Deploy"** ✓

### Step 2: Deploy Admin Dashboard to Vercel

1. Go to [https://vercel.com](https://vercel.com)
2. Click **"Add New Project"**
3. Select **GitHub** → Choose `srikrishnadeveloper/e-commerce_adminfrontend`
4. Configure:
   - **Framework Preset:** Vite
   - **Root Directory:** `.`
   - **Build Command:** `npm run build`
   - **Output Directory:** `dist`
5. **Environment Variables:**
   ```
   VITE_API_BASE_URL=https://ecommerce-backend.onrender.com/api
   ```
6. Click **"Deploy"** ✓

---

## Option B: Deploy from Monorepo Root (Advanced)

If you want both projects under one Vercel account:

### Step 1: Create root `vercel.json`

Create `/frontend/vercel.json`:
```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "env": {
    "VITE_API_BASE_URL": "@vite_api_base_url"
  }
}
```

Create `/adminfrontend/vercel.json`:
```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "env": {
    "VITE_API_BASE_URL": "@vite_api_base_url"
  }
}
```

### Step 2: Deploy Each from Vercel Dashboard

1. Go to [https://vercel.com](https://vercel.com) → New Project
2. Import the **frontend** repo
3. **Override settings:**
   - Root Directory: `frontend`
   - Build Command: `npm run build`
   - Output: `dist`
4. Add env vars and deploy
5. Repeat for **adminfrontend** repo with Root Directory: `adminfrontend`

---

## Backend CORS Configuration (Critical!)

Before deploying frontend/admin to Vercel, **you MUST update your backend CORS settings on Render**:

### Step 1: Update Backend Environment Variables

On Render dashboard, go to your backend service and update environment variables:

**Add new variable:**
```
ALLOWED_ORIGINS=https://ecommerce-store.vercel.app,https://ecommerce-admin.vercel.app,http://localhost:5177,http://localhost:8091
```

**Or if ALLOWED_ORIGINS already exists, append to it:**
```
ALLOWED_ORIGINS=<existing-values>,https://ecommerce-store.vercel.app,https://ecommerce-admin.vercel.app
```

### Step 2: Redeploy Backend

- Go to Render → Backend Service → Manual Deploy
- Wait for deployment to complete
- Test CORS: Open browser DevTools → Network tab → Should see no CORS errors

---

## Environment Variables Setup

### For Frontend (`VITE_API_BASE_URL`)

**Development (local):**
```env
VITE_API_BASE_URL=http://localhost:5001/api
```

**Production (Vercel):**
```env
VITE_API_BASE_URL=https://ecommerce-backend.onrender.com/api
```

**To set in Vercel:**
1. Project Settings → Environment Variables
2. Name: `VITE_API_BASE_URL`
3. Value: `https://ecommerce-backend.onrender.com/api`
4. Check: **Production** ✓

### For Admin Dashboard (Same)

```env
VITE_API_BASE_URL=https://ecommerce-backend.onrender.com/api
```

---

## Verify Frontend Uses Env Vars

Make sure your code reads from env:

**frontend/src/services/dataService.ts:**
```typescript
const API_BASE = import.meta.env.VITE_API_BASE_URL || 'http://localhost:5001/api';

// Usage:
const response = await axios.get(`${API_BASE}/products`);
```

**adminfrontend/src/services/adminService.ts:**
```typescript
const API_BASE = import.meta.env.VITE_API_BASE_URL || 'http://localhost:5001/api';
```

---

## Deployment Checklist

- [ ] **Backend CORS updated** on Render with Vercel URLs
- [ ] **Backend redeployed** after CORS changes
- [ ] **Frontend env vars** set: `VITE_API_BASE_URL=https://ecommerce-backend.onrender.com/api`
- [ ] **Admin env vars** set: `VITE_API_BASE_URL=https://ecommerce-backend.onrender.com/api`
- [ ] **Both repos on GitHub** (frontend, adminfrontend, backend)
- [ ] **Vercel projects created** for frontend and admin
- [ ] **Environment variables added** in Vercel dashboard
- [ ] **Test deployment**: Visit Vercel URL → Check console for API calls

---

## Post-Deployment Testing

### Frontend
```
Visit: https://ecommerce-store.vercel.app
1. Load homepage
2. Open DevTools → Network tab
3. Click on a product
4. Should call: https://ecommerce-backend.onrender.com/api/products
5. No CORS errors ✓
```

### Admin Dashboard
```
Visit: https://ecommerce-admin.vercel.app
1. Login with admin credentials
2. Open DevTools → Network tab
3. Click "Dashboard" or "Orders"
4. Should call backend API ✓
5. No CORS errors ✓
```

---

## Automatic Deployments

Once connected:
- ✅ Every push to **master** branch (frontend) → Auto-deploy
- ✅ Every push to **master** branch (adminfrontend) → Auto-deploy
- ✅ Pull requests → Preview deployments

---

## Troubleshooting

### 🚨 CORS Error: "Access to XMLHttpRequest blocked by CORS policy"

**Cause:** Backend doesn't have Vercel domain in ALLOWED_ORIGINS

**Fix:**
1. Go to Render dashboard → Backend service
2. Environment → Edit `ALLOWED_ORIGINS`
3. Add: `https://ecommerce-store.vercel.app,https://ecommerce-admin.vercel.app`
4. Save changes
5. **Redeploy backend** (Manual Deploy button)
6. Wait ~2 min for deployment to complete
7. Clear browser cache (Ctrl+Shift+Del) and refresh

### Build Fails on Vercel
```
1. Check build command: npm run build
2. Check if all dependencies in package.json
3. Check Node version (Vercel uses latest by default)
4. View logs: Vercel Dashboard → Deployments → View logs
5. Common fix: npm install && npm run build (locally first)
```

### API calls failing (Blank response, no data)
```
1. Check VITE_API_BASE_URL in Vercel env vars
2. Run locally first: npm run dev
3. Check backend is actually running on Render
4. Check Network tab in DevTools for actual request URL
5. Verify backend CORS includes your Vercel domain
```

### Environment variables not loading
```
1. Make sure VITE_ prefix is used (VITE_API_BASE_URL, not API_BASE_URL)
2. Check Vercel dashboard → Project Settings → Environment Variables
3. Redeploy after adding/changing env vars (Vercel doesn't auto-reload)
4. Check console: console.log(import.meta.env.VITE_API_BASE_URL)
5. Clear browser cache and hard refresh
```

### "Cannot find module" errors after deploy
```
1. All dependencies must be in package.json, not package-lock.json only
2. Check: npm list <package-name>
3. Install missing: npm install <package-name> --save
4. Commit package.json and redeploy
```

---

## Advanced: Custom Domain Setup

To use custom domains instead of Vercel subdomains:

### Frontend Custom Domain
1. Vercel Dashboard → Project Settings → Domains
2. Add domain: `store.yourdomain.com`
3. Update DNS records (follow Vercel instructions)
4. Update backend CORS: Add `https://store.yourdomain.com`

### Admin Custom Domain
1. Vercel Dashboard → Project Settings → Domains
2. Add domain: `admin.yourdomain.com`
3. Update DNS records (follow Vercel instructions)
4. Update backend CORS: Add `https://admin.yourdomain.com`

---

## Summary

| Step | Action | Time |
|------|--------|------|
| 1 | Create Vercel account | 5 min |
| 2 | Deploy frontend | 5 min |
| 3 | Deploy admin | 5 min |
| 4 | Set environment variables | 2 min |
| 5 | Test deployments | 5 min |

**Total: ~20 minutes**

---

## Need Help?

- **Vercel Docs:** https://vercel.com/docs
- **Vite Deployment:** https://vitejs.dev/guide/ssr.html
- **Backend API:** https://ecommerce-backend.onrender.com/api/docs

