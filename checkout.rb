require './item'
require './promotion'

# Checkout Class
class Checkout
  attr_accessor :promotions, :items_scanned

  def initialize(*promotional_rules)
    @promotions = Promotion.new(promotional_rules)
    item_one = Item.new('001', 'Lavender heart', '9.25')
    item_two = Item.new('002', 'Personalised cufflinks', '45.00')
    item_three = Item.new('003', 'Kids T-shirt', '19.95')
    @items_scanned = []
    @all_items = {
      '001': item_one,
      '002': item_two,
      '003': item_three
    }
  end

  def scan(item_id)
    return if @all_items[item_id.to_sym].nil?

    @items_scanned << item_id
  end

  def total
    cost = 0
    items_scanned_hash = Hash.new(0)
    items_scanned.each do |item|
      items_scanned_hash[item] += 1
    end
    items_scanned_hash.each do |item, quantity|
      price = get_price item, quantity
      total_cost = quantity * price
      cost += total_cost
    end
    rules = promotions.rules
    cost = promotions.send(rules[rules.index('price_discount')], cost) if cost > 60
    p 'Basket: ' +format_items(items_scanned_hash).chomp!(',')
    p 'Total price expected: ' + cost.to_f.round(2).to_s
  end

  private

  def format_items items_scanned_hash
    items_scanned_hash.inject('') { |m, (k, v)| m + "#{k}, " * v }.strip!
  end

  def get_price(item_id, quantity)
    rules = promotions.rules
    return 0 if @all_items[item_id.to_sym].nil?

    if item_id == '001' && quantity >= 2
      promotions.send(rules[rules.index('item_count_discount')])
    else
      @all_items[item_id.to_sym].price.to_f
    end
  end

end
co = Checkout.new('over_60_and_10', 'two_lavender_850')
co.scan('001')
co.scan('002')
co.scan('003')
co.scan('001')
co.total
