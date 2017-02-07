//
//  QuakeTestsViewController.swift
//  Quake
//
//  Created by Jordi Gamez on 6/2/17.
//  Copyright © 2017 Jordi Gamez. All rights reserved.
//

import XCTest
@testable import Quake

class QuakeTestsViewController: XCTestCase {
    
    // ViewController
    var viewController: Quake.ViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // Inicializo el ViewController
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateViewController(withIdentifier: "MapaViewController") as! Quake.ViewController //
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
    
    // Test de la función conseguirNumeroFiltroMes
    func testConseguirNumeroFiltroMes() {
        XCTAssertEqual(viewController.conseguirNumeroFiltroMes(filtro: "Todos"), "")
        XCTAssertEqual(viewController.conseguirNumeroFiltroMes(filtro: Meses.Enero.rawValue), "01")
        XCTAssertEqual(viewController.conseguirNumeroFiltroMes(filtro: Meses.Febrero.rawValue), "02")
        XCTAssertEqual(viewController.conseguirNumeroFiltroMes(filtro: Meses.Marzo.rawValue), "03")
        XCTAssertEqual(viewController.conseguirNumeroFiltroMes(filtro: Meses.Abril.rawValue), "04")
        XCTAssertEqual(viewController.conseguirNumeroFiltroMes(filtro: Meses.Mayo.rawValue), "05")
        XCTAssertEqual(viewController.conseguirNumeroFiltroMes(filtro: Meses.Junio.rawValue), "06")
        XCTAssertEqual(viewController.conseguirNumeroFiltroMes(filtro: Meses.Julio.rawValue), "07")
        XCTAssertEqual(viewController.conseguirNumeroFiltroMes(filtro: Meses.Agosto.rawValue), "08")
        XCTAssertEqual(viewController.conseguirNumeroFiltroMes(filtro: Meses.Septiembre.rawValue), "09")
        XCTAssertEqual(viewController.conseguirNumeroFiltroMes(filtro: Meses.Octubre.rawValue), "10")
        XCTAssertEqual(viewController.conseguirNumeroFiltroMes(filtro: Meses.Noviembre.rawValue), "11")
        XCTAssertEqual(viewController.conseguirNumeroFiltroMes(filtro: Meses.Diciembre.rawValue), "12")
    }
    
    // Test de la función construirURL
    func testConstruirURL() {
        XCTAssertEqual(viewController.construirURL(filtroMes: "", filtroAño: ""), "http://www.seismi.org/api/eqs/")
        XCTAssertEqual(viewController.construirURL(filtroMes: "01", filtroAño: "2012"), "http://www.seismi.org/api/eqs/2012/01")
        XCTAssertEqual(viewController.construirURL(filtroMes: "02", filtroAño: "2012"), "http://www.seismi.org/api/eqs/2012/02")
        XCTAssertEqual(viewController.construirURL(filtroMes: "03", filtroAño: "2012"), "http://www.seismi.org/api/eqs/2012/03")
        XCTAssertEqual(viewController.construirURL(filtroMes: "04", filtroAño: "2012"), "http://www.seismi.org/api/eqs/2012/04")
        XCTAssertEqual(viewController.construirURL(filtroMes: "05", filtroAño: "2012"), "http://www.seismi.org/api/eqs/2012/05")
        XCTAssertEqual(viewController.construirURL(filtroMes: "06", filtroAño: "2012"), "http://www.seismi.org/api/eqs/2012/06")
        XCTAssertEqual(viewController.construirURL(filtroMes: "07", filtroAño: "2012"), "http://www.seismi.org/api/eqs/2012/07")
        XCTAssertEqual(viewController.construirURL(filtroMes: "08", filtroAño: "2012"), "http://www.seismi.org/api/eqs/2012/08")
        XCTAssertEqual(viewController.construirURL(filtroMes: "09", filtroAño: "2012"), "http://www.seismi.org/api/eqs/2012/09")
        XCTAssertEqual(viewController.construirURL(filtroMes: "10", filtroAño: "2012"), "http://www.seismi.org/api/eqs/2012/10")
        XCTAssertEqual(viewController.construirURL(filtroMes: "11", filtroAño: "2012"), "http://www.seismi.org/api/eqs/2012/11")
        XCTAssertEqual(viewController.construirURL(filtroMes: "12", filtroAño: "2012"), "http://www.seismi.org/api/eqs/2012/12")
    }
}
