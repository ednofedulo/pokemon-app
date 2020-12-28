//
//  HomePresenterTests.swift
//  pokemon-appTests
//
//  Created by Edno Fedulo on 28/12/20.
//

import Foundation
import XCTest
@testable import pokemon_app

class HomePresenterTests:XCTestCase {
    var presenter:HomePresenter!
    
    override func setUp() {
        presenter = HomePresenter(service: HomeServiceMock(), coordinator: nil)
        
    }
    
    override func tearDown() {
        presenter = nil
    }
    
    func testFetchPokemons() {
        let expectation = self.expectation(description: "fetchData")
        presenter.fetchPokemons()
        expectation.fulfill()
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(presenter.pokemons)
    }
    
    func testLoadMorePokemons(){
        let expectation = self.expectation(description: "fetchData")
        presenter.fetchPokemons()
        let count = presenter.pokemons.count
        presenter.fetchPokemons()
        expectation.fulfill()
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(presenter.pokemons.count > count)
    }
}
