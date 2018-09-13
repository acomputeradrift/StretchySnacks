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
    }
    func setUpStackView(){
        let stackView = UIStackView()
        headerUIView.addSubview(stackView)
        
        let oreoUIView = UIView()
        let oreoImage = UIImage(named: "oreos")
        let oreoImageView = UIImageView(image: oreoImage!)
        oreoUIView.addSubview(oreoImageView)
        
        let pizzaPocketUIView = UIView()
        let pizzaPocketImage = UIImage(named: "pizza_pockets")
        let pizzaPocketImageView = UIImageView(image: pizzaPocketImage!)
        pizzaPocketUIView.addSubview(pizzaPocketImageView)
        
        let popTartUIView = UIView()
        let popTartImage = UIImage(named: "pop_tarts")
        let popTartImageView = UIImageView(image: popTartImage!)
        popTartUIView.addSubview(popTartImageView)
        
        let popsicleUIView = UIView()
        let popsicleImage = UIImage(named: "popsicleTransparent")
        let popsicleImageView = UIImageView(image: popsicleImage!)
        popsicleUIView.addSubview(popsicleImageView)
        
        let ramenUIView = UIView()
        let ramenImage = UIImage(named: "ramenTransparent")
        let ramenImageView = UIImageView(image: ramenImage!)
        ramenUIView.addSubview(ramenImageView)
    
        
        stackView.addArrangedSubview(oreoUIView)
        stackView.addArrangedSubview(pizzaPocketUIView)
        stackView.addArrangedSubview(popTartUIView)
        stackView.addArrangedSubview(popsicleUIView)
        stackView.addArrangedSubview(ramenUIView)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
}


