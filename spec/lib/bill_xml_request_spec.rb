require 'bill_xml_request'
require 'fixtures/bill_example'

describe BillXmlRequest do
  let(:biller) do
    {
      certificate:  File.open('./spec/docs_examples/CertificadosDemo-FM/TUMG620310R95/TUMG620310R95_1210241209S.cer'),
      key:          File.open('spec/docs_examples/CertificadosDemo-FM/TUMG620310R95/TUMG620310R95_1210241209S.key.pem'),
      password:     '12345678a'
    }
  end
  let(:bill) do
    BillExample.request
  end

  context 'When construct a new bill xml with valid information' do
    before do
      new_xml_request = BillXmlRequest.new_xml(biller, bill)
      @response = new_xml_request.generate_xml_request
    end

    it 'should be a xml file' do
      expect(@response).to include('<?xml version="1.0"?>')
    end

    it 'contains Comprobante key' do
      expect(@response).to include('<cfdi:Comprobante')
    end

    it 'using the SAT cfdi url' do
      expect(@response).to include('xmlns:cfdi="http://www.sat.gob.mx/cfd/3"')
    end

    it 'using the SAT xsi url' do
      expect(@response).to include('xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"')
    end

    it 'using the SAT schemaLocation url' do
      expect(@response).to include('xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd"')
    end

    it 'contains Certificado key' do
      expect(@response).to include('certificado=')
    end

    it 'contains Certificado key' do
      expect(@response).to include('sello=')
    end
  end
end
