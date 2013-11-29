require 'cfdi'

class BillXmlRequest
  def self.new_xml(*args, &block)
    instance = allocate
    instance.my_initialize(*args, &block)
    instance
  end

  def my_initialize biller, bill
    @certificate = CFDI::Certificado.new biller[:certificate]
    @key = CFDI::Key.new biller[:key], biller[:password]
    @bill = bill
  end

  #Generate an XML file by CFDI gem
  def generate_xml_request
    tax_receipt = generate_tax_receipt
    @certificate.certifica tax_receipt
    @key.sella tax_receipt
    tax_receipt.to_xml
  end

  private

  def bill_emissor_pass
    @bill[:emisor_pass]
  end

  def generate_tax_receipt
    tax_receipt = CFDI::Comprobante.new @bill[:factura]
    tax_receipt.emisor = get_tax_receipt_emissor
    tax_receipt.receptor = get_tax_receipt_receptor
    set_tax_receipt_concepts tax_receipt
    tax_receipt.impuestos << get_tax_receipt_taxes
    tax_receipt
  end

  def get_tax_receipt_emissor
    @bill[:emisor][:domicilioFiscal] = CFDI::Domicilio.new @bill[:emisor][:domicilioFiscal]
    @bill[:emisor][:expedidoEn] = CFDI::Domicilio.new @bill[:emisor][:expedidoEn]
    CFDI::Entidad.new @bill[:emisor]
  end

  def get_tax_receipt_receptor
    @bill[:cliente][:domicilioFiscal] = CFDI::Domicilio.new @bill[:cliente][:domicilioFiscal]
    CFDI::Entidad.new @bill[:cliente]
  end

  def set_tax_receipt_concepts tax_receipt
    @bill[:conceptos].each do |concept|
      tax_receipt.conceptos << CFDI::Concepto.new(concept)
    end
  end

  def get_tax_receipt_taxes
    @bill[:impuestos]
  end
end
