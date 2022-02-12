//
//  testableSingletonsTests.swift
//  testableSingletonsTests
//
//  Created by Amber Spadafora on 2/12/22.
//

import XCTest
@testable import testableSingletons

class MockAPIClient: TestableApiClient {
    var getDataCallBackTriggered = false
    static let instance = MockAPIClient()
    
    override func getData(callback: @escaping(Bool)->()){
        getDataCallBackTriggered = true
        print("getDataCallBackTrigger set to \(getDataCallBackTriggered)")
        callback(true)
    }
}

class testableSingletonsTests: XCTestCase {

    var viewController: TestableViewController?
    var mockApiClient: MockAPIClient?
    
    func makeSUT() -> TestableViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "TestableViewController") as! TestableViewController
        sut.loadViewIfNeeded()
        sut.client = self.mockApiClient!
        return sut
    }
    
    override func setUpWithError() throws {
        mockApiClient = MockAPIClient.instance
        viewController = makeSUT()
    }

    override func tearDownWithError() throws {
        mockApiClient = nil
        viewController = nil
    }

    func testViewController_whenCallsLoadData_callsBackABool() throws {
        viewController?.loadData(callback: { (success) in
            XCTAssert(self.mockApiClient?.getDataCallBackTriggered == true, "Mock API Client should have triggered getData when SUT (LoginViewController) called loadData")
        })
    }

}
