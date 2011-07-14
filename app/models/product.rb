class Product < ActiveRecord::Base
  
  #Query products in table by alphabetical order
  default_scope :order => 'title'
  
  validates :title, :description, :image_url, :presence => true
  # False generates numericatlity error message
  validates :price, :numericality => { :greater_than_or_equal_to => 0.01, :message => 'must be equal or greater than $0.01' } 
  validates :title, :uniqueness => true 
  #Validates image_url model field across :format condition. False generates error message.
  validates :image_url, :format => {
    :with	=> %r{\.(gif|jpg|png)$}i, :message => 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :title, :length => { :minimum => 10 }
  
end
