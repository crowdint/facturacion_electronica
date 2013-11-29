class PacProviderService
  attr_accessor :tax_receipt_xml

  def initialize tax_receipt_xml
    @tax_receipt_xml = tax_receipt_xml
  end
end
