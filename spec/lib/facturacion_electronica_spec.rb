require 'facturacion_electronica'

describe FacturacionElectronica do
  describe '.stamp_bill' do
    specify{ expect(subject.stamp_bill).to eql('stamping bill') }
  end
end
