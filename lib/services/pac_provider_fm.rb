require 'services/pac_provider_service'
require 'fm_timbrado_cfdi'

class PacProviderFM < PacProviderService

  def cancel user_keys, rfc, uuid
    config_client
    response = FmTimbradoCfdi.cancelar rfc, uuid
    parse_cfdi response
  end

  def enable_rfc user_keys, request
    config_client
    response = FmTimbradoCfdi.subir_certificado request[:rfc],
      request[:certificate], request[:key],
      request[:password]
    parse_cfdi response
  end

  def rining user_keys
    config_client
    response = FmTimbradoCfdi.timbra_cfdi_xml(@tax_receipt_xml, true)
    parse response
  end

  private

  def parse response
    { status: response.valid?,
      xml:    response.xml,
      stamp:  response.timbre || '',
      pdf:    response.pdf || '',
      cbb:    response.cbb || '',
      errors: response.errors
    }
  end

  def parse_cfdi response
    {
      status: response.valid?,
      xml: response.xml,
      success: return_success_message(response.xml),
      errors: return_error_message(response.error)
    }
  end

  def config_client
    FmTimbradoCfdi.configurar do |config|
      config.user_id         = @user_keys[:id]
      config.user_pass       = @user_keys[:password]
      config.namespace       = @user_keys[:namespace]
      config.endpoint        = @user_keys[:endpoint]
      config.fm_wsdl         = @user_keys[:wsdl]
      config.log             = @user_keys[:log]
      config.ssl_verify_mode = @user_keys[:ssl_verify_mode]
    end
  end

  def return_error_message xml
    {
      code:    Nokogiri::XML(xml).xpath('//faultcode').text(),
      message: Nokogiri::XML(xml).xpath('//faultstring').text()
    }
  end

  def return_success_message xml
    {
      code:    Nokogiri::XML(xml).xpath('//Code').text,
      message: Nokogiri::XML(xml).xpath('//Message').text
    }
  end

end
