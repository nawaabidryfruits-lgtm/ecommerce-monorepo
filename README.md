# 🛒 NutriNuts E-Commerce Platform

<div align="center">

![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)
![Node](https://img.shields.io/badge/node-%3E%3D18.0.0-brightgreen.svg)
![MongoDB](https://img.shields.io/badge/mongodb-7.0+-green.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

**Premium Dry Fruits & Nuts - Full-Stack E-Commerce Solution**

[Features](#-key-features) • [Quick Start](#-quick-start) • [Architecture](#-architecture) • [Documentation](#-documentation) • [API](#-api-reference)

</div>

---

## 📊 System Overview

```mermaid
graph TB
    subgraph "Client Applications"
        A[🛍️ Customer Store<br/>React + TypeScript<br/>Port 5177]
        B[⚙️ Admin Dashboard<br/>React + Shadcn UI<br/>Port 8091]
    end
    
    subgraph "Backend Services"
        C[🚀 REST API<br/>Express.js<br/>Port 5001]
    end
    
    subgraph "Data Layer"
        D[(💾 MongoDB<br/>Port 28000<br/>ecommerce)]
        E[📁 Static Files<br/>/images]
    end
    
    A -->|HTTP/REST| C
    B -->|HTTP/REST| C
    C -->|Mongoose ODM| D
    C -->|File System| E
    
    style A fill:#4ade80,stroke:#22c55e,stroke-width:2px,color:#000
    style B fill:#60a5fa,stroke:#3b82f6,stroke-width:2px,color:#000
    style C fill:#f59e0b,stroke:#d97706,stroke-width:2px,color:#000
    style D fill:#a78bfa,stroke:#8b5cf6,stroke-width:2px,color:#000
    style E fill:#fbbf24,stroke:#f59e0b,stroke-width:2px,color:#000
```

---

## ✨ Key Features

<table>
<tr>
<td width="50%">

### 🛍️ Customer Experience
- 🎨 Modern, responsive UI with Tailwind CSS
- 🔍 Real-time product search & filtering
- 🛒 Shopping cart with persistent state
- ❤️ Wishlist management
- 📦 Order tracking with status updates
- 🔄 Product return system
- 👤 User authentication & profile
- 💳 Secure checkout process

</td>
<td width="50%">

### ⚙️ Admin Management
- 📊 Comprehensive dashboard analytics
- 📦 Product & inventory management
- 👥 Customer management
- 📋 Order processing & fulfillment
- 🔄 Return request handling
- 🎨 Dynamic site configuration
- 📧 Email template customization
- 👮 Role-based access control

</td>
</tr>
</table>

---

## 🚀 Quick Start

### Prerequisites

```bash
Node.js >= 18.0.0
MongoDB >= 7.0
npm or yarn
```

### ⚡ One-Command Setup

```powershell
# Clone and install
git clone <repository-url>
cd ecommerce

# Install all dependencies
npm run install:all

# Start all services
.\start-workspace.ps1
```

### 📋 Service Access

| Service | URL | Credentials |
|---------|-----|-------------|
| **Customer Store** | http://localhost:5177 | Register new account |
| **Admin Dashboard** | http://localhost:8091 | `superadmin` / `Admin@12345` |
| **API Documentation** | http://localhost:5001/api | - |
| **MongoDB** | mongodb://localhost:28000 | - |

---

## 🏗️ Architecture

### 📁 Repository Structure

```
ecommerce/
│
├── 📂 backend/                    # Express.js REST API
│   ├── 📂 src/
│   │   ├── 📂 controllers/        # Business logic
│   │   ├── 📂 models/             # Mongoose schemas
│   │   ├── 📂 routes/             # API endpoints
│   │   ├── 📂 middleware/         # Auth, validation
│   │   ├── 📂 services/           # Email, uploads
│   │   └── 📂 utils/              # Helpers
│   ├── 📂 scripts/                # DB seeds & utilities
│   ├── 📄 server.js               # Entry point
│   └── 📄 config.env              # Environment config
│
├── 📂 frontend/                   # Customer Store (React)
│   ├── 📂 src/
│   │   ├── 📂 components/         # UI components
│   │   ├── 📂 pages/              # Route pages
│   │   ├── 📂 services/           # API clients
│   │   ├── 📂 hooks/              # Custom React hooks
│   │   └── 📂 types/              # TypeScript definitions
│   └── 📂 tests/                  # Playwright E2E tests
│
├── 📂 adminfrontend/              # Admin Dashboard (React)
│   ├── 📂 src/
│   │   ├── 📂 components/         # Shadcn UI components
│   │   ├── 📂 pages/              # Dashboard pages
│   │   └── 📂 services/           # API clients
│
├── 📂 images/                     # Static image assets
├── 📂 docs/                       # Comprehensive documentation
└── 📄 start-workspace.ps1         # Launch script

```

### 🔄 Data Flow Architecture

```mermaid
sequenceDiagram
    participant U as 👤 Customer
    participant F as 🛍️ Frontend
    participant A as 🚀 API Server
    participant D as 💾 Database
    participant E as 📧 Email Service

    U->>F: Browse Products
    F->>A: GET /api/products
    A->>D: Query Products
    D-->>A: Product Data
    A-->>F: JSON Response
    F-->>U: Display Products

    U->>F: Add to Cart
    F->>A: POST /api/cart
    A->>D: Update Cart
    D-->>A: Cart Updated
    A-->>F: Success
    F-->>U: Cart Updated

    U->>F: Checkout
    F->>A: POST /api/orders
    A->>D: Create Order
    D-->>A: Order Created
    A->>E: Send Confirmation Email
    E-->>U: 📧 Order Confirmation
    A-->>F: Order Success
    F-->>U: Order Confirmation Page
```

---

## 📚 Documentation

### Core Documentation

<table>
<tr>
<td width="50%">

**📚 Getting Started**
- [⚡ Quick Reference](docs/QUICK_REFERENCE.md)
  **START HERE** - Commands, endpoints, troubleshooting
- [📖 Project Overview](docs/01_Project_Overview.md)
  Complete system architecture and setup
- [🏗️ Architecture Guide](docs/ARCHITECTURE.md)
  Technical architecture with diagrams
- [🌐 API Reference](docs/API_REFERENCE.md)
  Complete API endpoint documentation
- [🚀 Deployment Guide](docs/DEPLOYMENT.md)
  Production deployment instructions

</td>
<td width="50%">

**🔧 Operations & Development**
- [✅ Tasks & TODOs](docs/02_Tasks_and_TODOs.md)
  Project roadmap and tracking
- [🔐 Admin Authentication](docs/03_Admin_Auth_Guide.md)
  Admin roles and security
- [📧 Email System](docs/04_Email_Implementation.md)
  Email templates and notifications
- [💡 Knowledge Base](docs/05_Knowledge_Base.md)
  Development patterns
- [🧪 Testing Guide](docs/06_Testing_Guide.md)
  Comprehensive testing docs

</td>
</tr>
</table>

### Quick Reference Guides

<table>
<tr>
<td>

**🔧 Environment Setup**
```bash
# Backend (.env)
DATABASE=mongodb://localhost:28000/ecommerce
JWT_SECRET=your-secret-key
JWT_EXPIRE=7d
SENDGRID_API_KEY=your-key
SENDGRID_FROM_EMAIL=noreply@nutrinuts.com
```

</td>
<td>

**🎯 Key NPM Scripts**
```bash
# Development
npm run dev         # Start dev server
npm run seed        # Seed database
npm run seed:config # Seed site config

# Testing
npm test            # Run tests
npm run test:e2e    # E2E tests
```

</td>
</tr>
</table>

---

## 🌐 API Reference

### Authentication Endpoints

```http
POST   /api/auth/register          # Register new user
POST   /api/auth/login             # User login
GET    /api/auth/me                # Get current user
POST   /api/auth/logout            # Logout user
POST   /api/auth/forgot-password   # Password reset request
PUT    /api/auth/reset-password    # Reset password
```

### Product Endpoints

```http
GET    /api/products               # Get all products
GET    /api/products/:id           # Get single product
POST   /api/products               # Create product (admin)
PUT    /api/products/:id           # Update product (admin)
DELETE /api/products/:id           # Delete product (admin)
GET    /api/products/search        # Search products
```

### Order Endpoints

```http
GET    /api/orders                 # Get user orders
GET    /api/orders/:id             # Get single order
POST   /api/orders                 # Create order
PUT    /api/orders/:id             # Update order status (admin)
POST   /api/orders/:id/return      # Request return
```

### Site Configuration

```http
GET    /api/siteconfig/all         # Get full site config
PUT    /api/siteconfig/all         # Update site config (admin)
GET    /api/siteconfig/branding    # Get branding config
GET    /api/siteconfig/footer      # Get footer config
```

[📖 Complete API Documentation →](docs/01_Project_Overview.md#api-endpoints)

---

## 🗄️ Database Schema

### Core Collections

```mermaid
erDiagram
    USER ||--o{ ORDER : places
    USER ||--o{ CART : has
    USER ||--o{ WISHLIST : has
    ORDER ||--|{ ORDER_ITEM : contains
    PRODUCT ||--o{ ORDER_ITEM : included_in
    PRODUCT ||--o{ CART : in
    PRODUCT ||--o{ WISHLIST : in
    
    USER {
        string name
        string email
        string password
        string phone
        array addresses
        date createdAt
    }
    
    PRODUCT {
        string title
        string description
        number price
        number stock
        array images
        string category
        object specifications
    }
    
    ORDER {
        ref user
        array items
        number total
        string status
        object shipping
        object returnRequest
        date createdAt
    }
```

---

## 🔐 Security Features

| Feature | Implementation |
|---------|----------------|
| **Authentication** | JWT tokens with 7-day expiry |
| **Password Security** | bcrypt hashing with salt rounds |
| **API Protection** | Protected routes with middleware |
| **Role-Based Access** | Admin priority levels (1-100) |
| **Input Validation** | Mongoose schema validation |
| **CORS** | Configured cross-origin policies |
| **Environment Variables** | Sensitive data in .env files |

---

## 🧪 Testing

### Test Coverage

```bash
┌─────────────────────────────┬──────────┐
│ Component                   │ Tests    │
├─────────────────────────────┼──────────┤
│ Navbar & Navigation         │ 30       │
│ Product Listing & Filters   │ 80       │
│ Checkout Flow               │ 80       │
│ Cart & Wishlist             │ 60       │
│ User Authentication         │ 50       │
│ Admin Dashboard             │ 40       │
│ Return System               │ 15       │
│ Responsive Design           │ 100      │
│ Accessibility (A11y)        │ 50       │
├─────────────────────────────┼──────────┤
│ TOTAL                       │ 505      │
└─────────────────────────────┴──────────┘
```

### Running Tests

```bash
# Frontend E2E Tests
cd frontend
npx playwright test                    # Run all tests
npx playwright test --headed           # Watch tests
npx playwright test --ui               # Interactive UI
npx playwright test --reporter=html    # Generate report

# Backend Unit Tests
cd backend
npm test                               # Run unit tests
npm run test:watch                     # Watch mode
```

---

## 🚀 Deployment

### Production Checklist

- [ ] Update environment variables
- [ ] Change default admin password
- [ ] Configure CORS origins
- [ ] Set up SSL/TLS certificates
- [ ] Configure MongoDB replica set
- [ ] Set up email service (SendGrid)
- [ ] Configure file upload limits
- [ ] Enable rate limiting
- [ ] Set up monitoring & logging
- [ ] Configure backup strategy

### Recommended Stack

| Layer | Technology |
|-------|-----------|
| **Hosting** | AWS EC2, DigitalOcean, Heroku |
| **Database** | MongoDB Atlas |
| **CDN** | Cloudflare, AWS CloudFront |
| **Email** | SendGrid, AWS SES |
| **Monitoring** | PM2, New Relic |

---

## 🤝 Contributing

We welcome contributions! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 📞 Support

<div align="center">

**Need Help?**

[📧 Email Support](mailto:support@nutrinuts.com) • [📖 Documentation](docs/) • [🐛 Report Bug](issues)

---

Made with ❤️ by the NutriNuts Team

</div>
