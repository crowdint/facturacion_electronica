require 'pac_provider_fm'
require 'bill_xml_request'
require 'fixtures/bill_example'

describe PacProviderFM do
  let(:user_keys) do
    { id:              'UsuarioPruebasWS',
      password:        'b9ec2afa3361a59af4b4d102d3f704eabdf097d4',
      namespace:       'https://t2demo.facturacionmoderna.com/timbrado/soap',
      endpoint:        'https://t2demo.facturacionmoderna.com/timbrado/soap',
      wsdl:            'https://t2demo.facturacionmoderna.com/timbrado/wsdl',
      log:             false,
      ssl_verify_mode: :none
    }
  end
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
  let(:xml_file) do
    BillXmlRequest.new_xml(biller, bill).generate_xml_request
  end

  subject{ PacProviderFM.new xml_file }

  describe '#rining' do
    context 'When requesting a valid xml file with valid user keys' do
      before do
        @response = subject.rining(user_keys)
      end

      specify do
        expect(@response[:status]).to be_true
      end
    end
  end
end
