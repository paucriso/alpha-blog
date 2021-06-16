require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup 
    @category = Category.new(name: "Sports")
  end
  
  test "category should be valid" do
    assert @category.valid? 
  end

  test "category shoud be present" do 
    @category.name = " "
    assert_not @category.valid?
  end

  test "category should be unique" do 
    @category.save 
    @category2 = Category.new(name: "Sports")
    assert_not @category2.valid?
  end

  test "category should be not too long" do 
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "category should not be too short" do 
    @category.name = "aa"
    assert_not @category.valid?
  end

end