# 🌐 API Reference - Complete Endpoint Documentation

<div align="center">

![API](https://img.shields.io/badge/API-REST-blue)
![Auth](https://img.shields.io/badge/Auth-JWT-green)
![Status](https://img.shields.io/badge/Status-Active-success)

**NutriNuts E-Commerce Platform API v1.0**

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Authentication](#-authentication)
- [Request/Response Format](#-requestresponse-format)
- [User & Authentication APIs](#-user--authentication-apis)
- [Product APIs](#-product-apis)
- [Cart & Wishlist APIs](#-cart--wishlist-apis)
- [Order APIs](#-order-apis)
- [Admin APIs](#-admin-apis)
- [Site Configuration APIs](#-site-configuration-apis)
- [Error Handling](#-error-handling)
- [Rate Limiting](#-rate-limiting)

---

## 🎯 Overview

### Base URLs

| Environment | URL | Description |
|-------------|-----|-------------|
| **Development** | `http://localhost:5001` | Local development server |
| **Production** | `https://api.nutrinuts.com` | Production API endpoint |

### API Versioning

Current Version: **v1.0**  
All endpoints are prefixed with `/api`

### Response Codes

```mermaid
graph LR
    A[API Request] -->|Success| B[2xx Success]
    A -->|Client Error| C[4xx Client Error]
    A -->|Server Error| D[5xx Server Error]
    
    B --> B1[200 OK]
    B --> B2[201 Created]
    
    C --> C1[400 Bad Request]
    C --> C2[401 Unauthorized]
    C --> C3[403 Forbidden]
    C --> C4[404 Not Found]
    
    D --> D1[500 Internal Error]
    D --> D2[503 Service Unavailable]
    
    style B fill:#10b981,color:#fff
    style C fill:#f59e0b,color:#000
    style D fill:#ef4444,color:#fff
```

---

## 🔐 Authentication

### JWT Token System

```mermaid
sequenceDiagram
    participant Client
    participant API
    participant Database
    
    Client->>API: POST /api/auth/login<br/>{email, password}
    API->>Database: Verify Credentials
    Database-->>API: User Document
    API->>API: Generate JWT Token
    API-->>Client: {token, user}<br/>Set-Cookie: token
    
    Note over Client: Store token in localStorage
    
    Client->>API: GET /api/orders<br/>Authorization: Bearer <token>
    API->>API: Verify JWT
    API->>Database: Fetch Orders
    Database-->>API: Order Documents
    API-->>Client: Order Data
```

### Authorization Header Format

```http
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### Token Expiration

| Token Type | Expiration | Renewable |
|------------|-----------|-----------|
| **User Token** | 7 days | ✓ Yes |
| **Admin Token** | 7 days | ✓ Yes |
| **Reset Token** | 10 minutes | ✗ No |

---

## 📦 Request/Response Format

### Standard Response Structure

```json
{
  "success": true,
  "data": {
    // Response payload
  },
  "message": "Operation successful",
  "timestamp": "2026-01-11T10:30:00.000Z"
}
```

### Error Response Structure

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input data",
    "details": [
      {
        "field": "email",
        "message": "Invalid email format"
      }
    ]
  },
  "timestamp": "2026-01-11T10:30:00.000Z"
}
```

---

## 👤 User & Authentication APIs

### Authentication Endpoints

<table>
<tr>
<th width="25%">Endpoint</th>
<th width="15%">Method</th>
<th width="15%">Auth</th>
<th width="45%">Description</th>
</tr>

<tr>
<td><code>/api/auth/register</code></td>
<td><span style="color: #10b981">POST</span></td>
<td>Public</td>
<td>Register new customer account</td>
</tr>

<tr>
<td><code>/api/auth/login</code></td>
<td><span style="color: #10b981">POST</span></td>
<td>Public</td>
<td>User login with email/password</td>
</tr>

<tr>
<td><code>/api/auth/logout</code></td>
<td><span style="color: #10b981">POST</span></td>
<td>Required</td>
<td>Logout and invalidate token</td>
</tr>

<tr>
<td><code>/api/auth/me</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Required</td>
<td>Get current user profile</td>
</tr>

<tr>
<td><code>/api/auth/update-profile</code></td>
<td><span style="color: #f59e0b">PUT</span></td>
<td>Required</td>
<td>Update user profile information</td>
</tr>

<tr>
<td><code>/api/auth/forgot-password</code></td>
<td><span style="color: #10b981">POST</span></td>
<td>Public</td>
<td>Request password reset email</td>
</tr>

<tr>
<td><code>/api/auth/reset-password</code></td>
<td><span style="color: #f59e0b">PUT</span></td>
<td>Token</td>
<td>Reset password with token</td>
</tr>

<tr>
<td><code>/api/auth/verify-email</code></td>
<td><span style="color: #10b981">POST</span></td>
<td>Token</td>
<td>Verify email with OTP</td>
</tr>
</table>

### Register User

```http
POST /api/auth/register
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "SecurePass123!",
  "phone": "+1234567890"
}
```

**Response (201 Created):**

```json
{
  "success": true,
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "_id": "677e1a2b3c4d5e6f7g8h9i0j",
      "name": "John Doe",
      "email": "john@example.com",
      "phone": "+1234567890",
      "role": "customer",
      "isEmailVerified": false,
      "createdAt": "2026-01-11T10:30:00.000Z"
    }
  }
}
```

### Login User

```http
POST /api/auth/login
Content-Type: application/json

{
  "email": "john@example.com",
  "password": "SecurePass123!"
}
```

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "user": {
      "_id": "677e1a2b3c4d5e6f7g8h9i0j",
      "name": "John Doe",
      "email": "john@example.com",
      "role": "customer"
    }
  }
}
```

### Get Current User

```http
GET /api/auth/me
Authorization: Bearer <token>
```

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "_id": "677e1a2b3c4d5e6f7g8h9i0j",
    "name": "John Doe",
    "email": "john@example.com",
    "phone": "+1234567890",
    "addresses": [
      {
        "_id": "addr123",
        "type": "home",
        "street": "123 Main St",
        "city": "New York",
        "state": "NY",
        "zipCode": "10001",
        "country": "USA"
      }
    ],
    "createdAt": "2026-01-11T10:30:00.000Z"
  }
}
```

---

## 📦 Product APIs

### Product Endpoints

<table>
<tr>
<th width="25%">Endpoint</th>
<th width="15%">Method</th>
<th width="15%">Auth</th>
<th width="45%">Description</th>
</tr>

<tr>
<td><code>/api/products</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Public</td>
<td>Get all products with filtering</td>
</tr>

<tr>
<td><code>/api/products/:id</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Public</td>
<td>Get single product by ID</td>
</tr>

<tr>
<td><code>/api/products</code></td>
<td><span style="color: #10b981">POST</span></td>
<td>Admin</td>
<td>Create new product</td>
</tr>

<tr>
<td><code>/api/products/:id</code></td>
<td><span style="color: #f59e0b">PUT</span></td>
<td>Admin</td>
<td>Update product details</td>
</tr>

<tr>
<td><code>/api/products/:id</code></td>
<td><span style="color: #ef4444">DELETE</span></td>
<td>Admin</td>
<td>Delete product</td>
</tr>

<tr>
<td><code>/api/products/search</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Public</td>
<td>Search products by query</td>
</tr>

<tr>
<td><code>/api/products/category/:category</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Public</td>
<td>Get products by category</td>
</tr>

<tr>
<td><code>/api/products/featured</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Public</td>
<td>Get featured products</td>
</tr>
</table>

### Get All Products

```http
GET /api/products?page=1&limit=20&category=almonds&sort=-createdAt
```

**Query Parameters:**

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `page` | Number | 1 | Page number for pagination |
| `limit` | Number | 20 | Items per page |
| `category` | String | - | Filter by category |
| `minPrice` | Number | - | Minimum price filter |
| `maxPrice` | Number | - | Maximum price filter |
| `sort` | String | `-createdAt` | Sort field (`price`, `-price`, `createdAt`) |
| `search` | String | - | Search query for title/description |

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "products": [
      {
        "_id": "prod123",
        "title": "Premium California Almonds",
        "description": "Hand-picked premium quality almonds",
        "price": 899,
        "discountPrice": 799,
        "category": "almonds",
        "stock": 150,
        "images": [
          "/api/images/almond-1.png",
          "/api/images/almond-2.png"
        ],
        "specifications": {
          "weight": "500g",
          "origin": "California, USA",
          "quality": "Premium Grade A"
        },
        "rating": 4.5,
        "reviewCount": 128,
        "featured": true,
        "createdAt": "2026-01-01T00:00:00.000Z"
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 5,
      "totalProducts": 98,
      "hasNextPage": true,
      "hasPrevPage": false
    }
  }
}
```

### Get Single Product

```http
GET /api/products/prod123
```

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "_id": "prod123",
    "title": "Premium California Almonds",
    "description": "Hand-picked premium quality almonds from California farms...",
    "price": 899,
    "discountPrice": 799,
    "category": "almonds",
    "stock": 150,
    "images": [
      "/api/images/almond-1.png",
      "/api/images/almond-2.png",
      "/api/images/almond-3.png"
    ],
    "specifications": {
      "weight": "500g",
      "origin": "California, USA",
      "quality": "Premium Grade A",
      "nutritionalInfo": {
        "calories": 575,
        "protein": 21,
        "fat": 50,
        "carbs": 22
      }
    },
    "rating": 4.5,
    "reviewCount": 128,
    "reviews": [
      {
        "user": "John D.",
        "rating": 5,
        "comment": "Excellent quality!",
        "date": "2026-01-10T00:00:00.000Z"
      }
    ],
    "relatedProducts": ["prod124", "prod125"],
    "featured": true,
    "createdAt": "2026-01-01T00:00:00.000Z",
    "updatedAt": "2026-01-10T00:00:00.000Z"
  }
}
```

---

## 🛒 Cart & Wishlist APIs

### Cart Endpoints

<table>
<tr>
<th width="30%">Endpoint</th>
<th width="15%">Method</th>
<th width="15%">Auth</th>
<th width="40%">Description</th>
</tr>

<tr>
<td><code>/api/cart</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Required</td>
<td>Get user's cart</td>
</tr>

<tr>
<td><code>/api/cart/add</code></td>
<td><span style="color: #10b981">POST</span></td>
<td>Required</td>
<td>Add item to cart</td>
</tr>

<tr>
<td><code>/api/cart/update</code></td>
<td><span style="color: #f59e0b">PUT</span></td>
<td>Required</td>
<td>Update cart item quantity</td>
</tr>

<tr>
<td><code>/api/cart/remove/:productId</code></td>
<td><span style="color: #ef4444">DELETE</span></td>
<td>Required</td>
<td>Remove item from cart</td>
</tr>

<tr>
<td><code>/api/cart/clear</code></td>
<td><span style="color: #ef4444">DELETE</span></td>
<td>Required</td>
<td>Clear entire cart</td>
</tr>
</table>

### Wishlist Endpoints

<table>
<tr>
<th width="30%">Endpoint</th>
<th width="15%">Method</th>
<th width="15%">Auth</th>
<th width="40%">Description</th>
</tr>

<tr>
<td><code>/api/wishlist</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Required</td>
<td>Get user's wishlist</td>
</tr>

<tr>
<td><code>/api/wishlist/add</code></td>
<td><span style="color: #10b981">POST</span></td>
<td>Required</td>
<td>Add item to wishlist</td>
</tr>

<tr>
<td><code>/api/wishlist/remove/:productId</code></td>
<td><span style="color: #ef4444">DELETE</span></td>
<td>Required</td>
<td>Remove item from wishlist</td>
</tr>
</table>

### Add to Cart

```http
POST /api/cart/add
Authorization: Bearer <token>
Content-Type: application/json

{
  "productId": "prod123",
  "quantity": 2
}
```

**Response (200 OK):**

```json
{
  "success": true,
  "data": {
    "cart": {
      "_id": "cart123",
      "user": "user123",
      "items": [
        {
          "product": {
            "_id": "prod123",
            "title": "Premium California Almonds",
            "price": 799,
            "images": ["/api/images/almond-1.png"]
          },
          "quantity": 2,
          "subtotal": 1598
        }
      ],
      "total": 1598,
      "itemCount": 1
    }
  },
  "message": "Item added to cart"
}
```

---

## 📋 Order APIs

### Order Endpoints

<table>
<tr>
<th width="30%">Endpoint</th>
<th width="15%">Method</th>
<th width="15%">Auth</th>
<th width="40%">Description</th>
</tr>

<tr>
<td><code>/api/orders</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Required</td>
<td>Get user's orders</td>
</tr>

<tr>
<td><code>/api/orders/:id</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Required</td>
<td>Get single order details</td>
</tr>

<tr>
<td><code>/api/orders</code></td>
<td><span style="color: #10b981">POST</span></td>
<td>Required</td>
<td>Create new order</td>
</tr>

<tr>
<td><code>/api/orders/:id/cancel</code></td>
<td><span style="color: #f59e0b">PUT</span></td>
<td>Required</td>
<td>Cancel order</td>
</tr>

<tr>
<td><code>/api/orders/:id/return</code></td>
<td><span style="color: #10b981">POST</span></td>
<td>Required</td>
<td>Request product return</td>
</tr>

<tr>
<td><code>/api/orders/:id/track</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Public</td>
<td>Track order by ID</td>
</tr>
</table>

### Order Status Flow

```mermaid
stateDiagram-v2
    [*] --> pending: Order Created
    pending --> confirmed: Payment Verified
    confirmed --> processing: Order Prepared
    processing --> shipped: Out for Delivery
    shipped --> delivered: Successfully Delivered
    
    pending --> cancelled: Customer Cancelled
    confirmed --> cancelled: Admin Cancelled
    
    delivered --> return_requested: Return Request
    return_requested --> return_approved: Admin Approved
    return_requested --> return_rejected: Admin Rejected
    return_approved --> refunded: Refund Processed
    
    delivered --> [*]
    cancelled --> [*]
    refunded --> [*]
    return_rejected --> delivered
```

### Create Order

```http
POST /api/orders
Authorization: Bearer <token>
Content-Type: application/json

{
  "items": [
    {
      "product": "prod123",
      "quantity": 2,
      "price": 799
    }
  ],
  "shippingAddress": {
    "street": "123 Main St",
    "city": "New York",
    "state": "NY",
    "zipCode": "10001",
    "country": "USA",
    "phone": "+1234567890"
  },
  "paymentMethod": "UPI",
  "paymentDetails": {
    "upiId": "user@upi"
  }
}
```

**Response (201 Created):**

```json
{
  "success": true,
  "data": {
    "order": {
      "_id": "order123",
      "orderNumber": "ORD-2026-001",
      "user": "user123",
      "items": [
        {
          "product": {
            "_id": "prod123",
            "title": "Premium California Almonds",
            "images": ["/api/images/almond-1.png"]
          },
          "quantity": 2,
          "price": 799,
          "subtotal": 1598
        }
      ],
      "subtotal": 1598,
      "shipping": 50,
      "tax": 160,
      "total": 1808,
      "status": "pending",
      "paymentStatus": "pending",
      "paymentMethod": "UPI",
      "shippingAddress": {
        "street": "123 Main St",
        "city": "New York",
        "state": "NY",
        "zipCode": "10001",
        "country": "USA"
      },
      "createdAt": "2026-01-11T10:30:00.000Z"
    }
  },
  "message": "Order placed successfully"
}
```

---

## ⚙️ Admin APIs

### Admin Authentication

<table>
<tr>
<th width="35%">Endpoint</th>
<th width="15%">Method</th>
<th width="15%">Auth</th>
<th width="35%">Description</th>
</tr>

<tr>
<td><code>/api/admin-auth/login</code></td>
<td><span style="color: #10b981">POST</span></td>
<td>Public</td>
<td>Admin login</td>
</tr>

<tr>
<td><code>/api/admin-auth/me</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Admin</td>
<td>Get current admin</td>
</tr>

<tr>
<td><code>/api/admin-auth/create</code></td>
<td><span style="color: #10b981">POST</span></td>
<td>Super Admin</td>
<td>Create new admin</td>
</tr>

<tr>
<td><code>/api/admin-auth/list</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Super Admin</td>
<td>List all admins</td>
</tr>
</table>

### Admin Order Management

<table>
<tr>
<th width="35%">Endpoint</th>
<th width="15%">Method</th>
<th width="15%">Auth</th>
<th width="35%">Description</th>
</tr>

<tr>
<td><code>/api/admin/orders</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Admin</td>
<td>Get all orders</td>
</tr>

<tr>
<td><code>/api/admin/orders/:id/status</code></td>
<td><span style="color: #f59e0b">PUT</span></td>
<td>Admin</td>
<td>Update order status</td>
</tr>

<tr>
<td><code>/api/admin/orders/:id/return</code></td>
<td><span style="color: #f59e0b">PUT</span></td>
<td>Admin</td>
<td>Respond to return request</td>
</tr>
</table>

---

## 🎨 Site Configuration APIs

### Configuration Endpoints

<table>
<tr>
<th width="35%">Endpoint</th>
<th width="15%">Method</th>
<th width="15%">Auth</th>
<th width="35%">Description</th>
</tr>

<tr>
<td><code>/api/siteconfig/all</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Public</td>
<td>Get complete site configuration</td>
</tr>

<tr>
<td><code>/api/siteconfig/all</code></td>
<td><span style="color: #f59e0b">PUT</span></td>
<td>Admin</td>
<td>Update site configuration</td>
</tr>

<tr>
<td><code>/api/siteconfig/branding</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Public</td>
<td>Get branding settings</td>
</tr>

<tr>
<td><code>/api/siteconfig/footer</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Public</td>
<td>Get footer configuration</td>
</tr>

<tr>
<td><code>/api/siteconfig/hero</code></td>
<td><span style="color: #3b82f6">GET</span></td>
<td>Public</td>
<td>Get hero carousel</td>
</tr>
</table>

---

## ⚠️ Error Handling

### Error Code Reference

| HTTP Code | Error Code | Description | Solution |
|-----------|------------|-------------|----------|
| 400 | `VALIDATION_ERROR` | Invalid input data | Check request body format |
| 401 | `UNAUTHORIZED` | Missing or invalid token | Login and provide valid token |
| 403 | `FORBIDDEN` | Insufficient permissions | Contact administrator |
| 404 | `NOT_FOUND` | Resource not found | Verify resource ID |
| 409 | `CONFLICT` | Duplicate resource | Use different identifier |
| 422 | `UNPROCESSABLE` | Business logic error | Review business rules |
| 429 | `RATE_LIMIT` | Too many requests | Wait before retrying |
| 500 | `SERVER_ERROR` | Internal server error | Contact support |

### Error Response Example

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "details": [
      {
        "field": "email",
        "message": "Invalid email format",
        "value": "invalid-email"
      },
      {
        "field": "password",
        "message": "Password must be at least 6 characters",
        "value": ""
      }
    ]
  },
  "timestamp": "2026-01-11T10:30:00.000Z"
}
```

---

## 🚦 Rate Limiting

### Rate Limit Policy

| Endpoint Type | Requests | Time Window | Status Code |
|---------------|----------|-------------|-------------|
| **Authentication** | 5 | 15 minutes | 429 |
| **General API** | 100 | 1 minute | 429 |
| **Search** | 30 | 1 minute | 429 |
| **Admin API** | 1000 | 1 minute | 429 |

### Rate Limit Headers

```http
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1704970800
```

---

## 📝 Best Practices

### Request Best Practices

1. **Always include Content-Type header** for POST/PUT requests
2. **Use pagination** for list endpoints
3. **Implement retry logic** with exponential backoff
4. **Cache responses** where appropriate
5. **Handle errors gracefully** with user-friendly messages

### Security Best Practices

1. **Never log or expose tokens** in client-side code
2. **Use HTTPS** in production
3. **Validate input** on both client and server
4. **Implement CSRF protection** for state-changing operations
5. **Monitor for suspicious activity** and implement rate limiting

---

<div align="center">

**Need Help?**

[📧 API Support](mailto:api-support@nutrinuts.com) • [📖 Main Documentation](../README.md) • [🐛 Report Issue](issues)

---

*Last Updated: January 11, 2026*

</div>
