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
    @IBOutlet weak var snackTableView: UITableView!
    
    //MARK: Properties
    var stackView:UIStackView!
    var stackBottomToHeaderTop:NSLayoutConstraint!
    var stackBottomToHeaderBottom:NSLayoutConstraint!
    var titleUILabelYConstant = NSLayoutConstraint()
    var snacksArray = [Snack]()
    
    //MARK: Creating the imageViews
    lazy var oreoUIImageView: UIImageView = {
        let oreoImage = UIImage(named: "oreos")
        let oreoImageView = UIImageView(image: oreoImage!)
        oreoImageView.isUserInteractionEnabled = true
        return oreoImageView
    }()
    lazy var pizzaPocketUIImageView: UIImageView = {
        let pizzaPocketImage = UIImage(named: "pizza_pockets")
        let pizzaPocketImageView = UIImageView(image: pizzaPocketImage!)
        pizzaPocketImageView.isUserInteractionEnabled = true
        return pizzaPocketImageView
    }()
    lazy var popTartsUIImageView: UIImageView = {
        let popTartsImage = UIImage(named: "pop_tarts")
        let popTartsImageView = UIImageView(image: popTartsImage!)
        popTartsImageView.isUserInteractionEnabled = true
        return popTartsImageView
    }()
    lazy var popsicleUIImageView: UIImageView = {
        let popsicleImage = UIImage(named: "popsicleTransparent")
        let popsicleImageView = UIImageView(image: popsicleImage!)
        popsicleImageView.isUserInteractionEnabled = true
        return popsicleImageView
    }()
    lazy var ramenUIImageView: UIImageView = {
        let ramenImage = UIImage(named: "ramenTransparent")
        let ramenImageView = UIImageView(image: ramenImage!)
        ramenImageView.isUserInteractionEnabled = true
        return ramenImageView
    }()
    lazy var titleUILabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect(x: headerUIView.center.x - 115, y: headerUIView.center.y - 10, width: 230, height: 20))
        titleLabel.text = "Add Snacks"
        return titleLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStackView()
        setUpTitle()
    }
    
    //MARK: Header Setup
    @IBAction func AddMenuUIButton(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        let heightConstant:CGFloat = sender.isSelected ? 200 : 64
        let spinAmount:CGFloat = sender.isSelected ? 3.92 : 0
        self.titleUILabel.text = sender.isSelected ? "Snacks" : "Add Snacks"
        self.titleUILabelYConstant.constant = sender.isSelected ? 40 : 0
        
        //combine these 3
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
        //modify the title
        //let titleLabel = UILabel()
        
    }
    
    func setUpTitle(){
        //let titleLabel = UILabel(frame: CGRect(x: headerUIView.center.x - 115, y: headerUIView.center.y - 10, width: 230, height: 20))
        self.titleUILabel.text = "Add Snacks"
        self.titleUILabel.textAlignment = NSTextAlignment.center
        self.headerUIView.addSubview(self.titleUILabel)
        self.titleUILabel.centerXAnchor.constraint(equalTo: headerUIView.centerXAnchor, constant: 0).isActive = true
        self.titleUILabelYConstant = self.titleUILabel.centerYAnchor.constraint(equalTo: headerUIView.centerYAnchor, constant: 0)
        self.titleUILabelYConstant.isActive = true
    }
    
    //MARK: StackView Setup
    
    func setUpStackView(){
        
        // create tapGesture Recognizers
        let oreoButton = UITapGestureRecognizer(target: self, action: #selector(addOreoToArray))
        self.oreoUIImageView.addGestureRecognizer(oreoButton)
        
        let pizzaPocketButton = UITapGestureRecognizer(target: self, action: #selector(addPizzaPocketToArray))
        self.pizzaPocketUIImageView.addGestureRecognizer(pizzaPocketButton)
        
        let popTartsButton = UITapGestureRecognizer(target: self, action: #selector(addPopTartsToArray))
        self.popTartsUIImageView.addGestureRecognizer(popTartsButton)
        
        let popsicleButton = UITapGestureRecognizer(target: self, action: #selector(addPopsicleToArray))
        self.popsicleUIImageView.addGestureRecognizer(popsicleButton)
        
        let ramenButton = UITapGestureRecognizer(target: self, action: #selector(addRamenToArray))
        self.ramenUIImageView.addGestureRecognizer(ramenButton)
        
        // create stackView and add imageViews
        stackView = UIStackView(arrangedSubviews: [self.oreoUIImageView, self.pizzaPocketUIImageView, self.popTartsUIImageView, self.popsicleUIImageView, self.ramenUIImageView])
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
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            snacksArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

   func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    
    //MARK: Add Objects to array
    
    @objc func addOreoToArray(sender:UIImageView){
        let snack = Snack(name: "oreos")
        snacksArray.append(snack)
        self.snackTableView.reloadData()
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations:{
            self.oreoUIImageView.transform = self.oreoUIImageView.transform.rotated(by: CGFloat.pi)
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations:{
            self.oreoUIImageView.transform = self.oreoUIImageView.transform.rotated(by: CGFloat.pi)
            self.view.layoutIfNeeded()
        })
        
    }
    @objc func addPizzaPocketToArray(sender:UIImageView){
        let snack = Snack(name: "pizza pocket")
        snacksArray.append(snack)
        self.snackTableView.reloadData()
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations:{
            self.pizzaPocketUIImageView.transform = self.pizzaPocketUIImageView.transform.rotated(by: CGFloat.pi)
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations:{
            self.pizzaPocketUIImageView.transform = self.pizzaPocketUIImageView.transform.rotated(by: CGFloat.pi)
            self.view.layoutIfNeeded()
        })
    }
    @objc func addPopTartsToArray(sender:UIImageView){
        let snack = Snack(name: "pop tarts")
        snacksArray.append(snack)
        self.snackTableView.reloadData()
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations:{
            self.popTartsUIImageView.transform = self.popTartsUIImageView.transform.rotated(by: CGFloat.pi)
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations:{
            self.popTartsUIImageView.transform = self.popTartsUIImageView.transform.rotated(by: CGFloat.pi)
            self.view.layoutIfNeeded()
        })
    }
    @objc func addPopsicleToArray(sender:UIImageView){
        let snack = Snack(name: "popsicle")
        snacksArray.append(snack)
        self.snackTableView.reloadData()
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations:{
            self.popsicleUIImageView.transform = self.popsicleUIImageView.transform.rotated(by: CGFloat.pi)
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations:{
            self.popsicleUIImageView.transform = self.popsicleUIImageView.transform.rotated(by: CGFloat.pi)
            self.view.layoutIfNeeded()
        })
    }
    @objc func addRamenToArray(sender:UIImageView){
        let snack = Snack(name: "ramen")
        snacksArray.append(snack)
        self.snackTableView.reloadData()
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations:{
            self.ramenUIImageView.transform = self.ramenUIImageView.transform.rotated(by: CGFloat.pi)
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations:{
            self.ramenUIImageView.transform = self.ramenUIImageView.transform.rotated(by: CGFloat.pi)
            self.view.layoutIfNeeded()
        })
    }
}


