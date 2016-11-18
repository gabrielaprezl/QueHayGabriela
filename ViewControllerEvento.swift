//
//  ViewControllerEvento.swift
//  Integracionwp
//
//  Created by Maestro on 15/11/16.
//  Copyright © 2016 Maestro. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ViewControllerEvento : UIViewController, UITableViewDataSource, UITableViewDelegate{
    var eventos : [Evento] = []
    @IBOutlet weak var TvEventos: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //http://quehayobregon.azurewebsites.net/api/get_posts/?post_type=evento
        
        Alamofire.request(.GET, "https://quehayobregon.azurewebsites.net/api/get_posts/", parameters: ["post_type": "evento"])
            .responseJSON { response in
                if let diccionarioRespuesta = response.result.value as? NSDictionary {
                    if let posts = diccionarioRespuesta.valueForKey("posts") as? NSArray{
                        for post in posts {
                            if let diccionarioPost = post as? NSDictionary{
                                self.eventos.append(Evento(diccionario: diccionarioPost, callback: self.actualizarTableViewEventos))
                            }
                        }
                        self.TvEventos.reloadData()
                    }
            }
      }
    }
    
    func actualizarTableViewEventos(){
        TvEventos.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let celdaE = tableView.dequeueReusableCellWithIdentifier("celdaEvento") as! EventoCelda
        celdaE.lblNombreEvento.text = eventos[indexPath.row].titulo
        
        celdaE.lblNombreEvento.lineBreakMode = NSLineBreakMode.ByWordWrapping
        celdaE.lblNombreEvento.numberOfLines = 0
        celdaE.lblNombreEvento.sizeToFit()
        
        if let imagen = eventos[indexPath.row].imgFoto{
            celdaE.imgFondoEvento.image = imagen
        }
        
        return celdaE
     }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToDetallesEvento"{
            let detallesControllerEvento = segue.destinationViewController as! DetallesControllerEvento
            detallesControllerEvento.evento = eventos[(TvEventos.indexPathForSelectedRow?.row)!]
        }
    }
}