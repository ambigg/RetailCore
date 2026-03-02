class Cart
  attr_reader :items
  def initialize(session)
    @items = (session[:cart] || []).map(&:symbolize_keys)
    @session = session
  end

  def add_item(variant_id, quantity = 1)
    variant_id = variant_id.to_i
    item = @items.find { |i| i[:variant_id] == variant_id }
    if item
      item[:quantity] += quantity
    else
      @items << { variant_id: variant_id, quantity: quantity }
    end
    save
  end

  def save
    @session[:cart] = @items
  end

  def total
    @items.sum do |item|
    variant = ProductVariant.find(item[:variant_id])
    variant.price * item[:quantity]
    end
  end

  def count
    @items.sum { |i| i[:quantity] }
  end

  def remove_item(variant_id)
    @items.reject! { |i| i[:variant_id] == variant_id }
    save
  end

  def clear
    @items =[]
    save
  end
end
