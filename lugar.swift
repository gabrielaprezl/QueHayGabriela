//
//  lugar.swift
//  Integracionwp
//
//  Created by Maestro on 04/11/16.
//  Copyright © 2016 Maestro. All rights reserved.
// NSDictionary es para varios elementos cosas que vienen dentro de llaves

import Foundation
import UIKit
import Alamofire

class Lugar{
    var titulo : String
    var descripcion : String
    var direccion : String
    var telefono : String
    
    
    var urlFoto : String?
    var imgFoto : UIImage?
    
    var urlThumbnail : String?
    var imgThumbnail : UIImage?
    
    var urlFotoDetalle : String?
    var imgFotoDetalle : UIImage?
    var urlThumbnailDetalle : String?
    var imgThumbnailDetalle : UIImage?
    
    init(){
        titulo = ""
        descripcion = ""
        direccion = ""
        telefono = ""
        
    }
    
    init(diccionario : NSDictionary, callback: (() -> Void)?){
        titulo = ""
        descripcion = ""
        direccion = ""
        telefono = ""
        
        
        if let titulo = diccionario.valueForKey("title_plain") as? String{
            self.titulo = titulo
        }
        
        if let customFields = diccionario.valueForKey("custom_fields") as? NSDictionary{
            if let direccion = customFields.valueForKey("direccion") as? NSArray{
                if let valorDireccion = direccion[0] as? String{
                    self.direccion = valorDireccion
                }
            }
        
        
            if let telefono = customFields.valueForKey("telefono") as? NSArray{
                if let valorTelefono = telefono [0] as? String{
                    self.telefono = valorTelefono
                }
            }
            
            if let descripcion = customFields.valueForKey("descripcion") as? NSArray{
                if let valorDescripcion = descripcion[0] as? String{
                    self.descripcion = valorDescripcion
                }
            }
            
        }
        
        if let attachments = diccionario.valueForKey("attachments") as? NSArray{
            if attachments.count > 0 {
                if let imagen = attachments[0] as? NSDictionary{
                    if let urlImagen = imagen.valueForKey("url") as? String{
                        self.urlFoto = urlImagen
                    }
                    
                    
                    if let images = imagen.valueForKey("images") as? NSDictionary{
                        if let thumbnail = images.valueForKey("thumbnail") as? NSDictionary{
                            if let valorThumbnail = thumbnail.valueForKey("url") as? String{
                                self.urlThumbnail = valorThumbnail
                            }
                        }
                    }
                }
                if let imagenDetalle = attachments[1] as? NSDictionary{
                    if let urlImagenDetalle = imagenDetalle.valueForKey("url") as? String{
                        self.urlFotoDetalle = urlImagenDetalle
                    }
                }
            }
            
            
            
        }
        if let urlFoto = self.urlFoto {
            Alamofire.request(.GET, urlFoto , parameters: [:]).responseData(completionHandler: { response in
                if let data = response.data{
                    self.imgFoto = UIImage(data: data)
                    if let funcionCallBack = callback {
                        funcionCallBack()
                    }
                } else{
                    self.imgFoto = UIImage(named: "desconocido")
                }
            })
        
        } else{
            self.imgFoto = UIImage(named: "desconocido")
        }
        
    
        if let urlFotoDetalle = self.urlFotoDetalle{
            Alamofire.request(.GET, urlFotoDetalle, parameters: [:]).responseData(completionHandler: { response in if let dataD = response.data{
                self.imgFotoDetalle = UIImage(data: dataD)
                if let funcionCallBackD = callback{
                    funcionCallBackD()
                }
            } else{
                self.imgFotoDetalle = UIImage(named: "desconocido")
                }
            } )
        } else{
        self.imgFotoDetalle = UIImage(named: "desconocido")
        }
    
    }







}
