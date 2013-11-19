require 'facturacion_electronica'
require 'fixtures/bill_example'

describe FacturacionElectronica do

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
  let(:pac_provider){ 'FacturacionModerna' }
  let(:bill) do
    BillExample.request
  end

  describe '.create_cfdi' do
    context 'When request for new cfdi with valid information' do
      before do
        @response = subject.create_cfdi({
          user_keys:           user_keys,
          pac_provider:        pac_provider,
          biller:              biller,
          bill:                bill})
      end

      it 'returns a valid stamped bill' do
        expect(@response[:status]).to be_true
      end

      it 'contains a valid SAT rining' do
        expect(@response[:xml]).to include('<cfdi:Complemento><tfd:TimbreFiscalDigital')
      end
    end

    context 'When request for a new cfdi without valid user keys' do
      before do
        @response = subject.create_cfdi({
          user_keys:           user_keys,
          pac_provider:        pac_provider,
          biller:              biller,
          bill:                bill})
      end

      it 'returns an invalid status' do
        pending
        expect(@response.status).to be_false
      end
    end
  end

end
