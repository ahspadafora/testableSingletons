//
//  ViewController.swift
//  testableSingletons
//
//  Created by Amber Spadafora on 2/12/22.
//

import UIKit

// Untestable Singleton because it is not subclassable
final class UntestableApiClient {
    static let shared = UntestableApiClient()
    init(){}
    
    func getData(callback: @escaping(Bool)->()){
        callback(true)
    }
}

class UntestableViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        // Untestable Singleton because it is an implicit dependency that cannot be mocked during testing
        UntestableApiClient.shared.getData { (success) in
            print(success)
        }
    }
}

// Testable Singleton because it is subclassable
class TestableApiClient {
    static var shared = TestableApiClient()
    init(){}
    
    func getData(callback: @escaping(Bool)->()){
        callback(true)
    }
}

class TestableViewController: UIViewController {
    var client = TestableApiClient.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData { (success) in
            print("success")
        }
    }
    
    func loadData(callback: @escaping (Bool)->() ) {
        // Testable singleton because it is an explicit dependency that can be mocked during testing
        client.getData { (success) in
            callback(success)
        }
    }
}

