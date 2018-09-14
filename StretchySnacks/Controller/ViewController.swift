//
//  ViewController.swift
//  StretchySnacks
//
//  Created by Jamie on 2018-09-13.
//  Copyright © 2018 Jamie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: Outlets
    @IBOutlet weak var headerUIView: UIView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var addUIButton: UIButton!
    
    //MARK: Properties
    var stackView:UIStackView!
    var stackBottomToHeaderTop:NSLayoutConstraint!
    var stackBottomToHeaderBottom:NSLayoutConstraint!
    var snacksArray = [Snack]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStackView()
    }
    
    //MARK: Header Setup
    @IBAction func AddMenuUIButton(_ sender: UIButton) {
      
        sender.isSelected = !sender.isSelected
        let heightConstant:CGFloat = sender.isSelected ? 300 : 64
        let spinAmount:CGFloat = sender.isSelected ? 3.92 : 0
        
        //header stretch
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
    
    //MARK: StackView Setup
    
    func setUpStackView(){
        
        // create UIImage Views and add photos
        let oreoImage = UIImage(named: "oreos")
        let oreoUIImageView = UIImageView(image: oreoImage!)
        oreoUIImageView.isUserInteractionEnabled = true
        let oreoButton = UITapGestureRecognizer(target: self, action: #selector(addOreoToArray))
        oreoUIImageView.addGestureRecognizer(oreoButton)
        
        
        let pizzaPocketImage = UIImage(named: "pizza_pockets")
        let pizzaPocketUIImageView = UIImageView(image: pizzaPocketImage!)
        pizzaPocketUIImageView.isUserInteractionEnabled = true
        let pizzaPocketButton = UITapGestureRecognizer(target: self, action: #selector(addPizzaPocketToArray))
        oreoUIImageView.addGestureRecognizer(oreoButton)
        
        let popTartsImage = UIImage(named: "pop_tarts")
        let popTartsUIImageView = UIImageView(image: popTartsImage!)
        popTartsUIImageView.isUserInteractionEnabled = true
        let popTartsButton = UITapGestureRecognizer(target: self, action: #selector(addPopTartsToArray))
        popTartsUIImageView.addGestureRecognizer(popTartsButton)
        
        let popsicleImage = UIImage(named: "popsicleTransparent")
        let popsicleUIImageView = UIImageView(image: popsicleImage!)
        popsicleUIImageView.isUserInteractionEnabled = true
        let popsicleButton = UITapGestureRecognizer(target: self, action: #selector(addPopsicleToArray))
        popsicleUIImageView.addGestureRecognizer(popsicleButton)
        
        let ramenImage = UIImage(named: "ramenTransparent")
        let ramenUIImageView = UIImageView(image: ramenImage!)
        ramenUIImageView.isUserInteractionEnabled = true
        let ramenButton = UITapGestureRecognizer(target: self, action: #selector(addRamenToArray))
        ramenUIImageView.addGestureRecognizer(ramenButton)
        
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
    
    //MARK: TableView Setup
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return snacksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellIdentifier = "SnacksTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SnacksTableViewCell  else {
            fatalError("The dequeued cell is not an instance of SnacksTableViewCell.")
        }
        let snack = snacksArray[indexPath.row]
        cell.snackUILabel.text = snack.name
        return cell
    }
    
    @objc func addOreoToArray(sender:UIImageView){
        let snack = Snack(name: "oreos")
        snacksArray.append(snack)
    }
    @objc func addPizzaPocketToArray(sender:UIImageView){
        let snack = Snack(name: "pizza pocket")
        snacksArray.append(snack)
    }
    @objc func addPopTartsToArray(sender:UIImageView){
        let snack = Snack(name: "pop tarts")
        snacksArray.append(snack)
    }
    @objc func addPopsicleToArray(sender:UIImageView){
        let snack = Snack(name: "popsicle")
        snacksArray.append(snack)
    }
    @objc func addRamenToArray(sender:UIImageView){
        let snack = Snack(name: "ramen")
        snacksArray.append(snack)
    }
}


