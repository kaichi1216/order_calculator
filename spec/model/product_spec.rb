require_relative '../../model/product'

describe Product do
  context "new product" do
    it "check product column" do
      p = Product.new(1, "飯糰", 30, "鮮食")
      expect(p.name).to eq("飯糰")
      expect(p.tag).to eq("鮮食")
      expect(p.price).to eq(30)
    end
  end
end