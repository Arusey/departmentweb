//
//  LoginViewController.swift
//  DepartmentReview
//
//  Created by Kevin Lagat on 25/05/2020.
//  Copyright © 2020 Arusey. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var login: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        login.addTarget(self, action: #selector(self.onTap(_:)), for: .touchUpInside)
    }
    
    @objc func onTap(_ sender: UIButton) {
        validateFields()
        self.showSpinner(onView: self.view)
        
        provider.request(.loginUser(email: email.text!, password: password.text!), completion: {
            (result) in
            self.removeSpinner()
            switch result {
            case .success(let response):
                do {
                    if let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any] {
                        print(json)
                    }
                    print(try JSONDecoder().decode(UserToken.self, from: response.data))
                    print("login successful")
                    
                }
                catch {
                    
                    DispatchQueue.main.async {
                                           let alertController = UIAlertController(title: "Error", message: "Invalid Credentials Please try again", preferredStyle: .alert)
                                           let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                           
                                           alertController.addAction(defaultAction)
                                           self.present(alertController, animated: true, completion: nil)
                                       }

                    
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func validateFields() {
        if email.text == "" || password.text == "" {
            let alertController = UIAlertController(title: "Enter credentials", message: "Please ensure you have inserted all your credentials", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present (alertController, animated: true, completion: nil)
            
        }
    }



}

