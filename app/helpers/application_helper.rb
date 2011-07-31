module ApplicationHelper
  #New function for hidden_div
  def hidden_div_if(condition, attributes = P{}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end

  def title
    @title
  end

end
