//
//  ViewController.swift
//  Quake
//
//  Created by Jordi Gamez on 4/2/17.
//  Copyright © 2017 Jordi Gamez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    // IBOutlet
    @IBOutlet weak var iconoFiltrar: UIBarButtonItem?
    @IBOutlet weak var fraseError: UILabel!
    
    // Constantes
    let jsonHandler: String = "earthquakes"
    let keyLatitude: String = "lat"
    let keyLongitude: String = "lon"
    let keyMagnitude: String = "magnitude"
    let keyDepth: String = "depth"
    let keyRegion: String = "region"
    let keyTimedate: String = "timedate"
    let parametroLimite: String = "limit"
    let parametroMagnitudMinima: String = "min_magnitude"
    
    // Variables
    var mapView: GMSMapView? = nil
    var filtroMagnitud: String = "0.0"
    var filtroTerremotos: String = "400"
    var filtroProfundidad: String = "0.0"
    var filtroMes: String = ""
    var filtroAño: String = ""
    var locationManager = CLLocationManager()
    // Posición por defecto
    var latitude: Double = 41.3802104
    var longitude: Double = 2.1857693
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        // Muestro los terremotos recientes
        mostrarTerremotos()
    }
    
    // Mediante esta función consultamos la API
    func mostrarTerremotos(filtroMagnitud: Float = 0.0, filtroTerremotos: Int = 400, filtroProfundidad: Float = 0.0, filtroMes: String = "", filtroAño: String = "") {
        
        // Preguntamos al usuario (si no lo ha hecho previamente) para compartir su ubicación con la App
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        // Si el usuario ha aceptado compartir su ubicación con la App
        if CLLocationManager.locationServicesEnabled() {
            
            // Conseguimos su posición con su latitud y longitud
            let locValue = locationManager.location?.coordinate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
            // Si la posición del usuario no es nula
            if locationManager.location != nil {
                // Conseguimos la posición del ususario
                latitude = (locValue?.latitude)!
                longitude = (locValue?.longitude)!
            }
            
            // Centramos el mapa en la posición de latitud y longitud
            let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 6)
            let rect = CGRect(origin: CGPoint(x: 0,y : 0), size: CGSize(width: self.view.bounds.width, height: (self.view.bounds.height)))
            let mapView = GMSMapView.map(withFrame: rect, camera: camera)
            mapView.isMyLocationEnabled = true
            mapView.delegate = self
            self.view.addSubview(mapView)
            
            // Construyo la URL según los filtros del usuario
            let url: String = construirURL(filtroMes: filtroMes, filtroAño: filtroAño)
            
            // Creamos los parametros con los valores que el usuario ha seleccionado
            let parametros: Parameters = [parametroLimite: filtroTerremotos, parametroMagnitudMinima: filtroMagnitud]
            
            // Hago la consulta a la API
            Alamofire.request(url, parameters: parametros).validate().responseJSON { response in
                switch response.result {
                
                // Si ia conexión ha sido correcta
                case .success:
                    
                    // Guardo en la variable json la respuesta de la API
                    let json = JSON(data: response.data!)
                    
                    // Envío el JSON resultado para leerlo, crear los obejtos Terremoto y poner los marcadores en el mapa
                    self.parseJSON(json: json, mapView: mapView, profundidad: filtroProfundidad)
                    
                // Si ha ocurrido un problema, mostrar un mensaje en pantalla para el usuario
                case .failure:
                    self.mostrarAlertError()
                }
            }
        }
    }
    
    // Leo el JSON que me ha devuelto la consulta a la API y voy creando los marcadores
    func parseJSON(json: JSON, mapView: GMSMapView, profundidad: Float) {
        
        // Compruebo que el contador de terremotos es más grande que 0
        if (json[self.jsonHandler].count > 0) {
            
            // Voy recorriendo cada entrada del JSON y almaceno cada atributo en una variable
            for result in json[self.jsonHandler].arrayValue {
                
                let latitude: String = result[self.keyLatitude].stringValue
                let longitude: String = result[self.keyLongitude].stringValue
                let magnitude: Float = Float(result[self.keyMagnitude].stringValue)!
                let depth: String = result[self.keyDepth].stringValue
                let region: String = result[self.keyRegion].stringValue
                let timedate: String = result[self.keyTimedate].stringValue
                
                // Creo el objeto Terremoto con todos sus atributos
                let terremoto = Terremoto(region: region, latitud: Double(latitude)!, longitud: Double(longitude)!, magnitud: magnitude, fecha: timedate, profundidad: Float(depth)!)
                
                // Filtrar por la profundidad mínima
                if (terremoto.profundidad >= profundidad) {
                    
                    // Creo un array para agrupar la información adicional para mostrar en el marcador
                    var array = [String]()
                    array.append(terremoto.fecha)
                    array.append(String(terremoto.profundidad))
                    
                    // Creo el marcador con los atributos del objeto Terremoto
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2DMake(terremoto.latitud, terremoto.longitud)
                    marker.title = terremoto.region
                    marker.snippet = String(terremoto.magnitud)
                    marker.userData = "\(terremoto.fecha)_\(terremoto.profundidad)"
                    marker.icon = terremoto.icono()
                    marker.infoWindowAnchor = CGPoint(x: 0.50, y : 0.30)
                    marker.map = mapView
                }
            }
        } else {
            // Cuando el contador de terremotos es 0, muestro un alert por pantalla
            self.mostrarAlertCeroTerremotos()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Cuando el usuario ha modificado su permiso para compartir su ubicación con la App
        switch status {
            case .notDetermined: locationManager.requestAlwaysAuthorization()
            case .authorizedWhenInUse: self.mostrarTerremotos()
            case .authorizedAlways: self.mostrarTerremotos()
            case .restricted: self.mostrarTerremotos()
            case .denied: self.mostrarTerremotos()
        }
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        // Recibo la variable userData para posteriormente encontrar la variable de fecha y la profundidad
        var terremotoInfo = String(describing: marker.userData!).components(separatedBy: "_")
        let fecha: String = terremotoInfo[0]
        let profundidad: String = terremotoInfo[1]
        
        // Hago la llamada al View llamado "xibInfoWindow" para mostrar el CustomInfoWindow al pulsar en un icono
        let infoWindow = Bundle.main.loadNibNamed("InfoWindow", owner: self, options: nil)?.first as! CustomInfoWindow
        infoWindow.region.text = marker.title
        infoWindow.magnitud.text = "Magnitud: \(marker.snippet!)"
        infoWindow.fecha.text = "Fecha: \(String(fecha)!)"
        infoWindow.profundidad.text = "Profundidad: \(profundidad)"
        infoWindow.calcularImagenDeFondo(magnitudText: marker.snippet!)
        
        return infoWindow
    }
    
    // Mediante esta función, construyo la URL
    func construirURL(filtroMes: String, filtroAño: String) -> String {
        // Si el usuario ha filtrado por año
        var url: String = ""
        if (filtroAño != "") {
            url = "http://www.seismi.org/api/eqs/"+filtroAño
            // Si el usuario ha filtrado por mes
            if (filtroMes != "") {
                url = url+"/"+filtroMes
            }
        } else {
            url = "http://www.seismi.org/api/eqs/"
        }
        return url
    }
    
    // Mostrar alert por pantalla cuando no haya encontrado terremotos
    func mostrarAlertCeroTerremotos() {
        let alertController = UIAlertController(title: "No se han encontrado terremotos", message: "Inténtelo nuevamente con diferentes filtros", preferredStyle: UIAlertControllerStyle.alert)
        let confirmAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) in}
        alertController.addAction(confirmAction)
        // Muestro el alert
        present(alertController, animated: true, completion: nil)
    }
    
    // Mostrar error por pantalla
    func mostrarAlertError() {
        let alertController = UIAlertController(title: "Sin conexión", message: "Porfavor asegurese de que su dispositivo esta conectado a Internet", preferredStyle: UIAlertControllerStyle.alert)
        let confirmAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) in}
        alertController.addAction(confirmAction)
        // Muestro el alert
        present(alertController, animated: true, completion: nil)
    }
    
    // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "filtrar") {
            // Modifico el texto del botón "Volver"
            let backItem = UIBarButtonItem()
            backItem.title = "Volver"
            navigationItem.backBarButtonItem = backItem
            
            // Al hacer el Segue, envío el valor de los filtros para recuperar su valor y seguir filtrando desde donde el usuario lo dejó la última vez
            let filtrarViewController = (segue.destination as! FiltrarViewController)
            filtrarViewController.filtroMagnitud = filtroMagnitud
            filtrarViewController.filtroTerremotos = filtroTerremotos
            filtrarViewController.filtroProfundidad = filtroProfundidad
            filtrarViewController.filtroMes = filtroMes
            filtrarViewController.filtroAño = filtroAño
        }
    }
    
    // Unwind Segue
    @IBAction func unwindToThisView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? FiltrarViewController {
            
            // Recogemos los valores que nos envia la pantalla de los Filtros
            filtroMagnitud = sourceViewController.filtroMagnitud!
            filtroTerremotos = sourceViewController.filtroTerremotos!
            filtroProfundidad = sourceViewController.filtroProfundidad!
            filtroMes = sourceViewController.filtroMes
            filtroAño = sourceViewController.filtroAño
            
            // Transformo el mes seleccionado en el código que usa la API para determinar el mes
            let numeroFiltroMes: String = conseguirNumeroFiltroMes(filtro: filtroMes)
            
            if (filtroAño == "Todos") { filtroAño = "" }
            
            // Envio los filtros que ha seleccionado el usuario y recargo de nuevo la pantalla con los resultados
            mostrarTerremotos(filtroMagnitud: Float(filtroMagnitud)!, filtroTerremotos: Int(filtroTerremotos)!, filtroProfundidad: Float(filtroProfundidad)!, filtroMes: String(describing: numeroFiltroMes), filtroAño: String(describing: filtroAño))
        }
    }
    
    // Transformo el mes seleccionado en el código que usa la API para determinar el mes
    func conseguirNumeroFiltroMes(filtro: String) -> String {
        var numeroFiltroMes: String = ""
        if (filtro == "Todos") {
            numeroFiltroMes = ""
        } else {
            switch String(describing: filtro) {
                case Meses.Enero.rawValue: numeroFiltroMes = "01"
                case Meses.Febrero.rawValue: numeroFiltroMes = "02"
                case Meses.Marzo.rawValue: numeroFiltroMes = "03"
                case Meses.Abril.rawValue: numeroFiltroMes = "04"
                case Meses.Mayo.rawValue: numeroFiltroMes = "05"
                case Meses.Junio.rawValue: numeroFiltroMes = "06"
                case Meses.Julio.rawValue: numeroFiltroMes = "07"
                case Meses.Agosto.rawValue: numeroFiltroMes = "08"
                case Meses.Septiembre.rawValue: numeroFiltroMes = "09"
                case Meses.Octubre.rawValue: numeroFiltroMes = "10"
                case Meses.Noviembre.rawValue: numeroFiltroMes = "11"
                case Meses.Diciembre.rawValue: numeroFiltroMes = "12"
                default: numeroFiltroMes = ""
            }
        }
        return numeroFiltroMes
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
