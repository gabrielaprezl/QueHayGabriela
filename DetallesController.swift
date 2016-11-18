//
//  DetallesController.swift
//  Integracionwp
//
//  Created by Maestro on 15/11/16.
//  Copyright © 2016 Maestro. All rights reserved.
//

import Foundation
import UIKit

class DetallesController : UIViewController {
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblDireccion: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var lblTelefono: UILabel!
    @IBOutlet weak var lblFotoDetalle: UIImageView!
    
    var lugar : Lugar?
    override func viewDidLoad() {
        self.title = lugar?.titulo
        if let lugar = self.lugar{
            lblTitulo.text = lugar.titulo
            lblTitulo.lineBreakMode = NSLineBreakMode.ByWordWrapping
            lblTitulo.numberOfLines = 0
            lblTitulo.sizeToFit()
            
            lblDireccion.text = lugar.direccion
            lblDireccion.lineBreakMode = NSLineBreakMode.ByWordWrapping
            lblDireccion.numberOfLines = 0
            lblDireccion.sizeToFit()
            lblDescripcion.text = lugar.descripcion
            lblDescripcion.lineBreakMode = NSLineBreakMode.ByWordWrapping
            lblDescripcion.numberOfLines = 0
            lblDescripcion.sizeToFit()
            lblTelefono.text = lugar.telefono
            lblFotoDetalle.image = lugar.imgFotoDetalle
        }
    }
}