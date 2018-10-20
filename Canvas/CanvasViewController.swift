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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func panningTray(_ sender: UIPanGestureRecognizer) {
        
        let location = sender.location(in: self.view)
        tray.center = location

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
