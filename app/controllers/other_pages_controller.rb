class OtherPagesController < ApplicationController

  def questions       
    @title = "Questions"
  end
  
  def news
    @title = "News"
  end
  
  def contacts
    @title = "Contacts"
  end
  
end
