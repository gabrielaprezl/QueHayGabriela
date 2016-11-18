//
//  DetallesControllerEvento.swift
//  Integracionwp
//
//  Created by Maestro on 16/11/16.
//  Copyright © 2016 Maestro. All rights reserved.
//

import Foundation
import UIKit

class DetallesControllerEvento : UIViewController  {
    
    @IBOutlet weak var lblDireccion: UILabel!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var lblHora: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var imgDetalle: UIImageView!
    
    @IBOutlet weak var imgFiltro: UIImageView!
    
    var evento : Evento?
    
    override func viewDidLoad() {
        
        self.title = evento?.titulo
        
        if let evento = self.evento{
            lblTitulo.text = evento.titulo
            lblTitulo.lineBreakMode = NSLineBreakMode.ByWordWrapping
            lblTitulo.numberOfLines = 0
            lblTitulo.sizeToFit()
            
            lblDireccion.text = evento.direccion
            lblFecha.text = evento.fecha
            lblHora.text = evento.horario
            lblPrecio.text = evento.precio
            lblDireccion.lineBreakMode = NSLineBreakMode.ByWordWrapping
            lblDireccion.numberOfLines = 0
            lblDireccion.sizeToFit()
            lblDescripcion.text = evento.descripcion
            lblDescripcion.lineBreakMode = NSLineBreakMode.ByWordWrapping
            lblDescripcion.numberOfLines = 0
            lblDescripcion.sizeToFit()
            imgDetalle.image = evento.imgFotoDetalle
            imgFiltro.image = UIImage(named: "degradado")
            
        }
    }
    
}