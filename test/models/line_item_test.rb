require 'test_helper'

class LineItemTest < ActiveSupport::TestCase

  test "should save valid items" do
    order = Order.create(customerName: "Johnny", customerNumber: "12321312", address: "GPA 7", totalPrice: 120.00)
    order.save

    menu1 = Menu.create(name: "Pizza1", description: "Ham, cheese", availability: true, price: 40)
    menu1.save

    menu2 = Menu.create(name: "Pizza2", description: "Ham, cheese", availability: true, price: 40)
    menu2.save

    menu3 = Menu.create(name: "Pizza3", description: "Ham, cheese", availability: true, price: 40)
    menu3.save
    #
    # get add_to_session, params: {id: menu1.id}
    # get add_to_session, params: {id: menu2.id}
    # get add_to_session, params: {id: menu3.id}

    line_item1 = LineItem.create(order_id: order.id, menu_id: menu1.id)
    line_item1.save
    assert line_item1.valid?

    line_item2 = LineItem.create(order_id: order.id, menu_id: menu2.id)
    line_item2.save
    assert line_item2.valid?

    line_item3 = LineItem.create(order_id: order.id, menu_id: menu3.id)
    line_item3.save
    assert line_item3.valid?
  end


end
