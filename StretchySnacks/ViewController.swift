//
//  ViewController.swift
//  StretchySnacks
//
//  Created by Jamie on 2018-09-13.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //    var heightConstant:CGFloat = 64
    
    @IBOutlet weak var headerUIView: UIView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var addUIButton: UIButton!
    var stackView:UIStackView!
    var stackBottomToHeaderTop:NSLayoutConstraint!
    var stackBottomToHeaderBottom:NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStackView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddMenuUIButton(_ sender: UIButton) {
        
        //header stretch
        sender.isSelected = !sender.isSelected
        let heightConstant:CGFloat = sender.isSelected ? 300 : 64
        let spinAmount:CGFloat = sender.isSelected ? 3.92 : 0
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
            self.headerHeightConstraint.constant = heightConstant // Some value
            self.view.layoutIfNeeded()
        })
        
        //plus symbol rotation
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
            self.addUIButton.transform = CGAffineTransform(rotationAngle: spinAmount)
            self.view.layoutIfNeeded()
        })
        
        //bring the graphics down
        self.stackBottomToHeaderBottom = self.stackView.bottomAnchor.constraint(equalTo: self.headerUIView.bottomAnchor, constant: 0)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
            if self.stackBottomToHeaderTop.isActive == true {
                self.stackBottomToHeaderTop.isActive = false
                self.stackBottomToHeaderBottom.isActive = true
            }else{
                self.stackBottomToHeaderTop.isActive = true
                self.stackBottomToHeaderBottom.isActive = false
            }
            self.view.layoutIfNeeded()
        })
    }
    func setUpStackView(){
        
        // create UIImage Views and add photos
        let oreoImage = UIImage(named: "oreos")
        let oreoUIImageView = UIImageView(image: oreoImage!)
        let pizzaPocketImage = UIImage(named: "pizza_pockets")
        let pizzaPocketUIImageView = UIImageView(image: pizzaPocketImage!)
        let popTartsImage = UIImage(named: "pop_tarts")
        let popTartsUIImageView = UIImageView(image: popTartsImage!)
        let popsicleImage = UIImage(named: "popsicleTransparent")
        let popsicleUIImageView = UIImageView(image: popsicleImage!)
        let ramenImage = UIImage(named: "ramenTransparent")
        let ramenUIImageView = UIImageView(image: ramenImage!)
        
        // create stackView and add imageViews
        stackView = UIStackView(arrangedSubviews: [oreoUIImageView, pizzaPocketUIImageView, popTartsUIImageView, popsicleUIImageView, ramenUIImageView])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        headerUIView.addSubview(stackView)
        
        //constraints for stackview to headerView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stackView.trailingAnchor.constraint(equalTo: headerUIView.trailingAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: headerUIView.leadingAnchor, constant: 0).isActive = true
        
        //contraints to be modified
        self.stackBottomToHeaderTop = stackView.bottomAnchor.constraint(equalTo: headerUIView.topAnchor, constant: 0)
        self.stackBottomToHeaderTop.isActive = true
    }
}


