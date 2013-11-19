require 'pac_provider_service'
require 'fm_timbrado_cfdi'

class PacProviderFM < PacProviderService

  def rining
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

end
