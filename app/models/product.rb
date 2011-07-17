class Product < ActiveRecord::Base
  
  #Query products in table by alphabetical order
  default_scope :order => 'title'
  
  #Each product can be referenced by many line items
  has_many :line_items
  
  #Checks a hook method before destroying products - method needs to be true
  before_destroy :ensure_not_referenced_by_any_line_item
  
  def ensure_not_referenced_by_any_line_item
    #If there are no line items referencing this product, return true
    #Could also be line_items.count == 0
    if line_items.count.zero?
      return true
    else
      #All models have direct access to the errors object
      errors.add(:base, 'Line Items present')
      return false
    end
  end
  
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
