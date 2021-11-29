//
//  ViewController.swift
//  Hello-Subjects
//
//  Created by Mohammad Azam on 9/6/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import UIKit
import Combine

enum MyError: Error {
    case subscriberError
}

class StringSubscriber: Subscriber {
    
    func receive(subscription: Subscription) {
        subscription.request(.max(2))
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print(input)
        return .max(1)
    }
    
    func receive(completion: Subscribers.Completion<MyError>) {
        print("Completion")
    }
    
    
    typealias Input = String
    typealias Failure = MyError
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Subjects
           // - Publisher
           // - Subscribers
        
        let subscriber = StringSubscriber()
        
        let subject = PassthroughSubject<String, MyError>()
        
        subject.subscribe(subscriber)
        
        let subscription = subject.sink(receiveCompletion: { (completion) in
            
            print("Received Completion from sink")
            
        }) { value in
            
            print("Received Value from sink")
        }
        
        subject.send("A")
        subject.send("B")
        
        subscription.cancel()
        
        subject.send("C")
        subject.send("D")
        
    }


}

