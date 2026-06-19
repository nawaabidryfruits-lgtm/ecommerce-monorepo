# Vercel Deployment - Quick Start

## What's Been Prepared

✅ **Vercel configuration files created:**
- `frontend/vercel.json` - Vite build config
- `adminfrontend/vercel.json` - Vite build config
- `frontend/.env.example` - Environment variable template
- `adminfrontend/.env.example` - Environment variable template

✅ **Code updated to use environment variables:**
- `frontend/src/services/dataService.ts` - Now reads VITE_API_BASE_URL
- `frontend/src/services/authService.js` - Now reads VITE_API_BASE_URL
- `frontend/src/services/orderService.js` - Now reads VITE_API_BASE_URL
- `frontend/src/services/addressService.ts` - Now reads VITE_API_BASE_URL
- `frontend/src/services/siteConfigService.js` - Now reads VITE_API_BASE_URL
- `adminfrontend/src/services/api.ts` - Now reads VITE_API_BASE_URL

---

## 5-Minute Quick Start

### Step 1: Update Backend CORS (Most Important!)

**Before deploying frontend to Vercel, update your backend on Render:**

1. Go to https://dashboard.render.com
2. Select your **Backend** service
3. Click **Environment** (or Settings → Environment)
4. Find or create `ALLOWED_ORIGINS` environment variable
5. Set value to:
   ```
   https://ecommerce-store.vercel.app,https://ecommerce-admin.vercel.app,http://localhost:5177,http://localhost:8091
   ```
6. Save changes
7. Click **Redeploy** (manual deploy button at top)
8. Wait for deployment (2-5 minutes)

### Step 2: Push Code to GitHub

From each folder, commit and push the changes:

```powershell
# Frontend
cd frontend
git add .
git commit -m "Setup Vercel deployment with environment variables"
git push origin master

# Admin Frontend
cd adminfrontend
git add .
git commit -m "Setup Vercel deployment with environment variables"
git push origin master
```

### Step 3: Create Vercel Project (Frontend)

1. Go to https://vercel.com
2. Click **Add New Project**
3. **Import Git Repository** → Select `srikrishnadeveloper/e-commerce-`
4. Framework: **Vite** (auto-detected)
5. Root Directory: `.` or leave blank
6. Build: `npm run build`
7. Output: `dist`
8. **Add Environment Variable:**
   - Name: `VITE_API_BASE_URL`
   - Value: `https://ecommerce-backend.onrender.com/api`
   - Select **Production** checkbox
9. Click **Deploy** ✓

**Wait for deployment (2-3 min)**

### Step 4: Create Vercel Project (Admin)

1. Go to https://vercel.com
2. Click **Add New Project**
3. **Import Git Repository** → Select `srikrishnadeveloper/e-commerce_adminfrontend`
4. Framework: **Vite** (auto-detected)
5. Root Directory: `.`
6. Build: `npm run build`
7. Output: `dist`
8. **Add Environment Variable:**
   - Name: `VITE_API_BASE_URL`
   - Value: `https://ecommerce-backend.onrender.com/api`
   - Select **Production** checkbox
9. Click **Deploy** ✓

**Wait for deployment (2-3 min)**

---

## Testing Your Deployment

### Frontend (Customer Store)

```
1. Visit: https://ecommerce-store.vercel.app
2. Should load homepage with products
3. Open DevTools (F12) → Console tab
4. Should see NO errors
5. Network tab → Look for calls to ecommerce-backend.onrender.com
```

### Admin Dashboard

```
1. Visit: https://ecommerce-admin.vercel.app
2. Login with admin credentials
3. Open DevTools (F12) → Console tab
4. Should see NO errors
5. Navigate to Dashboard/Orders
6. Should fetch data from backend successfully
```

### Common Issue: CORS Error

```
Error: Access to XMLHttpRequest blocked by CORS policy

Solution:
1. Double-check ALLOWED_ORIGINS on Render backend
2. Make sure you clicked "Redeploy" on Render
3. Wait 5 minutes for changes to propagate
4. Hard refresh browser (Ctrl+Shift+R)
5. Check Network tab to see actual error message
```

---

## Local Development (Unchanged)

Your local development still works as before:

```powershell
# Terminal 1: Backend
cd backend
npm run dev  # Runs on localhost:5001

# Terminal 2: Frontend
cd frontend
npm run dev  # Runs on localhost:5177

# Terminal 3: Admin
cd adminfrontend
npm run dev  # Runs on localhost:8091
```

Locally, everything uses `/api` (relative) which works fine with local backend.

---

## Directory Structure (What was created)

```
ecommerce-monorepo/
├── frontend/
│   ├── vercel.json          ✨ NEW - Vercel config
│   ├── .env.example         ✨ NEW - Env vars template
│   └── src/services/
│       ├── dataService.ts   ✅ UPDATED - Uses VITE_API_BASE_URL
│       ├── authService.js   ✅ UPDATED - Uses VITE_API_BASE_URL
│       ├── orderService.js  ✅ UPDATED - Uses VITE_API_BASE_URL
│       ├── addressService.ts ✅ UPDATED - Uses VITE_API_BASE_URL
│       └── siteConfigService.js ✅ UPDATED - Uses VITE_API_BASE_URL
├── adminfrontend/
│   ├── vercel.json          ✨ NEW - Vercel config
│   ├── .env.example         ✨ NEW - Env vars template
│   └── src/services/
│       └── api.ts           ✅ UPDATED - Uses VITE_API_BASE_URL
└── VERCEL_DEPLOYMENT.md     ✨ NEW - Full deployment guide
```

---

## FAQ

### Q: Can I use different domain names?
**A:** Yes! See "Custom Domains" section in VERCEL_DEPLOYMENT.md

### Q: What if I want to deploy backend on Vercel too?
**A:** Vercel is for front-end only (Node.js edge functions). Keep backend on Render.

### Q: How do I update code after deployment?
**A:** Just push to GitHub. Vercel auto-deploys on every push.

### Q: Can I view deployment logs?
**A:** Yes! Vercel Dashboard → Deployments → Click deployment → View logs

### Q: How do I rollback a bad deployment?
**A:** Vercel Dashboard → Deployments → Click older deployment → "Redeploy"

---

## Need Help?

- 📖 Full guide: See `VERCEL_DEPLOYMENT.md`
- 🔗 Vercel docs: https://vercel.com/docs
- 🐛 Troubleshooting: See "Troubleshooting" section in VERCEL_DEPLOYMENT.md

---

**Time to Deploy: ~20 minutes**

Most of the time is waiting for builds to complete. 🚀
