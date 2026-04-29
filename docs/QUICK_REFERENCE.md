# ⚡ Quick Reference Guide

<div align="center">

![Quick Ref](https://img.shields.io/badge/Quick-Reference-blue)
![Cheat Sheet](https://img.shields.io/badge/Cheat-Sheet-green)

**NutriNuts E-Commerce Platform - Developer Quick Reference**

</div>

---

## 🎯 Essential Commands

### Development Workflow

<table>
<tr>
<th width="30%">Task</th>
<th width="35%">Command</th>
<th width="35%">Location</th>
</tr>

<!-- Installation -->
<tr>
<td colspan="3" style="background:#f3f4f6;font-weight:bold">📦 Installation</td>
</tr>
<tr>
<td>Install all dependencies</td>
<td><code>npm run install:all</code></td>
<td>Root</td>
</tr>
<tr>
<td>Install backend only</td>
<td><code>npm install</code></td>
<td>backend/</td>
</tr>
<tr>
<td>Install frontend only</td>
<td><code>npm install</code></td>
<td>frontend/</td>
</tr>
<tr>
<td>Install admin only</td>
<td><code>npm install</code></td>
<td>adminfrontend/</td>
</tr>

<!-- Development Servers -->
<tr>
<td colspan="3" style="background:#f3f4f6;font-weight:bold">🚀 Development Servers</td>
</tr>
<tr>
<td>Start all services</td>
<td><code>.\start-workspace.ps1</code></td>
<td>Root</td>
</tr>
<tr>
<td>Start backend</td>
<td><code>npm run dev</code></td>
<td>backend/</td>
</tr>
<tr>
<td>Start frontend</td>
<td><code>npm run dev</code></td>
<td>frontend/</td>
</tr>
<tr>
<td>Start admin</td>
<td><code>npm run dev</code></td>
<td>adminfrontend/</td>
</tr>

<!-- Database Operations -->
<tr>
<td colspan="3" style="background:#f3f4f6;font-weight:bold">🗄️ Database Operations</td>
</tr>
<tr>
<td>Seed products</td>
<td><code>npm run seed</code></td>
<td>backend/</td>
</tr>
<tr>
<td>Seed site config</td>
<td><code>npm run seed:config</code></td>
<td>backend/</td>
</tr>
<tr>
<td>Create super admin</td>
<td><code>node scripts/createSuperAdmin.js</code></td>
<td>backend/</td>
</tr>
<tr>
<td>Create admin</td>
<td><code>node scripts/createAdmin.js</code></td>
<td>backend/</td>
</tr>
<tr>
<td>Check database connection</td>
<td><code>node scripts/test-connection.js</code></td>
<td>backend/</td>
</tr>

<!-- Testing -->
<tr>
<td colspan="3" style="background:#f3f4f6;font-weight:bold">🧪 Testing</td>
</tr>
<tr>
<td>Run all E2E tests</td>
<td><code>npx playwright test</code></td>
<td>frontend/</td>
</tr>
<tr>
<td>Run tests with UI</td>
<td><code>npx playwright test --ui</code></td>
<td>frontend/</td>
</tr>
<tr>
<td>Run specific test file</td>
<td><code>npx playwright test returns.spec.ts</code></td>
<td>frontend/</td>
</tr>
<tr>
<td>Generate test report</td>
<td><code>npx playwright show-report</code></td>
<td>frontend/</td>
</tr>

<!-- Build & Production -->
<tr>
<td colspan="3" style="background:#f3f4f6;font-weight:bold">📦 Build & Production</td>
</tr>
<tr>
<td>Build frontend</td>
<td><code>npm run build</code></td>
<td>frontend/</td>
</tr>
<tr>
<td>Build admin</td>
<td><code>npm run build</code></td>
<td>adminfrontend/</td>
</tr>
<tr>
<td>Preview frontend build</td>
<td><code>npm run preview</code></td>
<td>frontend/</td>
</tr>
<tr>
<td>Start backend in production</td>
<td><code>pm2 start server.js</code></td>
<td>backend/</td>
</tr>

<!-- Git Operations -->
<tr>
<td colspan="3" style="background:#f3f4f6;font-weight:bold">📝 Git Operations</td>
</tr>
<tr>
<td>Check status</td>
<td><code>git status</code></td>
<td>Any directory</td>
</tr>
<tr>
<td>Add all changes</td>
<td><code>git add -A</code></td>
<td>Any directory</td>
</tr>
<tr>
<td>Commit changes</td>
<td><code>git commit -m "message"</code></td>
<td>Any directory</td>
</tr>
<tr>
<td>Push to GitHub</td>
<td><code>git push origin master/main</code></td>
<td>Any directory</td>
</tr>
</table>

---

## 🌐 Service Endpoints

### Development URLs

| Service | URL | Default Port |
|---------|-----|--------------|
| **Frontend Store** | http://localhost:5177 | 5177 |
| **Admin Dashboard** | http://localhost:8091 | 8091 |
| **Backend API** | http://localhost:5001 | 5001 |
| **MongoDB** | mongodb://localhost:28000 | 28000 |

### API Base URLs

```javascript
// Development
const API_URL = 'http://localhost:5001/api';

// Production
const API_URL = 'https://api.nutrinuts.com/api';
```

---

## 🔑 Default Credentials

### Admin Access

```yaml
Username: superadmin
Password: Admin@12345
Priority: 1 (Super Admin)
Access: http://localhost:8091
```

> ⚠️ **SECURITY WARNING:** Change this password immediately in production!

### Test User Account

```yaml
Email: srik27600@gmail.com
Password: Test1234
Role: Customer
```

---

## 📁 Critical File Paths

### Configuration Files

| File | Path | Purpose |
|------|------|---------|
| **Backend Config** | `/backend/config.env` | Environment variables |
| **Frontend Config** | `/frontend/.env` | Frontend environment |
| **Admin Config** | `/adminfrontend/.env` | Admin environment |
| **Database Seed** | `/backend/scripts/seedDatabase.js` | Product seeding |
| **Site Config Seed** | `/backend/scripts/seed-site-config.js` | Site configuration |

### Important Directories

```
ecommerce/
├── backend/src/
│   ├── controllers/     # API business logic
│   ├── models/          # Database schemas
│   ├── routes/          # API endpoints
│   ├── middleware/      # Auth & validation
│   └── services/        # External services
│
├── frontend/src/
│   ├── components/      # React components
│   ├── pages/           # Route pages
│   ├── services/        # API clients
│   └── types/           # TypeScript types
│
├── adminfrontend/src/
│   ├── components/      # Admin UI components
│   ├── pages/           # Admin pages
│   └── services/        # Admin API clients
│
└── docs/                # Documentation
```

---

## 🗄️ Database Collections

### Quick Collection Reference

| Collection | Purpose | Key Fields |
|------------|---------|------------|
| **users** | Customer accounts | email, name, password, addresses |
| **products** | Product catalog | title, price, stock, category, images |
| **orders** | Order management | orderNumber, user, items, status, total |
| **admins** | Admin accounts | username, priority, email |
| **siteconfigs** | Site settings | branding, hero, footer, contact |

### Collection Queries

```javascript
// Find user by email
db.users.findOne({ email: "user@example.com" })

// Get all products in category
db.products.find({ category: "almonds" })

// Find order by order number
db.orders.findOne({ orderNumber: "ORD-2026-001" })

// Get all active admins
db.admins.find({ isActive: true })

// Get site configuration
db.siteconfigs.findOne()
```

---

## 🔌 API Endpoints Cheat Sheet

### Authentication

```http
POST   /api/auth/register        # Register user
POST   /api/auth/login            # Login user
GET    /api/auth/me               # Get current user
POST   /api/auth/logout           # Logout
POST   /api/auth/forgot-password  # Request password reset
PUT    /api/auth/reset-password   # Reset password
```

### Products

```http
GET    /api/products              # Get all products
GET    /api/products/:id          # Get single product
POST   /api/products              # Create product (admin)
PUT    /api/products/:id          # Update product (admin)
DELETE /api/products/:id          # Delete product (admin)
GET    /api/products/search?q=    # Search products
```

### Cart & Wishlist

```http
GET    /api/cart                  # Get cart
POST   /api/cart/add              # Add to cart
PUT    /api/cart/update           # Update quantity
DELETE /api/cart/remove/:id       # Remove item

GET    /api/wishlist              # Get wishlist
POST   /api/wishlist/add          # Add to wishlist
DELETE /api/wishlist/remove/:id   # Remove item
```

### Orders

```http
GET    /api/orders                # Get user orders
GET    /api/orders/:id            # Get single order
POST   /api/orders                # Create order
POST   /api/orders/:id/return     # Request return
GET    /api/orders/:id/track      # Track order
```

### Admin

```http
POST   /api/admin-auth/login      # Admin login
GET    /api/admin/orders          # Get all orders
PUT    /api/admin/orders/:id/status  # Update status
PUT    /api/admin/orders/:id/return  # Handle return
```

### Site Configuration

```http
GET    /api/siteconfig/all        # Get full config
PUT    /api/siteconfig/all        # Update config (admin)
GET    /api/siteconfig/branding   # Get branding
GET    /api/siteconfig/footer     # Get footer
GET    /api/siteconfig/hero       # Get hero carousel
```

---

## 🔒 Environment Variables Quick Reference

### Backend (.env)

```bash
# Essential
NODE_ENV=development
PORT=5001
DATABASE=mongodb://localhost:28000/ecommerce
JWT_SECRET=your-secret-32-chars-minimum
JWT_EXPIRE=7d

# Email
SENDGRID_API_KEY=your-sendgrid-api-key
SENDGRID_FROM_EMAIL=noreply@nutrinuts.com

# CORS
FRONTEND_URL=http://localhost:5177
ADMIN_URL=http://localhost:8091
```

### Frontend (.env)

```bash
VITE_API_URL=http://localhost:5001
```

---

## 🐛 Troubleshooting Quick Fixes

### Common Issues

<table>
<tr>
<th>Problem</th>
<th>Quick Fix</th>
</tr>

<tr>
<td>❌ Backend won't start</td>
<td>
1. Check if MongoDB is running<br/>
2. Verify <code>config.env</code> exists<br/>
3. Run <code>npm install</code>
</td>
</tr>

<tr>
<td>❌ Frontend API errors</td>
<td>
1. Verify backend is running on port 5001<br/>
2. Check CORS settings in backend<br/>
3. Verify <code>VITE_API_URL</code> in .env
</td>
</tr>

<tr>
<td>❌ Login fails</td>
<td>
1. Check database connection<br/>
2. Verify user exists in database<br/>
3. Check JWT_SECRET is set
</td>
</tr>

<tr>
<td>❌ Images not loading</td>
<td>
1. Check <code>/images</code> folder exists<br/>
2. Verify image paths in database<br/>
3. Check file permissions
</td>
</tr>

<tr>
<td>❌ Email not sending</td>
<td>
1. Verify SENDGRID_API_KEY<br/>
2. Check SendGrid account status<br/>
3. Review email logs
</td>
</tr>

<tr>
<td>❌ Tests failing</td>
<td>
1. Run <code>npx playwright install</code><br/>
2. Ensure dev server is running<br/>
3. Clear test-results folder
</td>
</tr>
</table>

### Emergency Commands

```bash
# Kill all Node processes
taskkill /F /IM node.exe

# Reset database (CAUTION: Deletes all data!)
mongosh
use ecommerce
db.dropDatabase()

# Clear npm cache
npm cache clean --force

# Reinstall dependencies
rm -rf node_modules package-lock.json
npm install

# Reset git to last commit
git reset --hard HEAD
```

---

## 📊 Status Codes & Meanings

### Order Status Flow

```
pending → confirmed → processing → shipped → delivered
   ↓          ↓           ↓
cancelled  cancelled  cancelled

delivered → return_requested → return_approved → refunded
                            → return_rejected
```

### HTTP Status Codes

| Code | Meaning | When Used |
|------|---------|-----------|
| **200** | OK | Successful GET, PUT, DELETE |
| **201** | Created | Successful POST (created resource) |
| **400** | Bad Request | Invalid request data |
| **401** | Unauthorized | Missing/invalid token |
| **403** | Forbidden | Insufficient permissions |
| **404** | Not Found | Resource doesn't exist |
| **409** | Conflict | Duplicate resource |
| **500** | Server Error | Internal server error |

---

## 🎨 Color Palette Reference

### Brand Colors

```css
/* Primary Colors */
--primary: #f59e0b;        /* Orange */
--primary-dark: #d97706;   /* Dark Orange */
--primary-light: #fbbf24;  /* Light Orange */

/* Neutral Colors */
--gray-50: #f9fafb;
--gray-100: #f3f4f6;
--gray-200: #e5e7eb;
--gray-800: #1f2937;
--gray-900: #111827;

/* Status Colors */
--success: #10b981;  /* Green */
--warning: #f59e0b;  /* Orange */
--error: #ef4444;    /* Red */
--info: #3b82f6;     /* Blue */
```

---

## 📱 Responsive Breakpoints

### Tailwind CSS Breakpoints

| Breakpoint | Min Width | CSS |
|------------|-----------|-----|
| **sm** | 640px | `@media (min-width: 640px)` |
| **md** | 768px | `@media (min-width: 768px)` |
| **lg** | 1024px | `@media (min-width: 1024px)` |
| **xl** | 1280px | `@media (min-width: 1280px)` |
| **2xl** | 1536px | `@media (min-width: 1536px)` |

### Usage Examples

```jsx
// Mobile first approach
<div className="py-1 sm:py-3 lg:py-10">
  {/* Padding: 4px mobile, 12px tablet, 40px desktop */}
</div>

<div className="text-sm md:text-base lg:text-lg">
  {/* Text size scales with screen size */}
</div>

<div className="hidden lg:block">
  {/* Only visible on desktop */}
</div>

<div className="block lg:hidden">
  {/* Only visible on mobile/tablet */}
</div>
```

---

## 🔗 Useful Links

| Resource | URL |
|----------|-----|
| **Main Docs** | [README.md](../README.md) |
| **API Reference** | [API_REFERENCE.md](API_REFERENCE.md) |
| **Architecture** | [ARCHITECTURE.md](ARCHITECTURE.md) |
| **Deployment** | [DEPLOYMENT.md](DEPLOYMENT.md) |
| **MongoDB Docs** | https://docs.mongodb.com |
| **React Docs** | https://react.dev |
| **Tailwind CSS** | https://tailwindcss.com |
| **Playwright** | https://playwright.dev |

---

<div align="center">

**Quick Reference Guide**

[📖 Full Documentation](../README.md) • [🌐 API Reference](API_REFERENCE.md) • [🐛 Report Issue](issues)

---

*Last Updated: January 11, 2026*

</div>
