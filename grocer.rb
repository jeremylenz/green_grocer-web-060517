require 'pry'
def consolidate_cart(cart)
  consolidated_cart = {}
  cart.each do |item_hash|
    grocery_item = item_hash.keys[0]
    if consolidated_cart.has_key?(grocery_item)
      consolidated_cart[grocery_item][:count] += 1
    end

    if consolidated_cart.has_key?(grocery_item) == false
      consolidated_cart[grocery_item]= item_hash.values[0]
      consolidated_cart[grocery_item][:count]= 1
  # binding.pry
    end

  end
# binding.pry
consolidated_cart
end

def apply_coupons(cart, coupons)

coupons.each do |coupon|

  item_the_coupon_is_for = coupon[:item]

  break if cart[item_the_coupon_is_for] == nil # check if the coupon applies to any items in the cart
  for_how_many = coupon[:num]
  break if cart[item_the_coupon_is_for][:count] < for_how_many
  is_clearance = cart[item_the_coupon_is_for][:clearance]
  coupon_price = coupon[:cost]


  # find the item in the cart and subtract for_how_many
  cart[item_the_coupon_is_for][:count] -= for_how_many
  # add the couponed item to the cart, at correct price and remembering clearance
  couponed_item = item_the_coupon_is_for + " W/COUPON"
  if cart[couponed_item] == nil
    cart[couponed_item] = {price: coupon_price, clearance: is_clearance, count: 1}
  else
    cart[couponed_item][:count] += 1
  end


end

cart
end




def apply_clearance(cart)

cart.each do |item, data_hash|
  if data_hash[:clearance]
    # binding.pry
    data_hash[:price] = (data_hash[:price] * 0.80).round(2)
  end
end

end



def checkout(cart, coupons)

cart = consolidate_cart(cart)

cart = apply_coupons(cart, coupons)

cart = apply_clearance(cart)

# binding.pry

#calculate subtotal
subtotal = 0.00
cart.each do |item, data_hash|
  subtotal += (data_hash[:price] * data_hash[:count])

end

if subtotal > 100
  subtotal = (subtotal * 0.90).round(2)
end

subtotal
end
