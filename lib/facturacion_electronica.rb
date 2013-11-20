require 'facturacion_electronica/version'
require 'services/pac_provider_fm'
require 'bill_xml_request'

module FacturacionElectronica
  PACS = { :'FacturacionModerna' => PacProviderFM }

  def self.create_cfdi request
    if valid_params?(request)
      new_xml_request = (BillXmlRequest.new_xml request[:biller],
                          request[:bill]).generate_xml_request
      pac_service = PacProviderFM.new new_xml_request
      pac_service.rining request[:user_keys]
    else
      { status: false, error_msg: 'Parametros invalidos' }
    end
  end

  private

  class << self
    def valid_params? request
      result =  is_valid?(request[:user_keys])
      (result == false) || result = is_valid?(request[:pac_provider])
      (result == false) || result = is_valid?(request[:biller])
      (result == false) || result = is_valid?(request[:bill])
      result
    end

    def is_valid? param_value
      !param_value.nil? && !param_value.empty?
    end
  end
end
