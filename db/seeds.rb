# ============================================
# 1. Branches
# ============================================
puts "Creating branches..."
Branch.destroy_all
branches = Branch.create!([
  { name: "Downtown", address: "123 Main St", phone: "222-0001", status: :active },
  { name: "North",    address: "456 North Blvd", phone: "222-0002", status: :active },
  { name: "South",    address: "789 South Ave", phone: "222-0003", status: :active }
])

# ============================================
# 2. Users (sin branch_id)
# ============================================
puts "Creating users..."
User.destroy_all

# Admin
User.create!(
  email: "admin@test.com",
  password: "123456",
  role: :admin,
  name: "Admin User"
)

# Inventory manager
inventory_user = User.create!(
  email: "inventory@test.com",
  password: "123456",
  role: :inventory_manager,
  name: "Inventory Manager"
)

# Warehouse staff
User.create!(
  email: "warehouse@test.com",
  password: "123456",
  role: :warehouse_staff,
  name: "Warehouse Staff"
)

# Store employees (sin branch asignado)
employee_downtown = User.create!(
  email: "employee.downtown@test.com",
  password: "123456",
  role: :store_employee,
  name: "Downtown Employee"
)

employee_north = User.create!(
  email: "employee.north@test.com",
  password: "123456",
  role: :store_employee,
  name: "North Employee"
)

employee_south = User.create!(
  email: "employee.south@test.com",
  password: "123456",
  role: :store_employee,
  name: "South Employee"
)

# Base customer
customer_john = User.create!(
  email: "customer@test.com",
  password: "123456",
  role: :customer,
  name: "John Doe",
  phone: "555-1234",
  address: "123 Main St, New York"
)

# ============================================
# 3. Products and Variants
# ============================================
puts "Creating products and variants..."

# Product 1: Polo Shirt
polo = Product.create!(
  name: "Polo Shirt",
  description: "Premium cotton polo shirt",
  category: "Clothing",
  active: true,
  user: inventory_user
)

polo_variants = ProductVariant.create!([
  { product: polo, sku: "POL-SHI-RED-S", size: "S", color: "Red",  material: "Cotton", price: 29.99 },
  { product: polo, sku: "POL-SHI-RED-M", size: "M", color: "Red",  material: "Cotton", price: 29.99 },
  { product: polo, sku: "POL-SHI-RED-L", size: "L", color: "Red",  material: "Cotton", price: 29.99 }
])

# Product 2: Jeans
jeans = Product.create!(
  name: "Slim Fit Jeans",
  description: "Dark blue slim fit jeans",
  category: "Clothing",
  active: true,
  user: inventory_user
)

jeans_variants = ProductVariant.create!([
  { product: jeans, sku: "JNS-BLU-30", size: "30", color: "Blue", material: "Denim", price: 49.99 },
  { product: jeans, sku: "JNS-BLU-32", size: "32", color: "Blue", material: "Denim", price: 49.99 },
  { product: jeans, sku: "JNS-BLU-34", size: "34", color: "Blue", material: "Denim", price: 49.99 }
])

# Product 3: Running Shoes
shoes = Product.create!(
  name: "Running Shoes",
  description: "Lightweight running shoes",
  category: "Footwear",
  active: true,
  user: inventory_user
)

shoes_variants = ProductVariant.create!([
  { product: shoes, sku: "RUN-40", size: "40", color: "Black", material: "Mesh", price: 79.99 },
  { product: shoes, sku: "RUN-41", size: "41", color: "Black", material: "Mesh", price: 79.99 },
  { product: shoes, sku: "RUN-42", size: "42", color: "Black", material: "Mesh", price: 79.99 }
])

all_variants = polo_variants + jeans_variants + shoes_variants

# ============================================
# 4. Inventories (per branch + central)
# ============================================
puts "Creating inventories..."

all_variants.each do |variant|
  branches.each do |branch|
    Inventory.create!(
      product_variant: variant,
      branch: branch,
      quantity: rand(10..30)
    )
  end
  Inventory.create!(
    product_variant: variant,
    branch_id: nil,
    quantity: rand(50..100)
  )
end

# ============================================
# 5. Additional customers
# ============================================
puts "Creating additional customers..."
customer_data = [
  { email: "ana@example.com", name: "Ana García", phone: "555-1001", address: "Calle 1 #123" },
  { email: "carlos@example.com", name: "Carlos López", phone: "555-1002", address: "Av. Central 456" },
  { email: "maria@example.com", name: "María Rodríguez", phone: "555-1003", address: "Plaza Mayor 789" },
  { email: "jose@example.com", name: "José Martínez", phone: "555-1004", address: "Calle 5 #456" },
  { email: "laura@example.com", name: "Laura Sánchez", phone: "555-1005", address: "Av. Reforma 789" }
]

customer_data.each do |data|
  User.create!(
    email: data[:email],
    password: "123456",
    role: :customer,
    name: data[:name],
    phone: data[:phone],
    address: data[:address]
  )
end

customers = User.where(role: :customer).to_a

# ============================================
# 6. Online Orders
# ============================================
puts "Creating online orders..."
statuses = [ :pending, :paid, :processing, :shipped, :delivered, :cancelled ]

20.times do
  customer = customers.sample
  order = Order.create!(
    customer: customer,
    shipping_address: customer.address,
    status: statuses.sample,
    total: 0,
    created_at: rand(1..30).days.ago
  )

  total = 0
  rand(1..4).times do
    variant = all_variants.sample
    quantity = rand(1..3)
    OrderItem.create!(
      order: order,
      product_variant: variant,
      quantity: quantity,
      price: variant.price
    )
    total += variant.price * quantity
  end
  order.update!(total: total)
end


# ============================================
# 8. Final summary
# ============================================
puts "\nSeeds completed"
puts "================================"
puts "Branches: #{Branch.count}"
puts "Users: #{User.count}"
puts "Products: #{Product.count}"
puts "Product variants: #{ProductVariant.count}"
puts "Inventories: #{Inventory.count}"
puts "Orders: #{Order.count}"
puts "Order items: #{OrderItem.count}"
puts "================================"
