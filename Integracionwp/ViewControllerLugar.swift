//
//  ViewController.swift
//  Integracionwp
//
//  Created by Maestro on 03/11/16.
//  Copyright © 2016 Maestro. All rights reserved.
//

import UIKit
import Alamofire

class ViewControllerLugar : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var lugares : [Lugar] = []
    
    @IBOutlet weak var tvLugares: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //https://quehayobregon.azurewebsites.net/api/get_posts/?post_type=lugar
        
        
        //Imprimir la direccion del primer lugar
    
        Alamofire.request(.GET, "https://quehayobregon.azurewebsites.net/api/get_posts/", parameters: ["post_type": "lugar"])
            .responseJSON { response in
                if let diccionarioRespuesta = response.result.value as? NSDictionary {
                    //String(diccionarioRespuesta.valueForKey("count_total") as! Int)
                    if let posts = diccionarioRespuesta.valueForKey("posts") as? NSArray{
                        for post in posts {
                            if let diccionarioPost = post as? NSDictionary{
                                self.lugares.append(Lugar(diccionario: diccionarioPost, callback: self.actualizarTableViewLugares))
                            }
                        }
                        self.tvLugares.reloadData()
                        /*var cadena = ""
                        for lugar in self.lugares{
                            cadena += lugar.direccion
                        }
                        self.lblDireccion.text = cadena*/
                    }
                }
        }
     }
    
    func actualizarTableViewLugares(){
        tvLugares.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lugares.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCellWithIdentifier("celdaLugar") as! LugarCelda
        celda.lblNombre.text = lugares[indexPath.row].titulo
        
        celda.lblNombre.lineBreakMode = NSLineBreakMode.ByWordWrapping
        celda.lblNombre.numberOfLines = 0
        celda.lblNombre.sizeToFit()
        
        if let imagen = lugares[indexPath.row].imgFoto{
            celda.imgFondo.image = imagen
        }
        
        return celda
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToDetalles"{
            let detallesController = segue.destinationViewController as! DetallesController
            detallesController.lugar = lugares[(tvLugares.indexPathForSelectedRow?.row)!]
        }
    }

}

