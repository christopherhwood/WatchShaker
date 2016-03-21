//
//  MotionController.swift
//  WatchShaker
//
//  Created by Christopher Wood on 3/21/16.
//  Copyright © 2016 CWoodMadeIt. All rights reserved.
//

import Foundation
import CoreMotion


//

protocol MotionControllerDelegate
{
    func didShake()
}

class MotionController
{
    var delegate: MotionControllerDelegate?
    
    private var motionManager: CMMotionManager!
    private var lastShakeDate: NSDate?
    
    // The threshold for how much acceleration needs to happen before an event will register. Can tune to your liking, although I've found 1.2 to work pretty well.
    private let kShakeThreshold = 1.2
    
    // The time between shakes (useful for not counting a shake on the way up and then again on the way back down).
    private let kShakeDelay = 0.7
    
    static let sharedInstance = MotionController()
    private init()
    {
        self.motionManager = CMMotionManager()
    }
    
    func start()
    {
        guard motionManager.accelerometerAvailable else { return }
        
        // How often the motionManager looks for updates on acceleration. Can tune to your liking.
        motionManager.accelerometerUpdateInterval = 0.02
        
        let motionQueue = NSOperationQueue()
        
        motionManager.startAccelerometerUpdatesToQueue(motionQueue) { (accelerometerData, err) -> Void in
            
            guard err == nil else
            {
                print(err!.localizedDescription)
                return
            }
            
            guard let data = accelerometerData else
            {
                print("No accelerometer data")
                return
            }
            
            let valueX = fabs(data.acceleration.x)
            let valueY = fabs(data.acceleration.y)
            let maxValue = valueX > valueY ? valueX : valueY
            
            
            
            if maxValue > self.kShakeThreshold
            {
                if let lastDate = self.lastShakeDate
                {
                    if NSDate().compare(lastDate.dateByAddingTimeInterval(self.kShakeDelay)) == .OrderedDescending
                    {
                        self.lastShakeDate = NSDate()
                        self.delegate?.didShake()
                    }
                    return
                }
                
                self.lastShakeDate = NSDate()
                self.delegate?.didShake()
            }
        }
    }
    
    func stop()
    {
        motionManager.stopAccelerometerUpdates()
    }
}