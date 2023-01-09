//
//  ViewController.swift
//  modelPage
//
//  Created by Dinesh on 28/12/22.
//

import UIKit
import CryptoKit
import Foundation

var token:String = ""


class ViewController: UIViewController {

    @IBOutlet weak var parantBtn: UIButton!
    @IBOutlet weak var studentBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        parantBtn.layer.cornerRadius = 30
        studentBtn.layer.cornerRadius = 30
    }
}

// Parent ViewViewController

class Parent: UIViewController {
    
    //TextField
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    

    var digestRaw:String = ""
    
    
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        // PlaceHolderDesign
        
        let placeHolderText1 = NSAttributedString(string: "Username",attributes: [NSAttributedString.Key.foregroundColor:UIColor.darkGray])
        textField1.attributedPlaceholder = placeHolderText1
        let placeHolderText2 = NSAttributedString(string: "Email ID",attributes: [NSAttributedString.Key.foregroundColor:UIColor.darkGray])
        textField2.attributedPlaceholder = placeHolderText2
        let placeHolderText3 = NSAttributedString(string: "Phone Number",attributes: [NSAttributedString.Key.foregroundColor:UIColor.darkGray])
        textField3.attributedPlaceholder = placeHolderText3
        
        //textfeild Keyboard Setting
        
        textField2.keyboardType = .emailAddress
        textField3.keyboardType = .numberPad
        
        
        UITextField.connectFields(fields: [textField1,textField2,textField3])  //line 146
        
        // add a done button to the numberpad
        
        addDoneButtonOnNumpad(textField: textField3)

        func addDoneButtonOnNumpad(textField: UITextField) {
                
                let keypadToolbar: UIToolbar = UIToolbar()
            
            let _:UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 50))
                    keypadToolbar.barStyle = .default
                
                keypadToolbar.items=[
                    UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: textField, action: #selector(UITextField.resignFirstResponder)),
                    UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
                ]
            keypadToolbar.sizeToFit()
                
                textField.inputAccessoryView = keypadToolbar
            }
        //bottomLine desghn
        
        var bottomText1 = CALayer()
        bottomText1.frame = CGRect(x: 0.0, y: textField1.frame.height - 1, width: textField1.frame.width, height: 1.0)
        bottomText1.backgroundColor = UIColor.darkGray.cgColor
        textField1.borderStyle = UITextField.BorderStyle.none
        textField1.layer.addSublayer(bottomText1)
        
        var bottomText2 = CALayer()
        bottomText2.frame = CGRect(x: 0.0, y: textField2.frame.height - 1, width: textField1.frame.width, height: 1.0)
        bottomText2.backgroundColor = UIColor.darkGray.cgColor
        textField2.borderStyle = UITextField.BorderStyle.none
        textField2.layer.addSublayer(bottomText2)
        
        var bottomText3 = CALayer()
        bottomText3.frame = CGRect(x: 0.0, y: textField3.frame.height - 1, width: textField1.frame.width, height: 1.0)
        bottomText3.backgroundColor = UIColor.darkGray.cgColor
        textField3.borderStyle = UITextField.BorderStyle.none
        textField3.layer.addSublayer(bottomText3)
        
        nextBtn.layer.cornerRadius = 20
        
    }
    
    //Text feild validation func
    @IBAction func lonInBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "logInViewController") as! logInViewController
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
        
    }
    

    @IBAction func validtextField(_ sender: Any) {
        
            let name = textField1.text ?? ""
            let email = textField2.text ?? ""
            let number = textField3.text ?? ""
        
        
        
            
            if name.isValidName(_name: name) {
                
                if email.isValidEmail(_email: email) {
                    
                    if number.isValidNumber(_number: number){
                        
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let otpVC = storyBoard.instantiateViewController(withIdentifier: "otpViewController") as! otpViewController
                        otpVC.modalPresentationStyle = .fullScreen
                        otpVC.number = textField3.text!
                        self.present(otpVC, animated: true, completion: nil)
                        
                        let dialogMessage = UIAlertController(title: "Hello \(name)", message: "Welcome ", preferredStyle: .alert)
                        dialogMessage.addAction(UIAlertAction(title: "Thank You", style: UIAlertAction.Style.default, handler: nil))
                        self.present(dialogMessage, animated: true, completion: nil)
                        
                    }else{
                        let dialogMessage = UIAlertController(title: "Alert", message: "Plese enter a valid mobile number", preferredStyle: .alert)
                        dialogMessage.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(dialogMessage, animated: true, completion: nil)
                        
                    }
                    
                }else{
                    let dialogMessage = UIAlertController(title: "alert", message: "Please enter a valid email", preferredStyle: .alert)
                    dialogMessage.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(dialogMessage, animated: true, completion: nil)
                    
                }
                
            }else {
                let dialogMessage = UIAlertController(title: "alert", message: "Please Enter Your Name", preferredStyle: .alert)
                dialogMessage.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(dialogMessage, animated: true, completion: nil)
                
            }
        
        func onSubmit(name:String,email:String,number:String)
        {
            var add = number + "EMPTY" + email + name + "abcd098324nd49dql38"
            
            func sha512(hexvalue: String) -> String {
                let inputData = Data(hexvalue.utf8)

                let hashed = SHA512.hash(data: inputData)
                print(hashed.description)
                let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
                return hashString
            }
             digestRaw = sha512(hexvalue:add)
            print(add)
            print(NSData.description)
           
            
        }
        let value: () = onSubmit(name:name ?? "",email: email ?? "",number: number ?? "")
        print(name)
        print(digestRaw)
        
  
        let person = ["name":name, "email":email,"phone":number,"oss": "iOS","hash_signup":digestRaw] as Dictionary<String, String>

        var request = URLRequest(url: URL(string: "http://192.168.1.5:8000/api/save_users")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: person, options: [])
            
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                
                if json["token"] as! String == "success"
                    {
                    print ("Hi")
                    
                }else{
                    let dialogMessage = UIAlertController(title: "alert", message: "Something went wrong", preferredStyle: .alert)
                    dialogMessage.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(dialogMessage, animated: true, completion: nil)
                }
                
            } catch {
                print("error")
            }
        })

        task.resume()
        
    }
    
}
//keyboard @objec func

extension UITextField {
    class func connectFields(fields:[UITextField]) -> Void {
        guard let last = fields.last else {
            return
        }
        for i in 0 ..< fields.count-1 {
            fields[i].returnKeyType = .next
            fields[i].addTarget(fields[i+1], action: #selector(self.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
}

//Validation Expression

extension String {
    func isValidName(_name: String) -> Bool {                                //name validation
        if _name == ""{
            return false
        }
        return true
    }
    func isValidEmail(_email: String) -> Bool {                             //email validation
        let emailRegEx = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    func isValidNumber(_number: String) -> Bool {                           //number Validation
        let numberRegEx = "^[0-9]{10}$"
        let numberPred = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return numberPred.evaluate(with: self)
    }
    
}

// NewPage ViewController



class logInViewController:UIViewController{
    
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var loginNum: UITextField!
    var num = ""
    let hashString:String  = ""
    var responseStatus : String = ""
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        logInBtn.layer.cornerRadius = 20
        
        let placeHolderText = NSAttributedString(string: "Enter your number",attributes: [NSAttributedString.Key.foregroundColor:UIColor.darkGray])
        loginNum.attributedPlaceholder = placeHolderText
       
        var bottomText = CALayer()
        bottomText.frame = CGRect(x: 0.0, y: loginNum.frame.height - 1, width: loginNum.frame.width, height: 1.0)
        bottomText.backgroundColor = UIColor.darkGray.cgColor
        loginNum.borderStyle = UITextField.BorderStyle.none
        loginNum.layer.addSublayer(bottomText)
        
        addDoneButtonOnNumpad(textField: loginNum)

        func addDoneButtonOnNumpad(textField: UITextField) {
                
                let keypadToolbar: UIToolbar = UIToolbar()
            
            let _:UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 50))
                    keypadToolbar.barStyle = .default
                
                keypadToolbar.items=[
                    UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: textField, action: #selector(UITextField.resignFirstResponder)),
                    UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
                ]
            keypadToolbar.sizeToFit()
                
                textField.inputAccessoryView = keypadToolbar
            }
        
    }
    func gotoOTPPage(){
        DispatchQueue.main.async {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let OtpVC = storyBoard.instantiateViewController(withIdentifier: "otpViewController") as! otpViewController
            OtpVC.modalPresentationStyle = .fullScreen
            OtpVC.number = self.loginNum.text!
            self.present(OtpVC, animated: true, completion: nil)
        }
        
    }
    @IBAction func submitbtn(_ sender: Any) {
        
        
        
       /* let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let OtpVC = storyBoard.instantiateViewController(withIdentifier: "otpViewController") as! otpViewController
        OtpVC.modalPresentationStyle = .fullScreen
        OtpVC.number = loginNum.text!
        self.present(OtpVC, animated: true, completion: nil)  */
        var number = loginNum.text!
        
        if number.isValidNumber(_number: number) {
            
            print(" This is mobile number: \(number)")
            
                var hash_login = number + "abcd098324nd49dql38"
                
                    let inputData = Data(hash_login.utf8)

                    let hashed = SHA512.hash(data: inputData)
                    let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
                print(hashString)
            
            let url = URL(string: "https://lmachpay.nexdha.com/api/login")
            guard url != nil else{
                print("erorr")
                return
            }
            var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
            request.httpMethod = "POST"
            let requestObject = ["phone":number, "hash_login":hashString]
            do{
                let requestBody = try JSONSerialization.data(withJSONObject: requestObject, options: .prettyPrinted)
                request.httpBody = requestBody
                print(requestBody)
                //HTTP Headers
                  request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                   //request.addValue("application/json", forHTTPHeaderField: "Accept")
            }catch{
                print(number)
            }
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request, completionHandler: { [self] data, response, error -> Void in
                print(response as Any)
                
                do{
                    let parsingData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: AnyObject]
                    var responseString = String(data: data!, encoding: .utf8)
                    print(responseString!)
                    let data = Data(responseString!.utf8)
                    
                    do {
                        // make sure this JSON is in the format we expect
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            // try to read out a string array
                            
                            print(json)
                            if json["status"] as! String == "success"{
                                print(json["kyc"]!)
                                gotoOTPPage()
                              
                            }else{
                                print(json["status"]!)
                            }
                            
                        }
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                        
                    
                  /*let decoder = JSONDecoder()
                    if  let responseStatus = try? decoder.decode(jsonStatus.self, from: responseString?.data(using: .utf8)!) {
                        for responce in responseStatus {
                            print(responce.status)
                        }
                    }
                    */
                }catch{
                    print(number)
                }
            })
            dataTask.resume()
            
            /*let verifyOTP = ["phone":number, "hash_login":hashString] as! Dictionary<String, AnyObject>
            
            
            var request = URLRequest(url: URL(string: "https://lmachpay.nexdha.com/api/login")!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: verifyOTP, options: [])
                
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                print(response!)
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    print(json)
                    
                } catch {
                    print("error")
                }
            })
            task.resume()*/

                }
                else{
                    let dialogMessage = UIAlertController(title: "alert", message: "Please enter a valid number!", preferredStyle: .alert)
                    dialogMessage.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    func isValidNumber(_number: String) -> Bool {                           //number Validation
        let numberRegEx = "^[0-9]{10}$"
        let numberPred = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return numberPred.evaluate(with: self)
    }
    
    
}

class otpViewController:UIViewController{
    
    @IBOutlet weak var otpText: UITextField!
    @IBOutlet weak var otpverifyBtn: UIButton!
    var num = ""
    var number = ""
    var hash2 = ""
    var json = ""
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        num = number
        
        otpverifyBtn.layer.cornerRadius = 20
        
        let placeHolderText = NSAttributedString(string: "OTP",attributes: [NSAttributedString.Key.foregroundColor:UIColor.darkGray])
        otpText.attributedPlaceholder = placeHolderText
       
        var bottomText = CALayer()
        bottomText.frame = CGRect(x: 0.0, y: otpText.frame.height - 1, width: otpText.frame.width, height: 1.0)
        bottomText.backgroundColor = UIColor.darkGray.cgColor
            otpText.borderStyle = UITextField.BorderStyle.none
        otpText.layer.addSublayer(bottomText)
        
        addDoneButtonOnNumpad(textField: otpText)

        func addDoneButtonOnNumpad(textField: UITextField) {
                
                let keypadToolbar: UIToolbar = UIToolbar()
            
            let _:UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 50))
                    keypadToolbar.barStyle = .default
                
                keypadToolbar.items = [
                    UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: textField, action: #selector(UITextField.resignFirstResponder)),
                    UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
                ]
            keypadToolbar.sizeToFit()
                
                textField.inputAccessoryView = keypadToolbar
            }
        
    }
    func gotoNewPage(){
        DispatchQueue.main.async {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyBoard.instantiateViewController(withIdentifier: "NewPage") as! NewPage
            mainVC.modalPresentationStyle = .fullScreen
            self.present(mainVC, animated: true, completion: nil)
        }
        
    }
    @IBAction func otpVerifyBtn(_ sender: Any) {
        var otpNum = otpText.text!
        if otpNum.isValidOtp(_number: otpNum){
            
            let url = URL(string: "https://lmachpay.nexdha.com/api/verify_otp")
            guard url != nil else{
                print("erorr")
                return
            }
            var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
            request.httpMethod = "POST"
            let requestObject = ["phone":number, "otp":otpNum]
            do{
                let requestBody = try JSONSerialization.data(withJSONObject: requestObject, options: .fragmentsAllowed)
                request.httpBody = requestBody
                print(requestBody)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            }catch{
                print(number)
            }
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { [self] data, responce, error in
                
                do{
                    let parsingData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: AnyObject]
                    var responseString = String(data: data!, encoding: .utf8)
                    
                    print(responseString!)
                    print(responseString.hashValue)
                    let data = Data(responseString!.utf8)
                    do {
                        // make sure this JSON is in the format we expect
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            // try to read out a string array
                            print(json)
                            
                            if json["Details"] as! String == "OTP Matched"{
                                
                                token = json["token"] as! String
                                print(token)
                                gotoNewPage()
                               
                            }else{
                                print(json["Details"]!)
                            }
                            
                        }
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                        
                    
                  /*let decoder = JSONDecoder()
                    if  let responseStatus = try? decoder.decode(jsonStatus.self, from: responseString?.data(using: .utf8)!) {
                        for responce in responseStatus {
                            print(responce.status)
                        }
                    }
                    */
                }catch{
                    print("erorr")
                }
            }
            dataTask.resume()
            
            /*let verifyOTP = ["phone":number, "otp":otpNum] as Dictionary<String, String>
    
            print(otpNum)
            var request = URLRequest(url: URL(string: "https://lmachpay.nexdha.com/api/verify_otp")!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: verifyOTP, options: [])
        
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                print(response!)
                do {
                    let json = try JSONSerialization.jsonObject(with: data!)
            
                } catch {
                    let dialogMessage = UIAlertController(title: "alert", message: "Please enter a Valid OTP number", preferredStyle: .alert)
                    dialogMessage.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(dialogMessage, animated: true, completion: nil)
                }
            })
            task.resume()*/
            
                //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //let mainVC = storyBoard.instantiateViewController(withIdentifier: "NewPage") as! NewPage
                //mainVC.modalPresentationStyle = .fullScreen
                //self.present(mainVC, animated: true, completion: nil)
            
        }else{
            let dialogMessage = UIAlertController(title: "alert", message: "please enter your OTP", preferredStyle: .alert)
            dialogMessage.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    }

extension String{
    func isValidOtp(_number: String) -> Bool {                           //number Validation
        let numberRegEx = "^[0-9]{4}$"
        let numberPred = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return numberPred.evaluate(with: self)
    }
}

//NewPage

class NewPage:UIViewController{
    
    @IBOutlet weak var row2: UIView!
    @IBOutlet weak var row1: UIView!
    @IBOutlet weak var card3: UIView!
    @IBOutlet weak var card1: UIView!
    @IBOutlet weak var card2: UIView!
    @IBOutlet weak var feedbackBtn: UIView!
    @IBOutlet weak var card1btn: UIButton!
    @IBOutlet weak var nameTextLableField1: UILabel!
    @IBOutlet weak var nameTextLableField2: UILabel!
    var tokenID = token
    var userName:String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        card2.layer.cornerRadius = 20
        card1.layer.cornerRadius = 20
        card3.layer.cornerRadius = 8
        feedbackBtn.layer.cornerRadius = 8
        let bottomLine1 = CALayer()
        bottomLine1.frame = CGRect(x: 0.0, y: row1.frame.height - 1, width: 310, height: 1.0)
        bottomLine1.backgroundColor = UIColor.lightGray.cgColor
        row1.layer.addSublayer(bottomLine1)
        
        let bottomLine2 = CALayer()
        bottomLine2.frame = CGRect(x: 0.0, y: row2.frame.height - 1, width: 310, height: 1.0)
        bottomLine2.backgroundColor = UIColor.lightGray.cgColor
        row2.layer.addSublayer(bottomLine2)
        
        
        userPage()
        
    }
    func userPage(){
        let url = URL(string: "https://lmachpay.nexdha.com/api/getuserdetails")
        guard url != nil else{
            print("erorr")
            return
        }
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        let headers = ["content-type" : "application/json",
                       "Authorization": "token \(tokenID)"]
        request.httpMethod = "POST"
        
        request.allHTTPHeaderFields = headers
        
        let requestObject = ["Details":"headers"]
        do{
            let requestBody = try JSONSerialization.data(withJSONObject: requestObject, options: .fragmentsAllowed)
            request.httpBody = requestBody
            print(requestBody)
        }catch{
            print("erorr")
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { [self] data, responce, error in
            
            do{
                let parsingData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: AnyObject]
                var responseString = String(data: data!, encoding: .utf8)
                
                let data = Data(responseString!.utf8)
                do {
                    // make sure this JSON is in the format we expect
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        // try to read out a string array
                        print(json)
                        print(tokenID)
                        userName = json["name"] as! String
                        DispatchQueue.main.async {
                            nameTextLableField1.text = "Hello \(userName)"
                            nameTextLableField2.text = userName
                        }
                        
                        print(userName)
                    }
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
                
            }catch{
                print("erorr")
            }
        }
        dataTask.resume()
    }
}
    
    







    
    



