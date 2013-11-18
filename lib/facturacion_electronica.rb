require "facturacion_electronica/version"
require 'cfdi'

module FacturacionElectronica
  #PACS = { :'FacturacionModerna' => PacProviderFM,
           #:'LoFacturo' => PacProviderLF }

  def self.stamp_bill(user_keys, pac, certificate, key, bill)
    @bill = bill
    @certificate = CFDI::Certificado.new certificate
    @key = CFDI::Key.new key, bill_emissor_pass
    #pac_service = PACS[pac].new generate_xml
    #pac_service.rining
    generate_xml
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
    def generate_xml
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
