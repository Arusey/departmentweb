//
//  RegisterViewController.swift
//  DepartmentReview
//
//  Created by Kevin Lagat on 25/05/2020.
//  Copyright © 2020 Arusey. All rights reserved.
//

import UIKit
import Moya

let provider = MoyaProvider<APIRequests>()

class RegisterViewController: UIViewController {
    
    
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    @IBOutlet weak var register: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register.addTarget(self, action: #selector(self.onTap(_:)), for: .touchUpInside)

    }
    
    @objc func onTap(_ sender: UIButton) {
        validateFields()
        self.showSpinner(onView: self.view)
        
        provider.request(.registerUser(firstName: firstName.text!, lastName: lastName.text!, email: email.text!, password: password.text!), completion:{
            result in
            self.removeSpinner()
            
            switch result {
            case .success(let response):
                do {
                    if let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any] {
                        print(json)
                    }
                    print(try JSONDecoder().decode(User.self, from: response.data))
                    print("sign up successful")
                    let loginVC = LoginViewController()
                    self.present(loginVC, animated: true, completion: nil)
                    
                } catch {
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
        }
            
        )
    
    }
    
    
    func validateFields() {
        if firstName.text == "" || lastName.text == "" || email.text == "" || password.text == "" {
            let alertController = UIAlertController(title: "Enter credentials", message: "Please ensure you have inserted all your credentials", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present (alertController, animated: true, completion: nil)
            
        }
    }

    
    


}
