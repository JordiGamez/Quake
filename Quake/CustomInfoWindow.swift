//
//  CustomInfoWindow.swift
//  Quake
//
//  Created by Jordi Gamez on 4/2/17.
//  Copyright © 2017 Jordi Gamez. All rights reserved.
//

import UIKit

// Este UIView mostrará la información del marcador cuando sea seleccionado
class CustomInfoWindow: UIView {
    
    // IBOutlet
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var magnitud: UILabel!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var profundidad: UILabel!
    @IBOutlet weak var imagenDeFondo: UIImageView!
    
    // Mediante esta función calculo cuál es la imagen de fondo para cada marcador según su magnitud
    func calcularImagenDeFondo(magnitudText: String) {
        var imagenDeFondoString: String = "infowindow-magnitud-micro.png"
        switch Double(magnitudText)! {
            case 0...2.0: imagenDeFondoString = "infowindow-magnitud-micro.png"; break
            case 2.1...3.9: imagenDeFondoString = "infowindow-magnitud-menor.png"; break
            case 4...4.9: imagenDeFondoString = "infowindow-magnitud-ligero.png"; break
            case 5...5.9: imagenDeFondoString = "infowindow-magnitud-moderado.png"; break
            case 6...6.9: imagenDeFondoString = "infowindow-magnitud-fuerte.png"; break
            case 7...7.9: imagenDeFondoString = "infowindow-magnitud-mayor.png"; break
            case 8...9.9: imagenDeFondoString = "infowindow-magnitud-grande.png"; break
            case 10: imagenDeFondoString = "infowindow-magnitud-legendario.png"; break
            default: imagenDeFondoString = "infowindow-magnitud-micro.png"; break
        }
        imagenDeFondo.image = UIImage(named: imagenDeFondoString)
    }
}
