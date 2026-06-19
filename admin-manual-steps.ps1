# Manual Steps to Create Admin Frontend on Vercel

Write-Host "========================================"
Write-Host "CREATE NEW ADMIN FRONTEND ON VERCEL"
Write-Host "========================================"
Write-Host ""

Write-Host "STEP 1: Go to Vercel Dashboard"
Write-Host "URL: https://vercel.com/dashboard"
Write-Host ""

Write-Host "STEP 2: Click 'Add New Project'"
Write-Host "Click button on top right: Add New Project"
Write-Host ""

Write-Host "STEP 3: Import Git Repository"
Write-Host "- Click 'Import Git Repository'"
Write-Host "- Search for: srikrishnadeveloper/e-commerce_adminfrontend"
Write-Host "- Click on it to select"
Write-Host ""

Write-Host "STEP 4: Configure Project"
Write-Host "- Project Name: adminfrontend"
Write-Host "- Framework: Vite"
Write-Host "- Root Directory: . (dot)"
Write-Host "- Build Command: npm run build"
Write-Host "- Output Directory: dist"
Write-Host ""

Write-Host "STEP 5: Add Environment Variables"
Write-Host "- Click 'Environment Variables'"
Write-Host "- Name: VITE_API_BASE_URL"
Write-Host "- Value: https://ecommerce-backend.onrender.com/api"
Write-Host "- Select: Production"
Write-Host "- Click 'Add'"
Write-Host ""

Write-Host "STEP 6: Deploy"
Write-Host "- Click 'Deploy' button"
Write-Host "- Wait 3-5 minutes for build to complete"
Write-Host ""

Write-Host "========================================"
Write-Host "Done! Your admin dashboard will be live"
Write-Host "Check dashboard for the new URL"
Write-Host "========================================"
Write-Host ""

Write-Host "Then update Render Backend CORS:"
Write-Host "1. Go to https://dashboard.render.com"
Write-Host "2. Select Backend service"
Write-Host "3. Environment -> ALLOWED_ORIGINS"
Write-Host "4. Add your new admin Vercel URL (you'll see it in step 6)"
Write-Host "5. Save and Redeploy backend"
