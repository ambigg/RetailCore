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
  { email: "customer@test.com",  password: "123456", role: :customer }
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

puts "Seeds completed:"
puts "#{Branch.count} branches"
puts "#{User.count} users"
puts "#{Product.count} products"
puts "#{ProductVariant.count} variants"
puts "#{Inventory.count} inventories"
