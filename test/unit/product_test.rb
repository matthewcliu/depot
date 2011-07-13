require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  #This adds a fixture. Same thing as Factory for Rspec but requires YML
  fixtures :products
  
  #Testing attributes not empty
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?    
    assert product.errors[:image_url].any?
  end
  
  #Testing Product price
  test "product price must be positive" do
    product = Product.new(:title => "My book title", :description => "abc", :image_url => 'zzz.jpg')
    
    #Test negative price
    product.price = -1
    assert product.invalid?
    #How does this error message work?
    assert_equal "must be greater than or equal to 0.01",
    product.errors[:price].join('; ')
    
    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
    product.errors[:price].join('; ')

    product.price = 1
    assert product.valid?
  end

  #Testing Image URL Validity
  #Created a method in test doc to change image_url of a new product
  def new_product(image_url)
    
    Product.new(:title       => "My Book Title",
                :description => "yyy",
                :price       => 1,
                :image_url   => image_url)
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
             http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |imageurl|
      #assert that new product with OK image URLS are valid
      assert new_product(imageurl).valid?, "#{imageurl} should be valid"
    end

    bad.each do |imageurl|
      #assert that new product with bad image URLs are invalid
      assert new_product(imageurl).invalid?, "#{imageurl} shouldn't be valid"
    end
  end

end
