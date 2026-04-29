# 🎨 E-Commerce Platform Style Guide

<div align="center">

![Version](https://img.shields.io/badge/Version-1.0.0-blue)
![Last Updated](https://img.shields.io/badge/Updated-2024-green)
![Framework](https://img.shields.io/badge/Framework-React%20%2B%20Tailwind-61DAFB)

**A comprehensive design system reference for the User Store and Admin Dashboard**

</div>

---

## 📑 Table of Contents

1. [Part 1: User Store (Frontend)](#-part-1-user-store-frontend)
   - [Typography](#typography)
   - [Color System](#color-system)
   - [Spacing System](#spacing-system)
   - [Components](#components)
   - [Responsive Design](#responsive-design)
   - [Animations](#animations)
2. [Part 2: Admin Dashboard](#-part-2-admin-dashboard)
   - [Dark Theme System](#dark-theme-system)
   - [HSL Color Palette](#hsl-color-palette)
   - [UI Components](#ui-components)
   - [Layout Patterns](#layout-patterns)

---

# 🛍️ PART 1: USER STORE (FRONTEND)

## Typography

### Font Family

```css
/* Primary Font: Albert Sans */
font-family: 'Albert Sans', sans-serif;
```

### Font Import
```html
<link href="https://fonts.googleapis.com/css2?family=Albert+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
```

### Type Scale

| Element | Size | Weight | Line Height | Usage |
|---------|------|--------|-------------|-------|
| **Hero Title** | `clamp(32px, 5vw, 64px)` | 700 | 1.1 | Main carousel headlines |
| **Section Title** | `text-2xl` (24px) | 600 | 1.2 | Hot Deals, Featured sections |
| **Product Name** | `16px` | 400 (normal) | 1.4 | Product cards, listings |
| **Price** | `16px` | 600 (semibold) | 1 | Product prices |
| **Body Text** | `text-sm` (14px) | 400 | 1.5 | Descriptions, paragraphs |
| **Small Text** | `text-xs` (12px) | 400 | 1.4 | Badges, captions, labels |
| **Navigation** | `16px` | 500 | 1 | Menu items, links |

### Font Weight Scale

```
┌─────────────────────────────────────────────────────────┐
│  300 (Light)    │ Used for subtle text, descriptions    │
│  400 (Regular)  │ Body text, product names              │
│  500 (Medium)   │ Navigation, buttons                   │
│  600 (Semibold) │ Prices, section titles, emphasis      │
│  700 (Bold)     │ Headlines, CTAs                       │
│  800 (ExtraBold)│ Hero titles, special emphasis         │
└─────────────────────────────────────────────────────────┘
```

---

## Color System

### Primary Colors

| Color Name | HEX | RGB | Usage |
|------------|-----|-----|-------|
| **Black (Primary)** | `#000000` | rgb(0,0,0) | Text, buttons, icons |
| **White** | `#FFFFFF` | rgb(255,255,255) | Backgrounds, text on dark |
| **Announcement Blue** | `#2c3bc5` | rgb(44,59,197) | Announcement bar background |

### Text Colors

```
┌──────────────────────────────────────────────────────────────┐
│                                                              │
│  █████████  #000000    Primary text, headings                │
│  █████████  #374151    text-gray-700 - Secondary text        │
│  █████████  #6B7280    text-gray-500 - Muted text            │
│  █████████  #9CA3AF    text-gray-400 - Placeholder           │
│  █████████  #D1D5DB    text-gray-300 - Disabled text         │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

### Background Colors

| Class | HEX | Usage |
|-------|-----|-------|
| `bg-white` | `#FFFFFF` | Main backgrounds |
| `bg-gray-50` | `#F9FAFB` | Product image backgrounds |
| `bg-gray-100` | `#F3F4F6` | Hover states, cards |
| `bg-black` | `#000000` | Buttons, badges |

### Status Colors

```css
/* Success */
.bg-green-500  { background-color: #22C55E; }
.text-green-600 { color: #16A34A; }

/* Warning */
.bg-yellow-500 { background-color: #EAB308; }
.text-yellow-600 { color: #CA8A04; }

/* Error/Destructive */
.bg-red-500    { background-color: #EF4444; }
.text-red-600  { color: #DC2626; }

/* Info */
.bg-blue-500   { background-color: #3B82F6; }
.text-blue-600 { color: #2563EB; }
```

### Deal Badge Color
```css
/* Hot Deal Badge */
background-color: #EF4444; /* bg-red-500 */
color: #FFFFFF;
```

---

## Spacing System

### Base Unit
```
Base: 4px (0.25rem)
```

### Spacing Scale

| Tailwind | Value | Pixels | Usage |
|----------|-------|--------|-------|
| `p-1` | 0.25rem | 4px | Tight padding (icons) |
| `p-2` | 0.5rem | 8px | Small buttons, badges |
| `p-3` | 0.75rem | 12px | Inputs, small cards |
| `p-4` | 1rem | 16px | Standard card padding |
| `p-6` | 1.5rem | 24px | Section padding |
| `p-8` | 2rem | 32px | Large section spacing |
| `p-12` | 3rem | 48px | Hero sections |
| `p-16` | 4rem | 64px | Major section breaks |

### Gap System for Flex/Grid

```css
gap-2   → 8px    /* Tight element groups */
gap-4   → 16px   /* Standard spacing */
gap-6   → 24px   /* Card grids */
gap-8   → 32px   /* Section spacing */
gap-12  → 48px   /* Major layout gaps */
```

### Container Max Widths

| Container | Max Width | Usage |
|-----------|-----------|-------|
| `max-w-[1600px]` | 1600px | Main content container |
| `max-w-7xl` | 1280px | Standard page content |
| `max-w-4xl` | 896px | Forms, narrow content |
| `max-w-lg` | 512px | Modals, small dialogs |

---

## Components

### Buttons

#### Primary Button (Black)
```tsx
<button className="
  bg-black 
  text-white 
  px-6 py-3 
  rounded-md 
  hover:bg-gray-800 
  transition-colors 
  font-medium
">
  Add to Cart
</button>
```

| Property | Value |
|----------|-------|
| Background | `#000000` |
| Text | `#FFFFFF` |
| Padding | `12px 24px` |
| Border Radius | `6px` |
| Hover | `#1F2937` (gray-800) |
| Transition | `150ms colors` |

#### Secondary Button (Outline)
```tsx
<button className="
  border border-black 
  text-black 
  px-6 py-3 
  rounded-md 
  hover:bg-black hover:text-white 
  transition-colors
">
  Learn More
</button>
```

#### Icon Button
```tsx
<button className="
  p-2 
  hover:bg-gray-100 
  rounded-full 
  transition-colors duration-200
">
  {/* Icon */}
</button>
```

### Product Cards

#### Card Dimensions (Hot Deals)
```css
width: clamp(220px, 20vw, 300px);
height: clamp(400px, 35vw, 480px);  /* with colors */
height: clamp(360px, 32vw, 440px);  /* without colors */
```

#### Card Image Container
```css
height: clamp(240px, 21vw, 288px);
background-color: #F9FAFB; /* gray-50 */
```

#### Card Styling
```tsx
<div className="
  relative 
  transition-transform duration-300 
  hover:scale-[1.02] 
  hover:shadow-lg 
  rounded-lg 
  overflow-hidden 
  bg-[#f8f8f8]
">
```

### Input Fields

```tsx
<input className="
  w-full 
  px-4 py-3 
  border border-gray-300 
  rounded-lg 
  focus:outline-none 
  focus:ring-2 
  focus:ring-black 
  focus:border-transparent
  placeholder:text-gray-400
" />
```

| Property | Value |
|----------|-------|
| Height | `48px` (py-3) |
| Border | `1px solid #D1D5DB` |
| Border Radius | `8px` |
| Focus Ring | `2px black` |
| Padding | `12px 16px` |

### Badges

#### Discount Badge
```tsx
<div className="
  absolute top-2 left-2 z-20 
  bg-red-500 text-white 
  px-3 py-1 
  rounded-md 
  text-sm font-semibold
">
  25% OFF
</div>
```

#### Count Badge (Cart/Wishlist)
```tsx
<span className="
  absolute -top-1 -right-1 
  bg-black text-white 
  text-xs rounded-full 
  h-5 w-5 
  flex items-center justify-center 
  font-bold
">
  3
</span>
```

### Navigation

#### Desktop Nav Link
```tsx
<Link className="
  text-gray-700 
  hover:text-gray-900 
  transition-colors 
  text-base font-medium
">
  Shop
</Link>
```

#### Mobile Nav Item
```tsx
<Link className="
  block 
  py-3 
  text-lg 
  font-medium 
  text-gray-800 
  hover:text-black 
  border-b border-gray-100
">
  Shop
</Link>
```

---

## Responsive Design

### Breakpoints

| Name | Width | Tailwind Class | Usage |
|------|-------|----------------|-------|
| `xs` | 475px | `xs:` | Extra small mobile |
| `sm` | 640px | `sm:` | Mobile landscape |
| `md` | 768px | `md:` | Tablets |
| `lg` | 1024px | `lg:` | Small laptops |
| `filter-hide` | 1010px | `filter-hide:` | Filter sidebar toggle |
| `xl` | 1280px | `xl:` | Desktops |
| `2xl` | 1536px | `2xl:` | Large screens |

### Breakpoint Visualization

```
┌──────────────────────────────────────────────────────────────────────┐
│                                                                      │
│  0px        475px      640px      768px      1024px     1280px      │
│  ├──────────┼──────────┼──────────┼──────────┼──────────┼──────────►│
│  │   xs     │    sm    │    md    │    lg    │    xl    │   2xl    │
│  │  Mobile  │ Mobile L │  Tablet  │  Laptop  │ Desktop  │  Large   │
│  │          │          │          │          │          │          │
└──────────────────────────────────────────────────────────────────────┘
```

### Responsive Patterns

#### Grid Columns
```tsx
<div className="
  grid 
  grid-cols-1 
  sm:grid-cols-2 
  md:grid-cols-3 
  lg:grid-cols-4 
  xl:grid-cols-5
  gap-4 sm:gap-6
">
```

#### Responsive Padding
```tsx
<div className="
  py-6 sm:py-8 md:py-10 lg:py-12 xl:py-16 
  px-3 sm:px-4 md:px-6 lg:px-8 xl:px-12
">
```

#### Responsive Text
```tsx
<h1 className="
  text-xl sm:text-2xl md:text-3xl lg:text-4xl xl:text-5xl
">
```

---

## Animations

### Built-in Animations

#### Spin Slow (Logo/Loading)
```css
@keyframes spin-slow {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}
.animate-spin-slow {
  animation: spin-slow 20s linear infinite;
}
```

#### Marquee (Scrolling Text)
```css
@keyframes marquee {
  0% { transform: translateX(0%); }
  100% { transform: translateX(-50%); }
}
.animate-marquee {
  animation: marquee 20s linear infinite;
}
```

#### Fade In Up (Hero Content)
```css
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
.hero-content-enter {
  animation: fadeInUp 0.7s ease-out forwards;
}
```

### Transition Classes

| Class | Property | Duration |
|-------|----------|----------|
| `transition-colors` | color, background-color, border-color | 150ms |
| `transition-transform` | transform | 150ms |
| `duration-200` | all | 200ms |
| `duration-300` | all | 300ms |

### Hover Effects

#### Scale on Hover
```css
.hover\:scale-\[1\.02\]:hover {
  transform: scale(1.02);
}
```

#### Shadow on Hover
```css
.hover\:shadow-lg:hover {
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 
              0 4px 6px -2px rgba(0, 0, 0, 0.05);
}
```

---

## Hero Carousel Specifications

### Desktop Size
```css
width: 1300px;
height: 740px;
```

### Mobile Size
```css
width: 350px;
height: 500px;
```

### Tablet Size
```css
width: 600px;
height: 600px;
```

### Carousel Indicator
```tsx
<div className="
  w-2 h-2 
  rounded-full 
  transition-all duration-300
  bg-black    /* active */
  bg-gray-300 /* inactive */
">
```

---

# 🔧 PART 2: ADMIN DASHBOARD

## Dark Theme System

### Theme Architecture

The Admin Dashboard uses Tailwind CSS with **HSL (Hue, Saturation, Lightness)** color variables for a cohesive dark theme system.

```css
/* Enable dark mode via class */
darkMode: "class"
```

### CSS Variables Root

```css
:root {
  --background: 0 0% 3.9%;      /* Near black background */
  --foreground: 0 0% 98%;       /* Near white text */
  --card: 0 0% 3.9%;            /* Card background */
  --card-foreground: 0 0% 98%;  /* Card text */
  --popover: 0 0% 3.9%;         /* Popover background */
  --popover-foreground: 0 0% 98%;
  --primary: 0 0% 98%;          /* Primary buttons/elements */
  --primary-foreground: 0 0% 9%;
  --secondary: 0 0% 14.9%;      /* Secondary elements */
  --secondary-foreground: 0 0% 98%;
  --muted: 0 0% 14.9%;          /* Muted backgrounds */
  --muted-foreground: 0 0% 63.9%;
  --accent: 217.2 32.6% 17.5%;  /* Accent color */
  --accent-foreground: 210 40% 98%;
  --destructive: 0 62.8% 30.6%; /* Error/destructive actions */
  --destructive-foreground: 0 0% 98%;
  --border: 217.2 32.6% 17.5%;  /* Border color */
  --input: 217.2 32.6% 17.5%;   /* Input borders */
  --ring: 0 0% 83.1%;           /* Focus ring */
  --radius: 0.375rem;           /* Base border radius */
}
```

---

## HSL Color Palette

### Background Colors

| Variable | HSL Value | Hex Equivalent | Usage |
|----------|-----------|----------------|-------|
| `--background` | `0 0% 3.9%` | `#0A0A0A` | Main background |
| `--card` | `0 0% 3.9%` | `#0A0A0A` | Card backgrounds |
| `--muted` | `0 0% 14.9%` | `#262626` | Muted sections |
| `--secondary` | `0 0% 14.9%` | `#262626` | Secondary elements |

### Color Visualization

```
┌─────────────────────────────────────────────────────────────────────┐
│  ADMIN DARK THEME COLOR SCALE                                       │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  Background (0 0% 3.9%)    ████████████████  Near Black #0A0A0A    │
│  Secondary (0 0% 14.9%)    ████████████████  Dark Gray  #262626    │
│  Border (217.2 32.6% 17.5%)████████████████  Navy Gray  #1E293B    │
│  Muted FG (0 0% 63.9%)     ████████████████  Medium Gray#A3A3A3    │
│  Ring (0 0% 83.1%)         ████████████████  Light Gray #D4D4D4    │
│  Foreground (0 0% 98%)     ████████████████  Near White #FAFAFA    │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### Text Colors

| Type | Variable | HSL | Usage |
|------|----------|-----|-------|
| Primary | `--foreground` | `0 0% 98%` | Main text |
| Muted | `--muted-foreground` | `0 0% 63.9%` | Secondary text |
| Card Title | `--card-foreground` | `0 0% 98%` | Card headings |
| Accent | `--accent-foreground` | `210 40% 98%` | Accent text |

### Status Colors

| Status | Variable | HSL | Usage |
|--------|----------|-----|-------|
| Destructive | `--destructive` | `0 62.8% 30.6%` | Delete, errors |
| Success | - | `142 76% 36%` | Confirmed actions |
| Warning | - | `38 92% 50%` | Warnings |
| Info | `--accent` | `217.2 32.6% 17.5%` | Information |

---

## Border Radius System

### CSS Variable
```css
--radius: 0.375rem; /* 6px */
```

### Radius Scale

| Size | Calculation | Value | Usage |
|------|-------------|-------|-------|
| `radius-lg` | `var(--radius)` | 6px | Cards, large containers |
| `radius-md` | `calc(var(--radius) - 2px)` | 4px | Buttons, inputs |
| `radius-sm` | `calc(var(--radius) - 4px)` | 2px | Badges, small elements |
| `radius-full` | `9999px` | ∞ | Avatars, pills |

---

## UI Components

### Button Component

The button uses Class Variance Authority (CVA) for variant management.

#### Button Variants

```tsx
// Base styles applied to all buttons
"inline-flex items-center justify-center whitespace-nowrap 
 rounded-md text-sm font-medium ring-offset-background 
 transition-colors focus-visible:outline-none focus-visible:ring-2 
 focus-visible:ring-ring focus-visible:ring-offset-2 
 disabled:pointer-events-none disabled:opacity-50"
```

| Variant | Styles | Usage |
|---------|--------|-------|
| **default** | `bg-primary text-primary-foreground hover:bg-primary/90` | Primary actions |
| **destructive** | `bg-destructive text-destructive-foreground hover:bg-destructive/90` | Delete, dangerous |
| **outline** | `border border-input bg-background hover:bg-accent hover:text-accent-foreground` | Secondary actions |
| **secondary** | `bg-secondary text-secondary-foreground hover:bg-secondary/80` | Less prominent |
| **ghost** | `hover:bg-accent hover:text-accent-foreground` | Subtle interactions |
| **link** | `text-primary underline-offset-4 hover:underline` | Text links |

#### Button Sizes

| Size | Styles | Height | Padding |
|------|--------|--------|---------|
| **default** | `h-10 px-4 py-2` | 40px | 16px 8px |
| **sm** | `h-9 rounded-md px-3` | 36px | 12px |
| **lg** | `h-11 rounded-md px-8` | 44px | 32px |
| **icon** | `h-10 w-10` | 40px | - |

### Card Component

```tsx
// Card base
"rounded-lg border bg-card text-card-foreground shadow-sm"

// Card Header
"flex flex-col space-y-1.5 p-6"

// Card Title
"text-2xl font-semibold leading-none tracking-tight"

// Card Description
"text-sm text-muted-foreground"

// Card Content
"p-6 pt-0"

// Card Footer
"flex items-center p-6 pt-0"
```

### Input Component

```tsx
<Input className="
  flex h-10 w-full rounded-md 
  border border-input 
  bg-background 
  px-3 py-2 
  text-sm 
  ring-offset-background 
  file:border-0 file:bg-transparent file:text-sm file:font-medium 
  placeholder:text-muted-foreground 
  focus-visible:outline-none focus-visible:ring-2 
  focus-visible:ring-ring focus-visible:ring-offset-2 
  disabled:cursor-not-allowed disabled:opacity-50
" />
```

### Badge Component

#### Badge Variants

| Variant | Styles |
|---------|--------|
| **default** | `border-transparent bg-primary text-primary-foreground hover:bg-primary/80` |
| **secondary** | `border-transparent bg-secondary text-secondary-foreground hover:bg-secondary/80` |
| **destructive** | `border-transparent bg-destructive text-destructive-foreground hover:bg-destructive/80` |
| **outline** | `text-foreground` |

```tsx
// Base badge styles
"inline-flex items-center rounded-full border 
 px-2.5 py-0.5 text-xs font-semibold 
 transition-colors focus:outline-none 
 focus:ring-2 focus:ring-ring focus:ring-offset-2"
```

---

## Layout Patterns

### Container Settings

```tsx
container: {
  center: true,
  padding: "2rem",      /* 32px padding */
  screens: {
    "2xl": "1400px",    /* max-width on 2xl */
  },
}
```

### Sidebar Navigation Pattern

```tsx
// Sidebar wrapper
<aside className="
  w-64 
  bg-background 
  border-r border-border 
  h-screen 
  fixed left-0 top-0
">

// Nav item
<button className="
  w-full 
  flex items-center gap-3 
  px-4 py-3 
  text-muted-foreground 
  hover:bg-accent hover:text-accent-foreground 
  rounded-md 
  transition-colors
">
```

### Dashboard Grid

```tsx
<div className="
  grid 
  grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 
  gap-4 lg:gap-6
">
  {/* Stat Cards */}
</div>
```

### Table Pattern

```tsx
// Table container
<div className="rounded-md border border-border overflow-hidden">
  
  // Header row
  <div className="bg-muted px-4 py-3 text-sm font-medium">
  
  // Data row
  <div className="px-4 py-4 border-t border-border hover:bg-accent/50">
</div>
```

---

## Typography (Admin)

### Font Family

```css
fontFamily: {
  sans: ["Albert Sans", "ui-sans-serif", "system-ui", "sans-serif"]
}
```

### Type Scale

| Element | Tailwind Class | Size | Usage |
|---------|----------------|------|-------|
| Page Title | `text-3xl font-bold` | 30px | Page headings |
| Section Title | `text-xl font-semibold` | 20px | Section headers |
| Card Title | `text-2xl font-semibold` | 24px | Card headings |
| Body | `text-sm` | 14px | Default text |
| Label | `text-sm font-medium` | 14px | Form labels |
| Helper | `text-xs` | 12px | Descriptions |

---

## Admin Animation System

### Accordion Animation

```css
@keyframes accordion-down {
  from {
    height: 0;
  }
  to {
    height: var(--radix-accordion-content-height);
  }
}

@keyframes accordion-up {
  from {
    height: var(--radix-accordion-content-height);
  }
  to {
    height: 0;
  }
}

.animate-accordion-down {
  animation: accordion-down 0.2s ease-out;
}

.animate-accordion-up {
  animation: accordion-up 0.2s ease-out;
}
```

---

## Icon System (Admin)

### Icon Library
**Lucide React** - Consistent icon set

### Common Icons Used

| Icon | Import | Usage |
|------|--------|-------|
| Package | `Package` | Products |
| ShoppingCart | `ShoppingCart` | Orders |
| Users | `Users` | Customers |
| BarChart3 | `BarChart3` | Analytics |
| Settings | `Settings` | Configuration |
| Plus | `Plus` | Add actions |
| Edit | `Edit` | Edit actions |
| Trash2 | `Trash2` | Delete actions |
| Search | `Search` | Search bars |
| Filter | `Filter` | Filter panels |
| Eye | `Eye` | View actions |
| Download | `Download` | Export actions |
| ChevronLeft/Right | `ChevronLeft, ChevronRight` | Pagination |
| X | `X` | Close/Cancel |

### Icon Sizing

| Size | Class | Pixels | Usage |
|------|-------|--------|-------|
| Small | `w-4 h-4` | 16px | Inline, buttons |
| Medium | `w-5 h-5` | 20px | Standard |
| Large | `w-6 h-6` | 24px | Feature icons |
| XL | `w-8 h-8` | 32px | Empty states |

---

## Status Badge Colors (Admin)

### Order Status

| Status | Background | Text |
|--------|------------|------|
| Pending | `bg-yellow-500/20` | `text-yellow-500` |
| Processing | `bg-blue-500/20` | `text-blue-500` |
| Shipped | `bg-purple-500/20` | `text-purple-500` |
| Delivered | `bg-green-500/20` | `text-green-500` |
| Cancelled | `bg-red-500/20` | `text-red-500` |

### Payment Status

| Status | Background | Text |
|--------|------------|------|
| Unpaid | `bg-red-500/20` | `text-red-500` |
| Paid | `bg-green-500/20` | `text-green-500` |
| Refunded | `bg-orange-500/20` | `text-orange-500` |

---

## Quick Reference Card

```
┌─────────────────────────────────────────────────────────────────────┐
│                     DESIGN TOKENS QUICK REFERENCE                   │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  FRONTEND (USER STORE)              ADMIN DASHBOARD                 │
│  ─────────────────────              ─────────────────               │
│  Font: Albert Sans                  Font: Albert Sans               │
│  Background: #FFFFFF                Background: HSL(0,0%,3.9%)      │
│  Text: #000000                      Text: HSL(0,0%,98%)             │
│  Accent: #2c3bc5                    Accent: HSL(217,33%,18%)        │
│  Border: #D1D5DB                    Border: HSL(217,33%,18%)        │
│  Radius: 8px (rounded-lg)           Radius: 6px (--radius)          │
│                                                                     │
│  BREAKPOINTS                        CONTAINER                       │
│  ─────────────                      ─────────────                   │
│  xs: 475px                          max-width: 1400px               │
│  sm: 640px                          padding: 2rem                   │
│  md: 768px                                                          │
│  lg: 1024px                         BUTTON HEIGHTS                  │
│  xl: 1280px                         ─────────────────               │
│  2xl: 1536px                        sm: 36px (h-9)                  │
│                                     default: 40px (h-10)            │
│  SPACING BASE: 4px                  lg: 44px (h-11)                 │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Implementation Checklist

### For Frontend Development

- [ ] Import Albert Sans from Google Fonts
- [ ] Configure Tailwind with custom breakpoints (xs, filter-hide)
- [ ] Add custom colors (announcement: #2c3bc5)
- [ ] Set up animation keyframes (spin-slow, marquee, fadeInUp)
- [ ] Use clamp() for fluid typography and sizing
- [ ] Implement responsive grid patterns

### For Admin Development

- [ ] Enable dark mode via class in Tailwind config
- [ ] Set up CSS custom properties for HSL colors
- [ ] Import Shadcn UI components
- [ ] Configure border-radius CSS variable
- [ ] Add accordion animations
- [ ] Use Lucide icons consistently

---

<div align="center">

**Built with ❤️ using React + Tailwind CSS**

*Last Updated: 2024*

</div>
