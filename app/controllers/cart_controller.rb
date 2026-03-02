class CartController < ApplicationController
  def show
    @cart = Cart.new(session)
    @items = @cart.items.map do |item|
      { variant: ProductVariant.find(item[:variant_id]),
        quantity: item[:quantity]  }
    end
  end

def add
  @cart = Cart.new(session)
  @cart.add_item(params[:variant_id].to_i, params[:quantity].to_i)
  redirect_to product_path(ProductVariant.find(params[:variant_id]).product),
      notice: "Item added to cart",
      status: :see_other
end
  def remove
    @cart = Cart.new(session)
    @cart.remove_item(params[:variant_id].to_i)
    redirect_to cart_path, notice: "Item removed from cart"
  end
  def clear
    @cart = Cart.new(session)
    @cart.clear
    redirect_to cart_path, notice: "Cart cleared"
  end
end
