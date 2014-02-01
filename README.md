# FacturacionElectronica

This a gem to dispatch a request of a new CFDi(comprobante fiscal
digital) through a different PAC() providers. Right now we connecting to the
FacturacionModerna web service.

## Installation

Add this line to your application's Gemfile:

    gem 'facturacion_electronica'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install facturacion_electronica

## Usage

You need to send a request with:
- user keys: This is used for the PAC provider that you specify, the
  internal structure of this hash allows it.
- PAC provider: When you send a new CFDi bill request you need to
  specify the PAC provider. Currently we support FacturacionModerna.
- biller: Here we send the official documents, the ones provided by SAT to the
  billers.
- bill: All the information about the bill that is requested to be
  stamped through the PAC provider.

Request to rining a CFDI:
```
{ user_keys: {
    id:              'UsuarioPruebasWS',
    password:        'b9ec2afa3361a59af4b4d102d3f704eabdf097d4',
    namespace:       'https://t2demo.facturacionmoderna.com/timbrado/soap',
    endpoint:        'https://t2demo.facturacionmoderna.com/timbrado/soap',
    wsdl:            'https://t2demo.facturacionmoderna.com/timbrado/wsdl',
    log:             false,
    ssl_verify_mode: :none },
  pac_provider: 'FacturacionModerna',  
  biller: {
    certificate: CertificateFile.cer,
    key:         KeyFile.key.pem,
    password:    'billerpass'
  } 
  bill: {
    {
      factura: {
        folio:              '101',
        serie:              'AA',
        fecha:              CurrentDate,
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
      emisor_pass:          'billerpass',
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
  }
}
```

Response:
```
{ 
  status: true / false,
  xml: bill_xml_file,
  stamp: sat_stamp_file,
  pdf: bill_pdf_file
}
```

Request to cancel a CFDI:
```
{
  user_keys: {
    id:              'UsuarioPruebasWS',
    password:        'b9ec2afa3361a59af4b4d102d3f704eabdf097d4',
    namespace:       'https://t2demo.facturacionmoderna.com/timbrado/soap',
    endpoint:        'https://t2demo.facturacionmoderna.com/timbrado/soap',
    wsdl:            'https://t2demo.facturacionmoderna.com/timbrado/wsdl',
    log:             false,
    ssl_verify_mode: :none },
  pac_provider: 'FacturacionModerna',
  biller: {
    rfc: 'TUMG620310R95'
  },
  UUID: 'ASDD-1123-BDFT'
}
```

Request to register SAT keys(FacturacionModerna example):
```
{
  user_keys: {
    id:              'UsuarioPruebasWS',
    password:        'b9ec2afa3361a59af4b4d102d3f704eabdf097d4',
    namespace:       'https://t2demo.facturacionmoderna.com/timbrado/soap',
    endpoint:        'https://t2demo.facturacionmoderna.com/timbrado/soap',
    wsdl:            'https://t2demo.facturacionmoderna.com/timbrado/wsdl',
    log:             false,
    ssl_verify_mode: :none },
  pac_provider: 'FacturacionModerna',
  biller: {
    rfc:          'TUMG620310R95',
    certificate:  CertificateFile.cer,
    key:          KeyFile.key.pem,
    password:     'billerpass'
  }
}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
