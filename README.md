# Ruby 實作 折扣計算機
# Ruby version 2.6.6
類別:
  User
  Product
  Cart
  Promotion
  Calculator
  Order

模組:
  Base(所有折扣條件繼承自他)
  BuyTwoGetOff(特定商品滿 x 件折 y 元)
  DiscountMoneyOnOrder(訂單滿 X 元折 Z %,折扣每人只能總共優惠 N 元)
  OrderDiscountRule(訂單滿 X 元折 Y 元,此折扣在全站限用 N 次)
  OrderGetFreeItem(訂單滿兩百送造型玻璃杯)
  PersentDiscountOnOrder(訂單滿 x 元打 y 折)

流程:
  Cart 欄位有使用者id、商品數量及價格，將 cart 帶進 Calculator 後會算出此台購物車折扣金額、折扣後總價、折扣內容、並可以傳進 Order Class 生成訂單。

測試:
  針對每一個 Class、 Module 撰寫 unit test。






