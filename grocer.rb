require 'pry'

def consolidate_cart(cart)
  # code here
  single_item_list = {}

  cart.each do |item|
    item.each do |key, value|
      # binding.pry
      if single_item_list[key] == nil
        single_item_list[key] = value
        single_item_list[key][:count] = 1
      else
        single_item_list[key][:count] += 1
      end
    end
  end

  single_item_list
end

def apply_coupons(cart, coupons)
  # code here
  updated_cart = {}

  cart.each do |current_item, specs|
    if updated_cart[current_item] == nil
      updated_cart[current_item] = specs
    end
    # binding.pry
    coupons.each do |item|
      item.each do |key, value|
        # binding.pry
        if value == current_item #checks value which is the item on the coupon to if its the same as item in cart
          if updated_cart["#{current_item} W/COUPON"] == nil #if we havent added a coupon version of the items this adds it
            updated_cart["#{current_item} W/COUPON"] = {:price=>item[:cost], :clearance => cart[current_item][:clearance] , :count=>0 }
          end
          if (updated_cart[current_item][:count] < item[:num]) == false#this will change the counts of item and item with coupon
            updated_cart[current_item][:count] -= item[:num]
            updated_cart["#{current_item} W/COUPON"][:count] += 1
          end
        end
      end #item.each
    end #coupons.each
  end #cart.each
  updated_cart
end

def apply_clearance(cart)
  # code here
  new_cart = {}
  new_cart = cart
  cart.each do |item, specs|
    if cart[item][:clearance]
      new_cart[item][:price] = (new_cart[item][:price]* 0.80).round(1)
    end
    # binding.pry
  end
  new_cart
end

def checkout(cart, coupons)
  # code here
  # binding.pry
  # consolidated_cart = []
  consolidated_cart = consolidate_cart(cart) #I dont really undersand the named parameters
  consolidated_cart = apply_coupons(consolidated_cart, coupons)
  consolidated_cart = apply_clearance(consolidated_cart)
  # binding.pry
  total_price = 0
  consolidated_cart.each do |item, spec|
    # binding.pry
    total_price += (spec[:price] * spec[:count])
  end

  if total_price > 100
    total_price = (total_price * 0.9).round(1)
  end

  total_price
  # binding.pry

end
