# 🏗️ System Architecture & Design Patterns

<div align="center">

![Architecture](https://img.shields.io/badge/Architecture-Microservices-blue)
![Pattern](https://img.shields.io/badge/Pattern-MVC-green)
![Database](https://img.shields.io/badge/Database-MongoDB-success)

**NutriNuts E-Commerce Platform - Technical Architecture Documentation**

</div>

---

## 📋 Table of Contents

- [System Overview](#-system-overview)
- [Architecture Layers](#-architecture-layers)
- [Data Flow Diagrams](#-data-flow-diagrams)
- [Database Schema](#-database-schema)
- [Security Architecture](#-security-architecture)
- [Deployment Architecture](#-deployment-architecture)
- [Scalability Patterns](#-scalability-patterns)

---

## 🎯 System Overview

### Three-Tier Architecture

```mermaid
graph TB
    subgraph "Presentation Layer"
        A1[Customer Web App<br/>React + TypeScript]
        A2[Admin Dashboard<br/>React + Shadcn UI]
        A3[Mobile App<br/>Future: React Native]
    end
    
    subgraph "Application Layer"
        B1[API Gateway<br/>Express.js]
        B2[Authentication Service<br/>JWT + bcrypt]
        B3[Business Logic<br/>Controllers]
        B4[Email Service<br/>SendGrid]
        B5[File Upload Service<br/>Multer]
    end
    
    subgraph "Data Layer"
        C1[(Primary Database<br/>MongoDB)]
        C2[File Storage<br/>Local/S3]
        C3[Cache Layer<br/>Future: Redis]
    end
    
    A1 --> B1
    A2 --> B1
    A3 --> B1
    
    B1 --> B2
    B1 --> B3
    B3 --> B4
    B3 --> B5
    
    B2 --> C1
    B3 --> C1
    B5 --> C2
    
    style A1 fill:#10b981,stroke:#059669,stroke-width:2px,color:#fff
    style A2 fill:#3b82f6,stroke:#2563eb,stroke-width:2px,color:#fff
    style A3 fill:#8b5cf6,stroke:#7c3aed,stroke-width:2px,color:#fff
    
    style B1 fill:#f59e0b,stroke:#d97706,stroke-width:2px,color:#000
    style B2 fill:#f59e0b,stroke:#d97706,stroke-width:2px,color:#000
    style B3 fill:#f59e0b,stroke:#d97706,stroke-width:2px,color:#000
    style B4 fill:#f59e0b,stroke:#d97706,stroke-width:2px,color:#000
    style B5 fill:#f59e0b,stroke:#d97706,stroke-width:2px,color:#000
    
    style C1 fill:#8b5cf6,stroke:#7c3aed,stroke-width:2px,color:#fff
    style C2 fill:#ef4444,stroke:#dc2626,stroke-width:2px,color:#fff
    style C3 fill:#06b6d4,stroke:#0891b2,stroke-width:2px,color:#fff
```

### Component Interaction Map

```mermaid
graph LR
    subgraph "Frontend Components"
        F1[Navbar]
        F2[Product List]
        F3[Cart]
        F4[Checkout]
        F5[Order Tracking]
    end
    
    subgraph "API Services"
        A1[Auth API]
        A2[Product API]
        A3[Cart API]
        A4[Order API]
        A5[User API]
    end
    
    subgraph "Backend Controllers"
        C1[AuthController]
        C2[ProductController]
        C3[CartController]
        C4[OrderController]
        C5[UserController]
    end
    
    subgraph "Data Models"
        M1[(User)]
        M2[(Product)]
        M3[(Cart)]
        M4[(Order)]
        M5[(SiteConfig)]
    end
    
    F1 --> A1
    F2 --> A2
    F3 --> A3
    F4 --> A4
    F5 --> A4
    
    A1 --> C1
    A2 --> C2
    A3 --> C3
    A4 --> C4
    A5 --> C5
    
    C1 --> M1
    C2 --> M2
    C3 --> M3
    C4 --> M4
    C5 --> M1
```

---

## 🏛️ Architecture Layers

### 1. Presentation Layer (Frontend)

#### Customer Store Architecture

```mermaid
graph TD
    A[React Application] --> B[React Router]
    B --> C[Pages]
    B --> D[Components]
    
    C --> C1[HomePage]
    C --> C2[ProductPage]
    C --> C3[CartPage]
    C --> C4[CheckoutPage]
    C --> C5[AccountPage]
    
    D --> D1[Navbar]
    D --> D2[Footer]
    D --> D3[ProductCard]
    D --> D4[Toast]
    
    A --> E[State Management]
    E --> E1[Local State]
    E --> E2[Context API]
    E --> E3[localStorage]
    
    A --> F[API Services]
    F --> F1[authService]
    F --> F2[dataService]
    F --> F3[orderService]
    F --> F4[cartService]
    
    style A fill:#10b981,color:#fff
    style B fill:#3b82f6,color:#fff
    style E fill:#f59e0b,color:#000
    style F fill:#8b5cf6,color:#fff
```

#### Admin Dashboard Architecture

```mermaid
graph TD
    A[React Admin App] --> B[Protected Routes]
    B --> C[Dashboard Pages]
    
    C --> C1[Analytics Dashboard]
    C --> C2[Product Management]
    C --> C3[Order Management]
    C --> C4[Customer Management]
    C --> C5[Site Configuration]
    C --> C6[Admin Management]
    
    A --> D[Shadcn UI Components]
    D --> D1[Table]
    D --> D2[Dialog]
    D --> D3[Form]
    D --> D4[Tabs]
    
    A --> E[Admin Services]
    E --> E1[Admin Auth]
    E --> E2[Admin API]
    
    style A fill:#3b82f6,color:#fff
    style B fill:#ef4444,color:#fff
    style D fill:#10b981,color:#fff
    style E fill:#8b5cf6,color:#fff
```

### 2. Application Layer (Backend)

#### MVC Pattern Implementation

```mermaid
graph LR
    A[HTTP Request] --> B[Routes]
    B --> C[Middleware]
    C --> D[Controllers]
    D --> E[Models]
    E --> F[(Database)]
    
    C --> C1[Auth Middleware]
    C --> C2[Validation Middleware]
    C --> C3[Error Handler]
    
    D --> D1[Business Logic]
    D --> D2[Data Validation]
    D --> D3[Response Formation]
    
    E --> E1[Schema Definition]
    E --> E2[Validation Rules]
    E --> E3[Virtual Fields]
    
    D --> G[Services]
    G --> G1[Email Service]
    G --> G2[Upload Service]
    G --> G3[Payment Service]
    
    style A fill:#10b981,color:#fff
    style C fill:#f59e0b,color:#000
    style D fill:#3b82f6,color:#fff
    style E fill:#8b5cf6,color:#fff
    style F fill:#ef4444,color:#fff
```

#### Request Processing Flow

```mermaid
sequenceDiagram
    participant Client
    participant Route
    participant Middleware
    participant Controller
    participant Model
    participant Database
    participant Response
    
    Client->>Route: HTTP Request
    Route->>Middleware: Pass to auth middleware
    
    alt Authentication Required
        Middleware->>Middleware: Verify JWT Token
        alt Token Invalid
            Middleware->>Response: 401 Unauthorized
            Response->>Client: Error Response
        end
    end
    
    Middleware->>Controller: Authenticated Request
    Controller->>Controller: Validate Input
    
    alt Validation Fails
        Controller->>Response: 400 Bad Request
        Response->>Client: Validation Errors
    end
    
    Controller->>Model: Query/Update Data
    Model->>Database: Mongoose Query
    Database-->>Model: Data Result
    Model-->>Controller: Formatted Data
    
    Controller->>Controller: Format Response
    Controller->>Response: Success Response
    Response->>Client: JSON Response
```

### 3. Data Layer

#### MongoDB Collections Structure

```mermaid
erDiagram
    USER ||--o{ ORDER : places
    USER ||--o{ CART : has
    USER ||--o{ WISHLIST : has
    USER ||--o{ ADDRESS : has
    
    ORDER ||--|{ ORDER_ITEM : contains
    ORDER ||--o| RETURN_REQUEST : may_have
    
    PRODUCT ||--o{ ORDER_ITEM : included_in
    PRODUCT ||--o{ CART_ITEM : in
    PRODUCT ||--o{ WISHLIST_ITEM : in
    PRODUCT ||--o{ REVIEW : has
    
    ADMIN ||--o{ ORDER : manages
    ADMIN ||--o{ PRODUCT : manages
    
    SITE_CONFIG ||--|| BRANDING : contains
    SITE_CONFIG ||--|| FOOTER : contains
    SITE_CONFIG ||--|| HERO_CAROUSEL : contains
    
    USER {
        ObjectId _id PK
        string name
        string email UK
        string password
        string phone
        array addresses
        date createdAt
        date updatedAt
    }
    
    PRODUCT {
        ObjectId _id PK
        string title
        string description
        number price
        number discountPrice
        string category
        number stock
        array images
        object specifications
        number rating
        number reviewCount
        boolean featured
        date createdAt
    }
    
    ORDER {
        ObjectId _id PK
        string orderNumber UK
        ObjectId user FK
        array items
        number subtotal
        number shipping
        number tax
        number total
        string status
        string paymentMethod
        string paymentStatus
        object shippingAddress
        object returnRequest
        date createdAt
    }
    
    CART {
        ObjectId _id PK
        ObjectId user FK
        array items
        number total
        date updatedAt
    }
```

---

## 📊 Data Flow Diagrams

### User Registration & Authentication Flow

```mermaid
flowchart TD
    A[User Visits Site] --> B{Registered?}
    B -->|No| C[Click Register]
    B -->|Yes| D[Click Login]
    
    C --> E[Fill Registration Form]
    E --> F[Submit Form]
    F --> G[Backend Validation]
    
    G --> H{Valid Data?}
    H -->|No| I[Show Error Messages]
    I --> E
    H -->|Yes| J[Hash Password]
    
    J --> K[Create User in DB]
    K --> L[Send Verification Email]
    L --> M[Generate JWT Token]
    M --> N[Return Token & User Data]
    N --> O[Store in localStorage]
    O --> P[Redirect to Home]
    
    D --> Q[Enter Credentials]
    Q --> R[Submit Login Form]
    R --> S[Verify Credentials]
    
    S --> T{Valid?}
    T -->|No| U[Show Error]
    U --> Q
    T -->|Yes| V[Update Last Login]
    V --> M
    
    style A fill:#10b981,color:#fff
    style G fill:#f59e0b,color:#000
    style K fill:#8b5cf6,color:#fff
    style M fill:#3b82f6,color:#fff
```

### Product Browsing & Purchase Flow

```mermaid
flowchart TD
    A[User Lands on Homepage] --> B[Browse Products]
    B --> C{Action}
    
    C -->|View Details| D[Product Detail Page]
    C -->|Filter/Search| E[Apply Filters]
    C -->|Add to Wishlist| F[Update Wishlist]
    
    D --> G{Add to Cart?}
    G -->|No| H[Continue Browsing]
    H --> B
    G -->|Yes| I[Add to Cart]
    
    E --> B
    F --> B
    
    I --> J[Update Cart Count]
    J --> K{More Shopping?}
    K -->|Yes| H
    K -->|No| L[View Cart]
    
    L --> M{Proceed to Checkout?}
    M -->|No| N[Update Quantities]
    N --> L
    M -->|Yes| O{Logged In?}
    
    O -->|No| P[Show Login Modal]
    P --> Q[Login/Register]
    Q --> R[Checkout Page]
    
    O -->|Yes| R
    
    R --> S[Enter Shipping Info]
    S --> T[Select Payment Method]
    T --> U[Review Order]
    U --> V[Place Order]
    
    V --> W[Create Order in DB]
    W --> X[Clear Cart]
    X --> Y[Send Confirmation Email]
    Y --> Z[Show Order Confirmation]
    
    style A fill:#10b981,color:#fff
    style I fill:#3b82f6,color:#fff
    style V fill:#f59e0b,color:#000
    style W fill:#8b5cf6,color:#fff
    style Y fill:#ef4444,color:#fff
```

### Order Processing & Fulfillment Flow

```mermaid
stateDiagram-v2
    [*] --> pending: Order Created
    
    pending --> confirmed: Payment Verified
    pending --> cancelled: Payment Failed
    
    confirmed --> processing: Admin Accepted
    confirmed --> cancelled: Admin Rejected
    
    processing --> shipped: Dispatched
    processing --> cancelled: Out of Stock
    
    shipped --> delivered: Successfully Delivered
    shipped --> failed: Delivery Failed
    
    failed --> shipped: Retry Delivery
    failed --> cancelled: Customer Cancelled
    
    delivered --> return_requested: Customer Requested
    
    return_requested --> return_approved: Admin Approved
    return_requested --> return_rejected: Admin Rejected
    
    return_approved --> refund_processing: Pickup Completed
    refund_processing --> refunded: Refund Issued
    
    return_rejected --> delivered: Request Denied
    
    delivered --> [*]: Order Complete
    cancelled --> [*]: Order Cancelled
    refunded --> [*]: Order Refunded
```

### Return Request Workflow

```mermaid
sequenceDiagram
    participant C as Customer
    participant F as Frontend
    participant A as API
    participant D as Database
    participant E as Email
    participant Admin
    
    C->>F: Navigate to Orders
    F->>A: GET /api/orders
    A->>D: Fetch User Orders
    D-->>A: Orders with status "delivered"
    A-->>F: Order List
    F-->>C: Show Orders with Return Button
    
    C->>F: Click "Request Return"
    F->>F: Show Return Modal
    C->>F: Enter Return Reason
    F->>A: POST /api/orders/:id/return
    
    A->>D: Update Order with returnRequest
    D-->>A: Order Updated
    A->>E: Notify Admin
    E-->>Admin: 📧 Return Request Email
    A-->>F: Success Response
    F-->>C: Show Success Toast
    
    Admin->>Admin: Review Return Request
    
    alt Approve Return
        Admin->>A: PUT /api/admin/orders/:id/return
        Note over A: action: "approve"
        A->>D: Update returnRequest.status
        D-->>A: Updated
        A->>E: Notify Customer
        E-->>C: 📧 Return Approved Email
    else Reject Return
        Admin->>A: PUT /api/admin/orders/:id/return
        Note over A: action: "reject"
        A->>D: Update returnRequest.status
        D-->>A: Updated
        A->>E: Notify Customer
        E-->>C: 📧 Return Rejected Email
    end
```

---

## 🔐 Security Architecture

### Authentication & Authorization Flow

```mermaid
graph TB
    A[Client Request] --> B{Requires Auth?}
    B -->|No| C[Public Route]
    B -->|Yes| D[Check Authorization Header]
    
    D --> E{Token Present?}
    E -->|No| F[401 Unauthorized]
    E -->|Yes| G[Verify JWT Signature]
    
    G --> H{Valid Token?}
    H -->|No| I[401 Invalid Token]
    H -->|Yes| J{Token Expired?}
    
    J -->|Yes| K[401 Token Expired]
    J -->|No| L[Decode Token Payload]
    
    L --> M[Extract User ID]
    M --> N[Query Database]
    N --> O{User Exists?}
    
    O -->|No| P[401 User Not Found]
    O -->|Yes| Q{User Active?}
    
    Q -->|No| R[403 Account Disabled]
    Q -->|Yes| S{Admin Required?}
    
    S -->|No| T[Attach User to Request]
    S -->|Yes| U{Is Admin?}
    
    U -->|No| V[403 Forbidden]
    U -->|Yes| W{Super Admin Required?}
    
    W -->|No| T
    W -->|Yes| X{Priority = 1?}
    
    X -->|No| Y[403 Insufficient Permission]
    X -->|Yes| T
    
    T --> Z[Proceed to Controller]
    C --> Z
    
    style A fill:#10b981,color:#fff
    style F fill:#ef4444,color:#fff
    style I fill:#ef4444,color:#fff
    style K fill:#ef4444,color:#fff
    style P fill:#ef4444,color:#fff
    style R fill:#f59e0b,color:#000
    style V fill:#f59e0b,color:#000
    style Y fill:#f59e0b,color:#000
    style Z fill:#3b82f6,color:#fff
```

### Password Security Flow

```mermaid
flowchart LR
    A[Plain Password] --> B[bcrypt.hash]
    B --> C{Salt Rounds = 10}
    C --> D[Generate Salt]
    D --> E[Hash Password]
    E --> F[Hashed Password]
    F --> G[(Store in Database)]
    
    H[Login Attempt] --> I[Retrieve Hash from DB]
    I --> J[bcrypt.compare]
    J --> K{Password + Hash}
    K --> L{Match?}
    L -->|Yes| M[Grant Access]
    L -->|No| N[Deny Access]
    
    style A fill:#10b981,color:#fff
    style B fill:#f59e0b,color:#000
    style F fill:#8b5cf6,color:#fff
    style G fill:#ef4444,color:#fff
    style M fill:#10b981,color:#fff
    style N fill:#ef4444,color:#fff
```

### JWT Token Structure

```
Header
{
  "alg": "HS256",
  "typ": "JWT"
}

Payload
{
  "id": "user123",
  "email": "user@example.com",
  "role": "customer",
  "iat": 1704970800,
  "exp": 1705575600
}

Signature
HMACSHA256(
  base64UrlEncode(header) + "." +
  base64UrlEncode(payload),
  secret
)
```

---

## 🚀 Deployment Architecture

### Production Deployment Diagram

```mermaid
graph TB
    subgraph "CDN Layer"
        CDN[CloudFront / Cloudflare CDN]
    end
    
    subgraph "Load Balancer"
        LB[Nginx Load Balancer]
    end
    
    subgraph "Application Servers"
        APP1[Node.js Instance 1]
        APP2[Node.js Instance 2]
        APP3[Node.js Instance 3]
    end
    
    subgraph "Static Assets"
        S3[AWS S3 / Static Server]
    end
    
    subgraph "Database Cluster"
        PRIMARY[(MongoDB Primary)]
        SECONDARY1[(MongoDB Secondary 1)]
        SECONDARY2[(MongoDB Secondary 2)]
    end
    
    subgraph "External Services"
        EMAIL[SendGrid Email]
        PAYMENT[Payment Gateway]
        MONITORING[Monitoring & Logs]
    end
    
    CDN --> LB
    LB --> APP1
    LB --> APP2
    LB --> APP3
    
    APP1 --> PRIMARY
    APP2 --> PRIMARY
    APP3 --> PRIMARY
    
    PRIMARY --> SECONDARY1
    PRIMARY --> SECONDARY2
    
    APP1 --> EMAIL
    APP2 --> PAYMENT
    APP3 --> MONITORING
    
    CDN --> S3
    
    style CDN fill:#10b981,color:#fff
    style LB fill:#3b82f6,color:#fff
    style PRIMARY fill:#8b5cf6,color:#fff
    style EMAIL fill:#f59e0b,color:#000
```

### Docker Container Architecture

```yaml
version: '3.8'

services:
  # Frontend Customer Store
  frontend:
    image: nutrinuts/frontend:latest
    ports:
      - "80:80"
    environment:
      - VITE_API_URL=http://backend:5001
    depends_on:
      - backend
    networks:
      - nutrinuts-network

  # Admin Dashboard
  admin:
    image: nutrinuts/admin:latest
    ports:
      - "8091:80"
    environment:
      - VITE_API_URL=http://backend:5001
    depends_on:
      - backend
    networks:
      - nutrinuts-network

  # Backend API
  backend:
    image: nutrinuts/backend:latest
    ports:
      - "5001:5001"
    environment:
      - DATABASE=mongodb://mongodb:27017/ecommerce
      - JWT_SECRET=${JWT_SECRET}
      - SENDGRID_API_KEY=${SENDGRID_API_KEY}
    depends_on:
      - mongodb
    networks:
      - nutrinuts-network
    volumes:
      - uploads:/app/images

  # MongoDB Database
  mongodb:
    image: mongo:7.0
    ports:
      - "27017:27017"
    volumes:
      - mongodb-data:/data/db
    networks:
      - nutrinuts-network

  # Redis Cache (Optional)
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    networks:
      - nutrinuts-network

networks:
  nutrinuts-network:
    driver: bridge

volumes:
  mongodb-data:
  uploads:
```

---

## 📈 Scalability Patterns

### Horizontal Scaling Strategy

```mermaid
graph TB
    A[Traffic Spike] --> B[Load Balancer]
    
    B --> C[Auto Scaling Group]
    
    C --> D[Instance 1<br/>Active]
    C --> E[Instance 2<br/>Active]
    C --> F[Instance 3<br/>Standby]
    C --> G[Instance 4<br/>On-Demand]
    
    D --> H[(Read Replica 1)]
    E --> I[(Read Replica 2)]
    F --> J[(Primary DB)]
    G --> J
    
    J --> K[Automated Backups]
    
    style A fill:#ef4444,color:#fff
    style B fill:#f59e0b,color:#000
    style C fill:#10b981,color:#fff
    style J fill:#8b5cf6,color:#fff
```

### Caching Strategy

```mermaid
graph LR
    A[Client Request] --> B{Cache Hit?}
    B -->|Yes| C[Return Cached Data]
    B -->|No| D[Query Database]
    
    D --> E[Process Data]
    E --> F[Store in Cache]
    F --> G[Return Data]
    
    C --> H[Client]
    G --> H
    
    subgraph "Cache Layers"
        L1[Browser Cache<br/>Static Assets]
        L2[CDN Cache<br/>Images, CSS, JS]
        L3[Redis Cache<br/>API Responses]
        L4[Database Query Cache]
    end
    
    style B fill:#f59e0b,color:#000
    style C fill:#10b981,color:#fff
    style D fill:#8b5cf6,color:#fff
```

---

## 🔧 Design Patterns Used

### Repository Pattern

```typescript
// Product Repository Pattern
class ProductRepository {
  async findAll(filter, options) {
    return await Product.find(filter)
      .limit(options.limit)
      .skip(options.skip)
      .sort(options.sort);
  }
  
  async findById(id) {
    return await Product.findById(id);
  }
  
  async create(data) {
    return await Product.create(data);
  }
  
  async update(id, data) {
    return await Product.findByIdAndUpdate(id, data, { new: true });
  }
  
  async delete(id) {
    return await Product.findByIdAndDelete(id);
  }
}
```

### Service Layer Pattern

```typescript
// Order Service Pattern
class OrderService {
  constructor(orderRepository, emailService, inventoryService) {
    this.orderRepo = orderRepository;
    this.emailService = emailService;
    this.inventoryService = inventoryService;
  }
  
  async createOrder(orderData) {
    // 1. Validate inventory
    await this.inventoryService.checkStock(orderData.items);
    
    // 2. Create order
    const order = await this.orderRepo.create(orderData);
    
    // 3. Update inventory
    await this.inventoryService.decrementStock(orderData.items);
    
    // 4. Send confirmation email
    await this.emailService.sendOrderConfirmation(order);
    
    return order;
  }
}
```

### Middleware Pattern

```javascript
// Authentication Middleware Chain
app.use('/api/admin/*', [
  authMiddleware.verifyToken,
  authMiddleware.checkAdmin,
  authMiddleware.checkPermissions
]);
```

---

<div align="center">

**Architecture Documentation**

[📖 Back to Main Docs](../README.md) • [🌐 API Reference](API_REFERENCE.md) • [🗄️ Database Schema](01_Project_Overview.md#database-models)

---

*Last Updated: January 11, 2026*

</div>
