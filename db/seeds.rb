# db/seeds.rb

# Branches
Branch.destroy_all
Branch.create!([
  { name: "Downtown", address: "123 Main St", phone: "222-0001" },
  { name: "North",    address: "456 North Blvd", phone: "222-0002" },
  { name: "South",    address: "789 South Ave", phone: "222-0003" }
])

# Users
User.destroy_all
User.create!([
  { email: "admin@test.com",     password: "123456", role: :admin },
  { email: "inventory@test.com", password: "123456", role: :inventory_manager },
  { email: "warehouse@test.com", password: "123456", role: :warehouse_staff },
  { email: "employee@test.com",  password: "123456", role: :store_employee },
  { email: "customer@test.com",  password: "123456", role: :customer,
    name: "John Doe", phone: "555-1234", address: "123 Main St, New York" }
])

# Products
inventory_user = User.find_by(email: "inventory@test.com")

product = Product.create!(
  name: "Polo Shirt",
  description: "Premium cotton polo shirt",
  category: "Clothing",
  active: true,
  user: inventory_user
)

# Variants
variants = ProductVariant.create!([
  { product: product, sku: "POL-SHI-RED-S", size: "S", color: "Red",  material: "Cotton", price: 29.99 },
  { product: product, sku: "POL-SHI-RED-M", size: "M", color: "Red",  material: "Cotton", price: 29.99 },
  { product: product, sku: "POL-SHI-RED-L", size: "L", color: "Red",  material: "Cotton", price: 29.99 }
])

# Inventories
downtown = Branch.find_by(name: "Downtown")
north    = Branch.find_by(name: "North")

variants.each do |variant|
  Inventory.create!([
    { product_variant: variant, branch: downtown, quantity: 10 },
    { product_variant: variant, branch: north,    quantity: 5  },
    { product_variant: variant, branch_id: nil,   quantity: 20 }
  ])
end
# ============================================
# Datos adicionales para pruebas rápidas
# ============================================

# Crear más productos y variantes para tener variedad
inventory_user = User.find_by(email: "inventory@test.com")
branches = Branch.all.to_a

# Producto 2: Jeans
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

# Producto 3: Zapatos
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

# Inventarios para los nuevos productos
(jeans_variants + shoes_variants).each do |variant|
  branches.each do |branch|
    Inventory.create!(
      product_variant: variant,
      branch: branch,
      quantity: rand(5..15)
    )
  end
  # Inventario central (branch_id nil)
  Inventory.create!(
    product_variant: variant,
    branch_id: nil,
    quantity: rand(20..50)
  )
end

# Crear clientes adicionales
customer_emails = [
  { email: "ana@example.com", name: "Ana García", phone: "555-1001", address: "Calle 1 #123" },
  { email: "carlos@example.com", name: "Carlos López", phone: "555-1002", address: "Av. Central 456" },
  { email: "maria@example.com", name: "María Rodríguez", phone: "555-1003", address: "Plaza Mayor 789" },
  { email: "jose@example.com", name: "José Martínez", phone: "555-1004", address: "Calle 5 #456" },
  { email: "laura@example.com", name: "Laura Sánchez", phone: "555-1005", address: "Av. Reforma 789" }
]

customer_emails.each do |data|
  User.create!(
    email: data[:email],
    password: "123456",
    role: :customer,
    name: data[:name],
    phone: data[:phone],
    address: data[:address]
  )
end

# Obtener todos los clientes (incluyendo el creado antes)
customers = User.where(role: :customer).to_a

# Obtener todas las variantes de productos para usar en órdenes
all_variants = ProductVariant.all.to_a

# Crear órdenes con diferentes estados
statuses = [ :pending, :paid, :processing, :shipped, :delivered, :cancelled ]

20.times do |i|
  customer = customers.sample
  status = statuses.sample
  order = Order.create!(
    customer: customer,
    shipping_address: customer.address,
    status: status,
    total: 0, # se actualizará después
    created_at: rand(1..30).days.ago
  )

  # Agregar entre 1 y 4 items aleatorios
  total = 0
  rand(1..4).times do
    variant = all_variants.sample
    quantity = rand(1..3)
    price = variant.price
    subtotal = price * quantity
    OrderItem.create!(
      order: order,
      product_variant: variant,
      quantity: quantity,
      price: price
    )
    total += subtotal
  end

  order.update!(total: total)
end

# Actualizar el contador de algunas órdenes para que tengan fecha más reciente
Order.limit(5).update_all(created_at: Time.current)

puts "Datos adicionales creados:"
puts "#{Product.count - 1} productos nuevos"  # porque ya había 1
puts "#{ProductVariant.count - 3} variantes nuevas"
puts "#{User.where(role: :customer).count} clientes"
puts "#{Order.count} órdenes"
puts "#{OrderItem.count} items de órdenes"

puts "Seeds completed:"
puts "#{Branch.count} branches"
puts "#{User.count} users"
puts "#{Product.count} products"
puts "#{ProductVariant.count} variants"
puts "#{Inventory.count} inventories"
