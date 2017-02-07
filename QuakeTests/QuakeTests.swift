//
//  QuakeTests.swift
//  QuakeTests
//
//  Created by Jordi Gamez on 4/2/17.
//  Copyright © 2017 Jordi Gamez. All rights reserved.
//

import XCTest
@testable import Quake

class QuakeTests: XCTestCase {
    
    // Creo objeto Terremoto
    var terremoto: Terremoto!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // Inicializar el objeto Terremoto
        terremoto = Terremoto(region: "region", latitud: 20.0, longitud: 20.0, magnitud: 5.0, fecha: "2017-02-01 18:00:00", profundidad: 20.0)
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
    
    // Test de la clase Terremoto con su atributo region
    func testTerremotoRegion() {
        XCTAssertEqual(terremoto.region, "Region")
    }
    
    // Test de la clase Terremoto con su atributo latitud
    func testTerremotoLatitud() {
        XCTAssertEqual(terremoto.latitud, 20.0)
    }
    
    // Test de la clase Terremoto con su atributo longitud
    func testTerremotoLongitud() {
        XCTAssertEqual(terremoto.longitud, 20.0)
    }
    
    // Test de la clase Terremoto con su atributo magnitud
    func testTerremotoMagnitud() {
        XCTAssertEqual(terremoto.magnitud, 5.0)
    }
    
    // Test de la clase Terremoto con su atributo fecha
    func testTerremotoFecha() {
        XCTAssertEqual(terremoto.fecha, "01-02-2017 18:00:00")
    }
    
    // Test de la clase Terremoto con su atributo profundidad
    func testTerremotoProfundidad() {
        XCTAssertEqual(terremoto.profundidad, 20.0)
    }
    
    // Test de la clase Terremoto con su función icono()
    func testTerremotoIcono() {
        XCTAssertEqual(terremoto.icono(), UIImage(named: "magnitud-moderado.png"))
    }
    
    // Test de la clase Terremoto con su función arreglarFormatoFecha()
    func testTerremotoArreglarFormatoFecha() {
        XCTAssertEqual(terremoto.arreglarFormatoFecha(fecha: "2017-02-01 18:00:00"), "01-02-2017 18:00:00")
    }
}
