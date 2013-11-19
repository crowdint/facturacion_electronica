require 'facturacion_electronica/version'
require 'cfdi'
require 'pac_provider_fm'

module FacturacionElectronica
  PACS = { :'FacturacionModerna' => PacProviderFM }

  def self.create_cfdi(request)
    @bill = request[:bill]
    @certificate = CFDI::Certificado.new request[:biller][:certificate]
    @key = CFDI::Key.new request[:biller][:key], request[:biller][:password]
    pac_service = PacProviderFM.new generate_xml_request
    pac_service.rining request[:user_keys]
  end

  private

  class << self
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

    #Generate an XML file by CFDI gem
    def generate_xml_request
      tax_receipt = generate_tax_receipt
      @certificate.certifica tax_receipt
      @key.sella tax_receipt
      tax_receipt.to_xml
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
end
