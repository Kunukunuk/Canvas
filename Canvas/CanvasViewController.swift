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
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trayUp = tray.center
        trayDown = CGPoint(x: tray.center.x ,y: tray.center.y + trayDownOffset)
        
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
            
            let velocity = sender.velocity(in: self.view)
            
            if velocity.y > 0 {
                print("move down")
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                    self.tray.center = self.trayDown
                }, completion: nil)
            } else {
                print("move up")
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                    self.tray.center = self.trayUp
                }, completion: nil)
            }
        }

    }
    
    @IBAction func panFaces(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: self.view)
        
        if sender.state == .began {
            
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += tray.frame.origin.y
            
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            newlyCreatedFace.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panNewlyFaces(_:) )))
            newlyCreatedFace.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(didPinchFace(_:))))
            newlyCreatedFace.addGestureRecognizer(UIRotationGestureRecognizer(target: self, action: #selector(didRotateFace(_:))))
            newlyCreatedFace.isUserInteractionEnabled = true
            
            newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            newlyCreatedFace.transform = newlyCreatedFace.transform.scaledBy(x: 0.5, y: 0.5)
        }
    }
    
    @IBAction func panNewlyFaces(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: self.view)
        
        if sender.state == .began {
            newlyCreatedFace = (sender.view as! UIImageView) // to get the face that we panned on.
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center // so we can offset by translation later.
            //newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            //newlyCreatedFace.transform = newlyCreatedFace.transform.scaledBy(x: 0.75, y: 0.75)
        }
        
    }
    
    @IBAction func didPinchFace(_ sender: UIPinchGestureRecognizer) {
        
        let scale = sender.scale
        newlyCreatedFace.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    @IBAction func didRotateFace(_ sender: UIRotationGestureRecognizer) {
        let rotation = sender.rotation
        newlyCreatedFace.transform = CGAffineTransform(rotationAngle: rotation)
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
