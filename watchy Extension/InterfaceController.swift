//
//  InterfaceController.swift
//  watchy Extension
//
//  Created by Dai Williams on 21/12/2015.
//  Copyright © 2015 daio. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    var session: WCSession!

    @IBOutlet var textLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func getData() {
        if session.reachable {
            session.sendMessage(["data": "update"], replyHandler: { (data: [String : AnyObject]) -> Void in
                
                let res = data["data"]
            
                let text = res![0] as! String?
                
                self.textLabel.setText(text)
                
                }, errorHandler: { (error) -> Void in
                    
            })
        }
    }
    
    @IBAction func updateText() {
        getData()
    }
    

}
