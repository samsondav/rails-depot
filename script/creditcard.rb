credit_card = ActiveMerchant::Billing::CreditCard.new(
  number: '4123512361237123',
  month: '8',
  year: '2009',
  first_name: 'Tobias',
  last_name: 'Luetke',
  verification_value: '123'
)

puts "Is #{credit_card.number} valid? #{credit_card.valid?}"
