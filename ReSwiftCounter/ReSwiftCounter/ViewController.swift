//
//  ViewController.swift
//  ReSwiftCounter
//
//  Created by monkey on 2017/4/19.
//  Copyright © 2017年 Coder. All rights reserved.
//

import UIKit
import ReSwift

class ViewController: UIViewController , StoreSubscriber{
    
    typealias StoreSubscriberStateType = AppState

    @IBOutlet weak var counter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainStore.subscribe(self)
    }
    
    func newState(state: AppState) {
        counter.text = "\(mainStore.state.counter)"
    }

    @IBAction func upTouch(_ sender: Any) {
        mainStore.dispatch(CounterActionIncrease())
    }
    
    @IBAction func downTouch(_ sender: Any) {
        mainStore.dispatch(CounterActionDecrease())
    }
}

