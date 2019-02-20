//
//  SettingsVC.swift
//  Qoot
//
//  Created by Bibin Mathew on 9/26/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import GoogleMaps


class SettingsVC: BaseViewController {
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var kitchenNameLabel: UILabel!
    @IBOutlet weak var kitcheNameTextField: UITextField!
    @IBOutlet weak var ownerNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityNameButton: UIButton!
    @IBOutlet weak var mroofNumberTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var instagramTextField: UITextField!
    @IBOutlet weak var chooseKitcheLocationLabel: UILabel!
    @IBOutlet weak var locationMapView: GMSMapView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var updateProfileInfoButton: UIButton!
    
    @IBOutlet weak var changePassword: UILabel!
    @IBOutlet weak var oldPwdtF: UITextField!
    @IBOutlet weak var newPwdTF: UITextField!
    @IBOutlet weak var confirmPwdTF: UITextField!
    @IBOutlet weak var updatePwdButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var updateProfImageButton: UIButton!
    @IBOutlet weak var updateProfileImageHeightConstraint: NSLayoutConstraint!
    
    var selProfImage:UIImage?
    var updateProfImageButtonHeight:CGFloat = 33.0
    var userLocLatitude = 0.000000
    var userLocLongitude = 0.00000
    var locationMarker:GMSMarker!
    
    override func initView() {
        initialisation()
        localization()
    }
    
    func initialisation(){
        if let user = User.getUser(){
            if let photo = user.customerPhoto{
                profileImageView.loadImageUsingCache(withUrl: photo)
            }
            self.kitcheNameTextField.text = user.kitchenName
            self.ownerNameTextField.text = user.customerName
            self.cityNameButton.setTitle(user.kitchenCity, for: .normal)
            self.mroofNumberTextField.text = "\(user.mroofNumber)"
            self.phoneNumberTextField.text = user.mobNumber
            self.emailTextField.text = user.email
            self.instagramTextField.text = user.instagramPage
        }
        addingLeftBarButton()
    }
    
    func localization(){
        self.title = "MyProfile".localiz()
        self.detailsLabel.text = "Details".localiz()
        self.kitchenNameLabel.text = "KitchenName".localiz()
        self.ownerNameTextField.placeholder = "OwnerName".localiz()
        self.cityNameLabel.text = "City".localiz()
        self.mroofNumberTextField.placeholder = "MaroofNumber".localiz()
        self.phoneNumberTextField.placeholder = "MobNoPlaceholder".localiz()
        self.emailTextField.placeholder = "EmailPlaceholder".localiz()
        self.instagramTextField.placeholder = "InstagramPage".localiz()
        self.chooseKitcheLocationLabel.text = "ChooseKitchenLocation".localiz()
        self.locationTextField.placeholder = "Location".localiz()
        self.addressTextField.placeholder = "Address".localiz()
        self.updateProfileInfoButton.setTitle("UpdateProfileInfo".localiz(), for: .normal)
        changePassword.text = "ChangePassword".localiz()
        oldPwdtF.placeholder = "OldPassword".localiz()
        newPwdTF.placeholder = "NewPassword".localiz()
        confirmPwdTF.placeholder = "ConfirmNewPassword".localiz()
        updatePwdButton.setTitle("UpdatePassword".localiz(), for: UIControlState.normal)
        updateProfImageButton.setTitle("UpdateProfilePicture".localiz(), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Gesture Action
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //MARK: Button Actions
    
    @IBAction func cityNameButtonAction(_ sender: UIButton) {
    }
    
    override func leftNavButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateProfImageButtonAction(_ sender: UIButton) {
        if let selImage = self.selProfImage{
            self.callingUploadApi(image: selImage)
        }
    }
    
    @IBAction func updateProfileInfoButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func updatePasswordButtonAction(_ sender: UIButton) {
        if isValidChangePasswordRequest(){
            callingChangePasswordApi()
        }
    }
    
    func isValidChangePasswordRequest()->Bool{
        var isValid = true
        var message = ""
        if (newPwdTF.text?.isEmpty)!{
            message = "PASSWORDATLEASTSIXDIGITS".localiz()
            isValid = false
        }
        else if ((newPwdTF.text?.count)! < 6){
            message = "PASSWORDATLEASTSIXDIGITS".localiz()
            isValid = false
        }
        else if newPwdTF.text != confirmPwdTF.text{
            message = "NEWPASSWORDDOESNTMATCHES".localiz()
            isValid = false
        }
        if (!isValid){
            CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: message, parentController: self)
        }
        return isValid
    }
    
    //MARK: Change Password Api
    
    func  callingChangePasswordApi(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        UserManager().callingChangePasswordApi(with: getChangePwdRequestBody(), success: {
            (model) in
            MBProgressHUD.hide(for: self.view, animated: true)
           
            if let model = model as? ChangePasswordResponseModel{
                if model.statusCode == 1{
                    CCUtility.showDefaultAlertwithCompletionHandler(_title: Constant.AppName, _message: "PasswordChanged".localiz(), parentController: self, completion: { (okSuccess) in
                        self.dismiss(animated: true, completion: nil)
                    })
                }
                else{
                    CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: model.statusMessage, parentController: self)
                }
                
            }
            
        }) { (ErrorType) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if(ErrorType == .noNetwork){
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: Constant.ErrorMessages.noNetworkMessage, parentController: self)
            }
            else{
                CCUtility.showDefaultAlertwith(_title: Constant.AppName, _message: Constant.ErrorMessages.serverErrorMessamge, parentController: self)
            }
            
            print(ErrorType)
        }
    }
    
    func getChangePwdRequestBody()->String{
        var dataString:String = ""
        if let oldPwd = self.oldPwdtF.text {
            let oldPwdString:String = "OldPWD=\(oldPwd.urlEncode())"
            dataString = dataString + oldPwdString + "&"
        }
        if let newPwd = self.newPwdTF.text {
            let newPwdString:String = "NewPWD=\(newPwd.urlEncode())"
            dataString = dataString + newPwdString + "&"
        }
        if let user = User.getUser(){
            let userIdString:String = "KitchenId=\(user.kitchenId)"
            dataString = dataString + userIdString
        }
        return dataString
    }
    
    // MARK: - Camera Actions
    
    @IBAction func imageClickAction(_ sender: Any) {
        addingImagePickerController(sourceType: .photoLibrary)
        
    }
    
    func addingImagePickerController(sourceType:UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType;
        present(imagePicker, animated: true, completion: nil)
    }
}

extension SettingsVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true) {
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.selProfImage = pickedImage
                self.profileImageView.image = pickedImage
                self.updateProfileImageHeightConstraint.constant = CGFloat(self.updateProfImageButtonHeight)
            }
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func callingUploadApi(image:UIImage){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        var dict:[String:String] = [String:String]()
        dict.updateValue(Constant.ApiKey, forKey: "apikey")
        if let user = User.getUser(){
            dict.updateValue("\(user.kitchenId)", forKey: "KitchenId")
        }
        let uploadProfImageUrl = BASE_URL+UploadProfileImage_Url
        if  let imageData = UIImageJPEGRepresentation(image, 0.6) {
            requestWith(endUrl: uploadProfImageUrl, imageData: imageData, parameters: dict, onCompletion: { (success) in
                MBProgressHUD.hide(for: self.view, animated: true)
                self.updateProfileImageHeightConstraint.constant = 0
                print("Success")
            }) { (error) in
                MBProgressHUD.hide(for: self.view, animated: true)
                print("Failure")
            }
        }
       
       
    }
    
    
    func requestWith(endUrl: String, imageData: Data?, parameters: [String : Any], onCompletion: ((Bool) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = imageData{
                multipartFormData.append(data, withName: "file", fileName: "file.png", mimeType: "image/png")
            }
            
        }, usingThreshold: UInt64.init(), to: endUrl, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    
                    print("Response:\(response)")
                    
                    print("Succesfully uploaded")
                    if let err = response.error{
                        print(err.localizedDescription)
                        onError?(err)
                        return
                    }
                    else{
                        if let result = response.result.value{
                            if let responseObject = result as? Dictionary<String, Any> {
                                let profileImagemodel = UploadProfileImageResponse.init(dict: responseObject)
                                User.updateProfileImage(updateProfileImageResponse: profileImagemodel)
                            }
                        }
                       
                    }
                    onCompletion?(true)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
            }
        }
    }
    
}

extension SettingsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.oldPwdtF {
            newPwdTF.becomeFirstResponder()
        }
        else if textField == self.newPwdTF {
            confirmPwdTF.becomeFirstResponder()
        }
        else{
            textField.resignFirstResponder()
        }
        return true
    }
}

extension SettingsVC:GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        var destinationLocation = CLLocation()
        destinationLocation = CLLocation(latitude: mapView.camera.target.latitude, longitude: mapView.camera.target.longitude)
        let destinationCoordinate:CLLocationCoordinate2D = destinationLocation.coordinate
        updateLocationoordinates(coordinates: destinationCoordinate)
        let geoCoder = GMSGeocoder()
        geoCoder.reverseGeocodeCoordinate(destinationCoordinate) { (results, error) in
            if let res = results {
                var addressString = ""
                if let addressDetails = res.firstResult() {
                    if let throughFare = addressDetails.thoroughfare {
                        addressString = addressString + throughFare
                    }
                    if let subLocality = addressDetails.subLocality {
                        if addressString.count > 0{
                            addressString = addressString + ", " + subLocality
                        }
                        else{
                            addressString = addressString + subLocality
                        }
                    }
                    if let locality = addressDetails.locality {
                        if addressString.count > 0{
                            addressString = addressString + ", " + locality
                        }
                        else{
                            addressString = addressString + locality
                        }
                    }
                    if let adArea = addressDetails.administrativeArea {
                        if addressString.count > 0{
                            addressString = addressString + ", " + adArea
                        }
                        else{
                            addressString = addressString + adArea
                        }
                    }
                    if let postalCode = addressDetails.postalCode {
                        if addressString.count > 0{
                            addressString = addressString + ", " + postalCode
                        }
                        else{
                            addressString = addressString + postalCode
                        }
                    }
                    if let country = addressDetails.country {
                        if addressString.count > 0{
                            addressString = addressString + ", " + country
                        }
                        else{
                            addressString = addressString + country
                        }
                    }
                }
                self.locationTextField.text = addressString
            }
            print("Ad Area:\(results?.firstResult()?.administrativeArea)")
            print("Locality:\(results?.firstResult()?.locality)")
            print("Sub locality:\(results?.firstResult()?.subLocality)")
            print("Country:\(results?.firstResult()?.country)")
            print("Through Fare:\(results?.firstResult()?.thoroughfare)")
            print("Postal Code:\(results?.firstResult()?.postalCode)")
        }
        
    }
    
    func updateLocationoordinates(coordinates:CLLocationCoordinate2D) {
        userLocLatitude = locationMapView.camera.target.latitude
        userLocLongitude = locationMapView.camera.target.longitude
        if locationMarker == nil
        {
            locationMarker = GMSMarker()
            let markerImage = UIImage(named: "locationPin")!.withRenderingMode(.alwaysOriginal)
            let markerView = UIImageView(image: markerImage)
            locationMarker.iconView = markerView
            locationMarker.position = coordinates
            locationMarker.map = locationMapView
            locationMarker.appearAnimation = GMSMarkerAnimation.pop
        }
        else
        {
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.25)
            locationMarker.position =  coordinates
            CATransaction.commit()
        }
    }
    
}

