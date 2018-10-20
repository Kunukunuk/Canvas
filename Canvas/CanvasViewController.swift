//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Kun Huang on 10/19/18.
//  Copyright © 2018 Kun Huang. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var tray: UIView!
    
    let trayDownOffset: CGFloat! = 160
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trayUp = tray.center // The initial position of the tray
        trayDown = CGPoint(x: tray.center.x ,y: tray.center.y + trayDownOffset) // The position of the tray transposed down
    }
    
    
    @IBAction func panningTray(_ sender: UIPanGestureRecognizer) {
        
        //let location = sender.location(in: self.view)
        //tray.center = location
        
        let translation = sender.translation(in: self.view)
        var originalCenter = tray.center
        
        if sender.state == .began {
            originalCenter = tray.center
        } else if sender.state == .changed {
            tray.center = CGPoint(x: originalCenter.x, y: originalCenter.y + translation.y)
        } else if sender.state == .ended {
            var velocity = sender.velocity(in: self.view)
            
            if velocity.y > 0 {
                print("move down")
            } else {
                print("move up")
            }
        }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
