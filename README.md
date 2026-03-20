# Retailcore

Multi-role e-commerce and inventory management system built with Ruby on Rails 8.

## Roles

| Role | Access |
|------|--------|
| Customer | Product catalog, cart, online orders |
| Warehouse Staff | Order processing and status management |
| Inventory Manager | Products, variants, stock per branch |
| Admin | Dashboard, users, branches, reports |

## Tech Stack

- **Ruby on Rails 8.1**
- **SQLite** (development)
- **Devise** — authentication
- **Bootstrap** — UI
- **Cart** — session-based PORO (no database model)

## Setup

```bash
git clone https://github.com/your-username/retailcore
cd retailcore
bundle install
rails db:setup
rails server
```

## Database

```bash
rails db:migrate
rails db:seed   # creates demo users and products
```

## Default Users (seed)

```
admin@retailcore.com       role: admin
warehouse@retailcore.com   role: warehouse_staff
inventory@retailcore.com   role: inventory_manager
customer@retailcore.com    role: customer

password: 123456
```

## Routes Overview

```
/                          → public catalog
/cart                      → shopping cart
/admin                     → admin dashboard
/inventory                 → inventory manager dashboard
/warehouse                 → warehouse staff dashboard
/customer                  → customer profile
```

## Key Features

- Multi-role authentication with automatic redirect on login
- Session-based cart with stock validation at checkout
- Inventory tracked per branch (`branch_id: nil` = web warehouse)
- Order status flow: `pending → processing → shipped → delivered`
- Kanban-style order view for warehouse staff

## Project Structure

```
app/controllers/
├── admin/
├── customer/
├── inventory/
├── warehouse/
├── cart_controller.rb
└── products_controller.rb
```

