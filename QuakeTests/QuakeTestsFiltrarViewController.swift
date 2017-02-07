//
//  QuakeTestsFiltrarViewController.swift
//  Quake
//
//  Created by Jordi Gamez on 6/2/17.
//  Copyright © 2017 Jordi Gamez. All rights reserved.
//

import XCTest
@testable import Quake

class QuakeTestsFiltrarViewController: XCTestCase {
    
    // FiltrarViewController
    var viewController: Quake.FiltrarViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // Inicializo el FiltrarViewController
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateViewController(withIdentifier: "FiltroViewController") as! Quake.FiltrarViewController //
        viewController.loadView()
        viewController.viewDidLoad()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Test de la función calcularRowPickerMes
    func testCalcularRowPickerMes() {
        XCTAssertEqual(viewController.calcularRowPickerMes(mes: "Todos"), 0)
        XCTAssertEqual(viewController.calcularRowPickerMes(mes: Meses.Enero.rawValue), 1)
        XCTAssertEqual(viewController.calcularRowPickerMes(mes: Meses.Febrero.rawValue), 2)
        XCTAssertEqual(viewController.calcularRowPickerMes(mes: Meses.Marzo.rawValue), 3)
        XCTAssertEqual(viewController.calcularRowPickerMes(mes: Meses.Abril.rawValue), 4)
        XCTAssertEqual(viewController.calcularRowPickerMes(mes: Meses.Mayo.rawValue), 5)
        XCTAssertEqual(viewController.calcularRowPickerMes(mes: Meses.Junio.rawValue), 6)
        XCTAssertEqual(viewController.calcularRowPickerMes(mes: Meses.Julio.rawValue), 7)
        XCTAssertEqual(viewController.calcularRowPickerMes(mes: Meses.Agosto.rawValue), 8)
        XCTAssertEqual(viewController.calcularRowPickerMes(mes: Meses.Septiembre.rawValue), 9)
        XCTAssertEqual(viewController.calcularRowPickerMes(mes: Meses.Octubre.rawValue), 10)
        XCTAssertEqual(viewController.calcularRowPickerMes(mes: Meses.Noviembre.rawValue), 11)
        XCTAssertEqual(viewController.calcularRowPickerMes(mes: Meses.Diciembre.rawValue), 12)
    }
    
    // Test de la función calcularRowPickerAño
    func testCalcularRowPickerAño() {
        XCTAssertEqual(viewController.calcularRowPickerAño(año: "Todos"), 0)
        XCTAssertEqual(viewController.calcularRowPickerAño(año: "2009"), 1)
        XCTAssertEqual(viewController.calcularRowPickerAño(año: "2010"), 2)
        XCTAssertEqual(viewController.calcularRowPickerAño(año: "2011"), 3)
        XCTAssertEqual(viewController.calcularRowPickerAño(año: "2012"), 4)
        XCTAssertEqual(viewController.calcularRowPickerAño(año: "2013"), 5)
    }
}
