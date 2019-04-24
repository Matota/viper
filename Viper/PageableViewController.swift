//
//  PageableViewController.swift
//  Neum
//
//  Created by Hitesh Ahuja on 24/04/19.
//  Copyright © 2019 Organization. All rights reserved.
//


import UIKit

class PageableViewController: UIViewController, Pageable {

    
    @IBOutlet var pagingImage: UIImageView!
    var pageValue : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let pageValue = pageValue{
          pagingImage.image = UIImage(named: pageValue)
        }
    }

}
