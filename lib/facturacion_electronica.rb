require 'facturacion_electronica/version'
require 'pac_provider_fm'
require 'bill_xml_request'

module FacturacionElectronica
  PACS = { :'FacturacionModerna' => PacProviderFM }

  def self.create_cfdi(request)
    new_xml_request = (BillXmlRequest.new_xml request[:biller], request[:bill]).generate_xml_request
    pac_service = PacProviderFM.new new_xml_request
    pac_service.rining request[:user_keys]
  end
end
