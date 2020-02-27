//
//  ViewController.swift
//  CAAnimation
//
//  Created by 周旗 on 2020/2/25.
//  Copyright © 2020 ZQMAC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var discView: UIView!
    @IBOutlet weak var musicImgV: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //music 音符动画
        discView.curveAnimation(imageName: "icon_home_musicnote1", delay: 0)
        discView.curveAnimation(imageName: "icon_home_musicnote2", delay: 1)
        discView.curveAnimation(imageName: "icon_home_musicnote3", delay: 2)
        // Do any additional setup after loading the view.
    }


}

