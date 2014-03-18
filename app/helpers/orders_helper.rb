module OrdersHelper
  def localised_payment_type_options
    PaymentType.names.map{|t| [I18n.t("orders.payment_types." + "#{t.parameterize.underscore}"), t]}
  end
end
