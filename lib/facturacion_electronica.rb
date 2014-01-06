require 'facturacion_electronica/version'
require 'services/pac_provider_fm'
require 'bill_xml_request'

module FacturacionElectronica
  PACS = { 'FacturacionModerna' => PacProviderFM }

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

  def self.register_rfc request
    pac_service = choose_service(request[:pac_provider], '')
    pac_service.enable_rfc request[:user_keys], request
  end

  private

  class << self
    def valid_params? request
      result = true
      [:user_keys, :pac_provider, :biller, :bill].each do |k|
        result = (request.has_key?(k) && is_valid?(request[k])) unless result == false
      end
      result
    end

    def is_valid? param_value
      !param_value.empty?
    end

    def choose_service(pac_provider, xml_request)
      PACS[pac_provider].new xml_request
    end
  end

end
