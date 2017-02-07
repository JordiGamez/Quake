//
//  FiltrarViewController.swift
//  Quake
//
//  Created by Jordi Gamez on 4/2/17.
//  Copyright © 2017 Jordi Gamez. All rights reserved.
//

import UIKit

// Enumeración de los meses del año
enum Meses: String {
    case Enero = "Enero"
    case Febrero = "Febrero"
    case Marzo = "Marzo"
    case Abril = "Abril"
    case Mayo = "Mayo"
    case Junio = "Junio"
    case Julio = "Julio"
    case Agosto = "Agosto"
    case Septiembre = "Septiembre"
    case Octubre = "Octubre"
    case Noviembre = "Noviembre"
    case Diciembre = "Diciembre"
}

class FiltrarViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // IBoutlet
    @IBOutlet weak var topBar: UINavigationItem!
    @IBOutlet weak var botonEliminar: UIBarButtonItem!
    @IBOutlet weak var magnitud: UILabel!
    @IBOutlet weak var sliderMagnitud: UISlider!
    @IBOutlet weak var terremotos: UILabel!
    @IBOutlet weak var stepperNumeroTerremotos: UIStepper!
    @IBOutlet weak var profundidad: UILabel!
    @IBOutlet weak var sliderProfundidad: UISlider!
    @IBOutlet weak var pickerMeses: UIPickerView!
    @IBOutlet weak var pickerAños: UIPickerView!
    
    // Variables
    var filtroMagnitud: String? = "0.0"
    var filtroTerremotos: String? = "400"
    var filtroProfundidad: String? = "0.0"
    var filtroMes: String = "Todos"
    var filtroAño: String = "Todos"
    var pickerDataMeses: [String] = [String]()
    var pickerDataAños: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.pickerMeses.delegate = self
        self.pickerMeses.dataSource = self
        
        self.pickerAños.delegate = self
        self.pickerAños.dataSource = self
        
        // Actualizo los valores de los filtros
        actualizarValores()
        
        // Añado el botón de reestablecer los filtros
        añadirBotonReestablecerFiltros()
        
        // Pongo los meses del año en el primer PickerView
        rellenarPickerViewMeses()
        
        // Pongo los años en el segundo PickerView
        rellenarPickerViewAños()
        
        // Pongo los PickerViews según como los había dejado el usuario en el filtro anteriormente
        let rowMeses: Int = calcularRowPickerMes(mes: filtroMes)
        let rowAños: Int = calcularRowPickerAño(año: filtroAño)
        pickerMeses.selectRow(rowMeses, inComponent: 0, animated: true)
        pickerAños.selectRow(rowAños, inComponent: 0, animated: true)
    }
    
    // Actualizamos los valores de los filtros por el valor actual para guardar los filtros
    func actualizarValores() {
        self.magnitud.text = filtroMagnitud
        self.sliderMagnitud.value = Float(filtroMagnitud!)!
        self.terremotos.text = filtroTerremotos
        self.stepperNumeroTerremotos.value = Double(Int(filtroTerremotos!)!)
        self.profundidad.text = filtroProfundidad
        self.sliderProfundidad.value = Float(filtroProfundidad!)!
    }
    
    // Consigo la posición en el PickerView de los meses según el mes seleccionado
    func calcularRowPickerMes(mes: String) -> Int {
        var rowMeses: Int = 0
        switch mes {
            case "Todos": rowMeses = 0
            case Meses.Enero.rawValue: rowMeses = 1
            case Meses.Febrero.rawValue: rowMeses = 2
            case Meses.Marzo.rawValue: rowMeses = 3
            case Meses.Abril.rawValue: rowMeses = 4
            case Meses.Mayo.rawValue: rowMeses = 5
            case Meses.Junio.rawValue: rowMeses = 6
            case Meses.Julio.rawValue: rowMeses = 7
            case Meses.Agosto.rawValue: rowMeses = 8
            case Meses.Septiembre.rawValue: rowMeses = 9
            case Meses.Octubre.rawValue: rowMeses = 10
            case Meses.Noviembre.rawValue: rowMeses = 11
            case Meses.Diciembre.rawValue: rowMeses = 12
            default: rowMeses = 0
        }
        return rowMeses
    }
    
    // Consigo la posición en el PickerView de los años según el mes seleccionado
    func calcularRowPickerAño(año: String) -> Int {
        var rowAños: Int = 0
        switch año {
            case "Todos": rowAños = 0
            case "2009": rowAños = 1
            case "2010": rowAños = 2
            case "2011": rowAños = 3
            case "2012": rowAños = 4
            case "2013": rowAños = 5
            default: rowAños = 0
        }
        return rowAños
    }
    
    // Añado el botón de reestablecer los filtros
    func añadirBotonReestablecerFiltros() {
        navigationItem.rightBarButtonItem = botonEliminar
    }
    
    // Añado el listado de meses al DatePicker de los meses
    func rellenarPickerViewMeses() {
        pickerDataMeses = ["Todos", Meses.Enero.rawValue, Meses.Febrero.rawValue, Meses.Marzo.rawValue, Meses.Abril.rawValue, Meses.Mayo.rawValue, Meses.Junio.rawValue, Meses.Julio.rawValue, Meses.Agosto.rawValue, Meses.Septiembre.rawValue, Meses.Octubre.rawValue, Meses.Noviembre.rawValue, Meses.Diciembre.rawValue]
    }
    
    // Añado el listado de años al DatePicker de los años
    func rellenarPickerViewAños() {
        pickerDataAños = ["Todos", "2009", "2010", "2011", "2012", "2013"]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerMeses {
            filtroMes = pickerDataMeses[row]
        } else {
            filtroAño = pickerDataAños[row]
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerMeses {
            return pickerDataMeses.count
        } else {
            return pickerDataAños.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerMeses {
            return pickerDataMeses[row]
        } else {
            return pickerDataAños[row]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Detectar cuando el usuario ha pulsado en el botón de Filtrar
    @IBAction func botonFiltrarPulsado(_ sender: UIButton) {
        filtroMagnitud = self.magnitud.text
        
    }
    
    // Detectar cuando el usuario está moviendo el Slider de la magnitud
    @IBAction func sliderMagnitudCambiado(_ sender: UISlider) {
        self.magnitud.text = String(roundf(sender.value * 2.0) * 0.5)
        filtroMagnitud = self.magnitud.text
    }
    
    // Detectar cuando el usuario está moviendo el Stepper del número de terremotos
    @IBAction func stepperTerremotosCambiado(_ sender: UIStepper) {
        self.terremotos.text = String(Int(sender.value))
        filtroTerremotos = self.terremotos.text
    }
    
    // Detectar cuando el usuario está moviendo el Slider de la profundidad
    @IBAction func sliderProfundidadCambiado(_ sender: UISlider) {
        //self.profundidad.text = String(Int(sender.value))
        self.profundidad.text = String(roundf(sender.value * 2.0) * 0.5)
        filtroProfundidad = self.profundidad.text
    }
    
    // Detectar cuando el usuario ha pulsado el botón de reestablecer los filtros
    @IBAction func botonEliminarFiltros(_ sender: UIBarButtonItem) {
        self.magnitud.text = "0.0"
        self.terremotos.text = "400"
        self.profundidad.text = "0.0"
        self.sliderMagnitud.setValue(0.0, animated: true)
        self.sliderProfundidad.setValue(0.0, animated: true)
        self.stepperNumeroTerremotos.value = 400
        filtroMagnitud = self.magnitud.text
        filtroTerremotos = self.terremotos.text
        filtroProfundidad = self.profundidad.text
        self.pickerMeses.selectRow(0, inComponent: 0, animated: true)
        self.pickerAños.selectRow(0, inComponent: 0, animated: true)
        self.filtroMes = "Todos"
        self.filtroAño = "Todos"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
