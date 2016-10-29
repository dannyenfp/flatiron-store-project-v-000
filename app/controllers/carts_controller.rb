class CartsController < ApplicationController
  def index
    @carts = Cart.all
  end
  
  def show
    @cart = Cart.find(params[:id])
  end
  
  def new
    @cart = Cart.new
  end
    
  def edit
  end
  
  def update
    @cart = Cart.find(params[:id])
    @cart.add_item(params["item_id"])
    @cart.save
    redirect_to cart_path(@cart)
  end

  def create
    @cart = Cart.new(cart_params)
    @cart.save

    redirect_to cart_path(@cart)
  end
  
  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    redirect_to items_path
  end


  def checkout
    @cart = Cart.find(params[:id])
    @cart.inventory_update
    current_user.remove_cart

    redirect_to cart_path(@cart)

  end
end
