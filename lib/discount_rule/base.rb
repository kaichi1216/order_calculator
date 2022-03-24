#global variable to record user_id
$user_ids = []
$user_limit_money = []

module DiscountRule
  class Base
    @@user_ids = []
    attr_reader :params, :cart, :name
    attr_accessor :discount_content

    def initialize(params = {})
      @cart = params[:cart]
      @name = params[:name]
      @params = params
      @discount_content = []
    end

    def perform
      {
        original: calc_orignal,
        discount: calc_discount,
        final: calc_final,
        content: discount_content
      }
    end

    private

    def calc_orignal
      @calc_orignal ||= cart.total_price
    end

    def calc_discount
      @calc_discount ||= calc_discount_rule
    end

    # overide
    def calc_discount_rule
      0
    end

    def calc_final
      calc_orignal - calc_discount
    end

    def discount_content 
      @discount_content
    end
  end
end
