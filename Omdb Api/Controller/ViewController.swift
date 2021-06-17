//
//  ViewController.swift
//  Omdb Api
//
//  Created by AbdulKadir Akkaş on 15.06.2021.
//

import UIKit
import Network
import Loaf


class ViewController: UIViewController  , UITextFieldDelegate {
    //MARK: -UIElements
   
    @IBOutlet weak var pinsoftLabel: UILabel!
    
  
    //MARK: - Properties
    
    
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monitorNetwork()
        setupView()
        labelClickable()
       
    }
    
    
    //MARK: - Methods
    func setupView(){
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func labelClickable(){
        pinsoftLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        pinsoftLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapFunction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 ){
            self.performSegue(withIdentifier: "toShowList", sender: nil)
        }
    }
        
    func monitorNetwork() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied{
                DispatchQueue.main.async {
                    Loaf("İnternet Bağlantısı Sağlandı", state: .success, location: .top , sender: self).show()
                    
                }
            } else {
                
                DispatchQueue.main.async {
                    self.pinsoftLabel.isUserInteractionEnabled = false
                    Loaf("İnternet Bağlantısı Sağlanamadı", state: .error, location: .top , sender: self).show()
                    
                }
            }
        }
        
       let quee = DispatchQueue(label: "network")
        monitor.start(queue: quee)
    }
    
    
    
    //MARK: - Actions


}

