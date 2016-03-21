//
//  InterfaceController.swift
//  WatchShaker WatchKit Extension
//
//  Created by Christopher Wood on 3/21/16.
//  Copyright © 2016 CWoodMadeIt. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    let colorArray = [UIColor.whiteColor(), .blueColor(), .brownColor(), .orangeColor(), .greenColor(), .redColor(), .grayColor()]

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
    }
    
    @IBOutlet var backgroundGroup: WKInterfaceGroup!
   
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        MotionController.sharedInstance.delegate = self
        MotionController.sharedInstance.start()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        
        MotionController.sharedInstance.stop()
    }

}

extension InterfaceController: MotionControllerDelegate
{
    func didShake() {
        
        // present a random color every time the user shakes her wrist
        animateWithDuration(0.1) { () -> Void in
            self.backgroundGroup.setBackgroundColor(self.colorArray[Int.random(0...self.colorArray.count-1)])
        }
    }
}

// Add random function to Int
extension Int{
    static func random(range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.startIndex < 0   // allow negative ranges
        {
            offset = abs(range.startIndex)
        }
        
        let mini = UInt32(range.startIndex + offset)
        let maxi = UInt32(range.endIndex   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}
