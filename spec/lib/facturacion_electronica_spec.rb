require 'facturacion_electronica'

describe FacturacionElectronica do

  let(:user_keys) do
    { id: 'UsuarioPruebasWS',
      pass: 'b9ec2afa3361a59af4b4d102d3f704eabdf097d4' }
  end
  let(:sat_certificate){ File.open './spec/docs_examples/CertificadosDemo-FM/TUMG620310R95/TUMG620310R95_1210241209S.cer' }
  let(:sat_key){ File.open 'spec/docs_examples/CertificadosDemo-FM/TUMG620310R95/TUMG620310R95_1210241209S.key.pem' }
  let(:pac_provider){ 'FacturacionModerna' }
  let(:bill) do
    {
      factura: {
        folio: 4,
        serie: 'AA',
        fecha: Time.now,
        formaDePago:        'Pago en una sola exhibicion',
        condicionesDePago:  'Contado',
        metodoDePago:       'Cheque',
        lugarExpedicion:    'San Pedro Garza Garcia, Nuevo Leon, Mexico',
        NumCtaPago:         'No identificado',
        moneda:             'MXN'
      },
      conceptos: [
        { cantidad:         3,
          unidad:           'PIEZA',
          descripcion:      'CAJA DE HOJAS BLANCAS TAMANO CARTA',
          valorUnitario:    450.00,
          importe:          1350.00
        },
        { cantidad:         8,
          unidad:           'PIEZA',
          descripcion:      'RECOPILADOR PASTA DURA 3 ARILLOS',
          valorUnitario:    18.50,
          importe:          148.00
        },
      ],
      emisor: {
        rfc:                'TUMG620310R95',
        nombre:             'FACTURACION MODERNA SA DE CV',
        domicilioFiscal: {
          calle:            'RIO GUADALQUIVIR',
          noExterior:       '238',
          noInterior:       '314',
          colonia:          'ORIENTE DEL VALLE',
          localidad:        'No se que sea esto, pero va',
          referencia:       'Sin Referencia',
          municipio:        'San Pedro Garza Garcia',
          estado:           'Nuevo Leon',
          pais:             'Mexico',
          codigoPostal:     '66220'
        },
        expedidoEn: {
          calle:            'RIO GUADALQUIVIR',
          noExterior:       '238',
          noInterior:       '314',
          colonia:          'ORIENTE DEL VALLE',
          localidad:        'No se que sea esto, pero va',
          referencia:       'Sin Referencia',
          municipio:        'San Pedro Garza Garcia',
          estado:           'Nuevo Leon',
          pais:             'Mexico',
          codigoPostal:     '66220'
        },
        regimenFiscal:      'REGIMEN GENERAL DE LEY PERSONAS MORALES'
      },
      emisor_pass:          '12345678a',
      cliente: {
        rfc:                'XAXX010101000',
        nombre:             'PUBLICO EN GENERAL',
        domicilioFiscal: {
          calle:            'CERRADA DE AZUCENAS',
          noExterior:       '109',
          colonia:          'REFORMA',
          municipio:        'Oaxaca de Juarez',
          estado:           'Oaxaca',
          pais:             'Mexico',
          codigoPostal:     '68050'
        }
      },
      impuestos: {
        impuesto:           'IVA'
      }
    }
  end

  describe '.stamp_bill' do
    context 'When request for stamp a bill with FM' do
      it 'returns a valid respose' do
        expect(subject.stamp_bill(user_keys,
                                  pac_provider,
                                  sat_certificate,
                                  sat_key,
                                  bill)).to include('cfdi:Comprobante xmlns:cfdi="http://www.sat.gob.mx/cfd/3"')
      end
    end
  end

end
