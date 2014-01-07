require 'services/pac_provider_service'

describe PacProviderService do
  let(:xml_file) do
    xml = File.open './spec/docs_examples/base_xml_file.xml'
    xml.read
  end
  subject{ PacProviderService.new xml_file, {} }
  describe '#tax_receipt_xml' do
    specify do
      expect(subject.tax_receipt_xml).to include('cfdi:Comprobante xmlns:cfdi="http://www.sat.gob.mx/cfd/3')
    end
  end
end
