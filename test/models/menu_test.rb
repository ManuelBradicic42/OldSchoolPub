require 'test_helper'

class MenuTest < ActiveSupport::TestCase

  test 'should not save empty menu' do
    menu = Menu.new
    menu.save
    refute menu.valid?
  end

  test 'should not save empty name' do
    menu = Menu.create(description: "This pizza has cheese", availability: true, price: 10.00)
    menu.save
    refute menu.valid?
  end

  test 'should not save empty description' do
    menu = Menu.create(name: "English pizza", availability: true, price: 10.00)
    menu.save

    refute menu.valid?
  end

  test 'should not save empty price' do
    menu = Menu.create(name: "Italiana", description: "Tomato/Ham/cheese", availability: false)
    menu.save

    refute menu.valid?
  end

  test 'should not save negative price' do
    menu = Menu.create(name: "English pizza", description: "Tomato/Ham/cheese", availability: true, price: -1)
    menu.save

    refute menu.valid?
  end

  test 'should not save price = 0' do
    menu = Menu.create(name: "My pizza", description:"This pizza has no ingredients", availability: true, price: 0)
    menu.save

    refute menu.valid?
  end

  test 'should not save duplicate menu names' do
    menu1 = Menu.new
    menu1.name = "My pizza"
    menu1.description = "This pizza has loads of cheese"
    menu1.availability = "true"
    menu1.price = 6.66
    menu1.save
    assert menu1.valid?

    menu2 = Menu.new
    menu2.name = "My pizza"
    menu2.description = "This pizza has loads of tomatoes"
    menu2.availability = "false"
    menu2.price = 7.77
    menu2.save
    refute menu2.valid?
  end


  test 'should save valid menu' do
      menu = Menu.new
      menu.name = "My pizza"
      menu.description = "This pizza has a bit of cheese"
      menu.availability = "true"
      menu.price = 6.66

      menu.save
      assert menu.valid?
    end
end
