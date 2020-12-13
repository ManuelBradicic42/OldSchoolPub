require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test "should not save empty order" do
    order = Order.new
    order.save

    refute order.valid?
  end

  test "should not save empty customerName" do
    order = Order.create(customerNumber: "091231231", address: "GPA 7", totalPrice: 120.00)
    order.save

    refute order.valid?
  end

  test "should not save empty customerNumber" do
    order = Order.create(customerName: "Josh", address: "GPA 7", totalPrice: 120.00)
    order.save

    refute order.valid?
  end

  test "should not save empty address" do
    order = Order.create(customerName: "Josh", customerNumber: "0738231223", totalPrice: 120.00)
    order.save

    refute order.valid?
  end

  test "should not save empty price" do
    order = Order.create(customerName: "Johnny", customerNumber: "091231231", address: "GPA 7")
    order.save

    refute order.valid?
  end

  test "should save valid order" do
    order = Order.create(customerName: "Johnny", customerNumber: "12321312", address: "GPA 7", totalPrice: 120.00)
    order.save

    assert order.valid?     
  end


end
