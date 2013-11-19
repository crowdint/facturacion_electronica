require 'pac_provider_service'
require 'fm_timbrado_cfdi'

class PacProviderFM < PacProviderService

  def rining user_keys
    config_client user_keys
    response = FmTimbradoCfdi.timbra_cfdi_xml(@tax_receipt_xml, true)
    parse response
  end

  private

  def parse response
    { status: response.valid?,
      xml: response.xml,
      stamp: response.timbre || '',
      pdf: response.pdf || ''
    }
  end

  def config_client user_keys
    FmTimbradoCfdi.configurar do |config|
      config.user_id         = user_keys[:id]
      config.user_pass       = user_keys[:password]
      config.namespace       = user_keys[:namespace]
      config.endpoint        = user_keys[:endpoint]
      config.fm_wsdl         = user_keys[:wsdl]
      config.log             = user_keys[:log]
      config.ssl_verify_mode = user_keys[:ssl_verify_mode]
    end
  end

end
