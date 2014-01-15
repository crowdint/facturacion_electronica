class PacProviderService
  attr_accessor :tax_receipt_xml

  def initialize tax_receipt_xml, user_keys
    @tax_receipt_xml = tax_receipt_xml
    @user_keys = user_keys
  end
end
