class Product
  attr_reader :id
  attr_accessor :name, :price, :tag

  def initialize(id, name, price, tag)
    @id = id
    @name = name
    @price = price
    @tag = tag
  end

end