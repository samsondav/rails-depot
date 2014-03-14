class PaymentType < ActiveRecord::Base
  def self.names
    all.collect { |payment_type| payment_type.name }
  end
end
