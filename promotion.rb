# Promotion Class
class Promotion

  # over_60_and_10
  # two_lavender_850
  attr_accessor :rules
  def initialize(rules)
    @rules = []
    get_rule(rules)
  end

  def price_discount(total)
    total - (total * 0.10)
  end

  def item_count_discount
    8.50
  end

  private

  def get_rule(rules)
    rules.each do |rule|
      case rule
      when 'over_60_and_10'
        @rules << 'price_discount'
      when 'two_lavender_850'
        @rules << 'item_count_discount'
      else
        'Error: No matching discount'
      end
    end
  end
end
