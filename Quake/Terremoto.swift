//
//  Terremoto.swift
//  Quake
//
//  Created by Jordi Gamez on 4/2/17.
//  Copyright © 2017 Jordi Gamez. All rights reserved.
//

// Clase Terremoto
class Terremoto {
    
    // Atributos
    var region: String = ""
    var latitud: Double = 0.0
    var longitud: Double = 0.0
    var magnitud: Float = 0.0
    var fecha: String = ""
    var profundidad: Float = 0.0
    
    // Inicializador
    init(region: String, latitud: Double, longitud: Double, magnitud: Float, fecha: String, profundidad: Float) {
        // Pongo la región en mayúscula
        self.region = region.capitalized
        self.latitud = latitud
        self.longitud = longitud
        self.magnitud = magnitud
        // Pongo la fecha en el formato (dd/mm/yyyy)
        self.fecha = arreglarFormatoFecha(fecha: fecha)
        self.profundidad = profundidad
    }
    
    // Funcion icono() - Consigo el icono del terremoto según su magnitud
    func icono() -> UIImage {
        var nombreIcono: String = "magnitud-micro.png"
        switch magnitud {
            case 0...2.0: nombreIcono = "magnitud-micro.png"; break
            case 2.1...3.9: nombreIcono = "magnitud-menor.png"; break
            case 4...4.9: nombreIcono = "magnitud-ligero.png"; break
            case 5...5.9: nombreIcono = "magnitud-moderado.png"; break
            case 6...6.9: nombreIcono = "magnitud-fuerte.png"; break
            case 7...7.9: nombreIcono = "magnitud-mayor.png"; break
            case 8...9.9: nombreIcono = "magnitud-grande.png"; break
            case 10: nombreIcono = "magnitud-legendario.png"; break
            default: nombreIcono = "magnitud-micro.png"; break
        }
        return UIImage(named: nombreIcono)!
    }
    
    // función arreglarFormatoFecha() - Arreglo el formato de la fecha para mostrarla correctamente
    func arreglarFormatoFecha(fecha: String) -> String {
        var fechaSeparada = String(describing: fecha).components(separatedBy: " ")
        let fechaSeparadaUno = String(describing: fechaSeparada[0]).components(separatedBy: "-")
        let año: String = fechaSeparadaUno[0]
        let mes: String = fechaSeparadaUno[1]
        let dia: String = fechaSeparadaUno[2]
        
        return String("\(dia)-\(mes)-\(año) \(fechaSeparada[1])")
    }
}
