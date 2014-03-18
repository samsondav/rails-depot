module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display:none"
    end
    content_tag("div", attributes, &block)
  end
  
  def local_currency(price)
    euro_rate = 0.72
    if I18n.locale.to_s == 'es'
      price * euro_rate
    else
      price
    end
  end
end
