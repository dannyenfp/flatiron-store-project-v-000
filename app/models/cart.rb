class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user
  

  def add_item(item_id)
    line_item = self.line_items.find_by(item_id: item_id)
    if line_item
      line_item.quantity += 1
    else
      line_item=self.line_items.build(item_id: item_id)
    end
    line_item
  end


  def total
    self.items.collect { |x| x.price }.inject(:+)
  end

  def inventory_update
    line_items.each do |l_item|
      l_item.item.inventory -= l_item.quantity
      l_item.item.save
    end
    self.status = "submitted"
    self.line_items = []
    save
  end

end


