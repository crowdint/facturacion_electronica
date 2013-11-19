require 'pac_provider_fm'

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
  let(:xml_file) do
    xml = File.open './spec/docs_examples/base_xml_file.xml'
    xml.read
  end

  subject{ PacProviderFM.new xml_file }

  describe '#rining' do
    context 'When requesting a valid xml file with valid user keys' do
      before do
        @response = subject.rining(user_keys)
      end

      specify do
        pending
        expect(@response[:status]).to be_true
      end
    end
  end
end
