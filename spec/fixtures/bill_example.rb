module BillExample
  def self.request
    {
      factura: {
        folio:              [101, 102, 103, 104, 105].sample,
        serie:              ['AA', 'BB', 'CC', 'DD'].sample,
        fecha:              Time.now,
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
end
