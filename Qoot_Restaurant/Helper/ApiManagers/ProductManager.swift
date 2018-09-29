//
//  ProductManager.swift
//  Fetch
//
//  Created by Bibin Mathew on 7/2/18.
//  Copyright © 2018 CL. All rights reserved.
//

import UIKit

class ProductManager: CLBaseService {
    
    //MARK: Get All Products Api
    
    func callingGetAllProdutsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForAllProducts(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getProuctResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForAllProducts(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+GET_ALL_PRODUCTS, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    func getProuctResponseModel(dict:[String : Any?]) -> Any? {
        let loginReponseModel = FetchProductResponseModel.init(dict:dict)
        return loginReponseModel
    }
    
    //MARK - Get All Products from Sub categories
    
    func callingGetAllProdutsFromSubCategoriesApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForAllProductsFromSubcategories(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getProuctResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForAllProductsFromSubcategories(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+GET_ALL_PRO_FROM_SUBCAT, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    
    
    //MARK: Get All Products Api with Search Bar
    
    
    func callingGetAllSearchProdutsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForSearchProducts(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getProuctResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForSearchProducts(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+GET_ALL_SEARCH_PRODUCTS, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    //MARK: Get Product Details
    
    func callingGetProdutDetailsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForProductDetails(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getProuctDetailResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForProductDetails(with body:String)->CLNetworkModel{
        let registerRequestModel = CLNetworkModel.init(url: BASE_URL+GET_PRODUCT_DETAILS, requestMethod_: "POST")
        registerRequestModel.requestBody = body
        return registerRequestModel
    }
    
    func getProuctDetailResponseModel(dict:[String : Any?]) -> Any? {
        let productDetailReponseModel = FetchProductDetailResponseModel.init(dict:dict)
        return productDetailReponseModel
    }

    //MARK: Purchase History Api
    
    func callingPurchaseHistoryApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForPurchaseHistory(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getPurchaseHistoryResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForPurchaseHistory(with body:String)->CLNetworkModel{
        let purchaseHistoryRequestModel = CLNetworkModel.init(url: BASE_URL+GET_CART_LIST_HISTORY, requestMethod_: "POST")
        purchaseHistoryRequestModel.requestBody = body
        return purchaseHistoryRequestModel
    }
    
    func getPurchaseHistoryResponseModel(dict:[String : Any?]) -> Any? {
        let orderHistoryResponseModel = OrderHistoryResponseModel.init(dict:dict)
        return orderHistoryResponseModel
    }
    
    
    //MARK: Terms and Conditions Api
    
    func callingTermsAndConditionsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForTermsAndConditions(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.geTermsAndConditionsResponse(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForTermsAndConditions(with body:String)->CLNetworkModel{
        let termsRequestModel = CLNetworkModel.init(url: BASE_URL+TERMS_AND_CONDITIONS, requestMethod_: "POST")
        termsRequestModel.requestBody = body
        return termsRequestModel
    }
    
    func geTermsAndConditionsResponse(dict:[String : Any?]) -> Any? {
        let termsRequestModel = PurchaseHistoryResponseModel.init(dict:dict)
        return termsRequestModel
    }
    
    //MARK - Get All Brands
    
    func callingGetAllBrandsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForAllBrands(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getBrandResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func getBrandResponseModel(dict:[String : Any?]) -> Any? {
        let loginReponseModel = FetchBrandResponseModel.init(dict:dict)
        return loginReponseModel
    }
    
    func networkModelForAllBrands(with body:String)->CLNetworkModel{
        let brandRequestModel = CLNetworkModel.init(url: BASE_URL+GET_BRANDS_URL, requestMethod_: "POST")
        brandRequestModel.requestBody = body
        return brandRequestModel
    }
    
    //MARK - Get All Breeds
    
    func callingGetAllBreedsApi(with body:String, success : @escaping (Any)->(),failure : @escaping (_ errorType:ErrorType)->()){
        CLNetworkManager().initateWebRequest(networkModelForAllBreeds(with:body), success: {
            (resultData) in
            let (jsonDict, error) = self.didReceiveStatesResponseSuccessFully(resultData)
            if error == nil {
                if let jdict = jsonDict{
                    print(jsonDict)
                    success(self.getBreedResponseModel(dict: jdict) as Any)
                }else{
                    failure(ErrorType.dataError)
                }
            }else{
                failure(ErrorType.dataError)
            }
            
        }, failiure: {(error)-> () in failure(error)
            
        })
        
    }
    
    func networkModelForAllBreeds(with body:String)->CLNetworkModel{
        let breedRequestModel = CLNetworkModel.init(url: BASE_URL+GET_BREEDS_URL, requestMethod_: "POST")
        breedRequestModel.requestBody = body
        return breedRequestModel
    }
    
    func getBreedResponseModel(dict:[String : Any?]) -> Any? {
        let breedReponseModel = FetchBreedResponseModel.init(dict:dict)
        return breedReponseModel
    }
}

class OrderHistoryResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var dataArray = [OrderHistoryData]()
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        if let value = dict["errorMsg"] as? String{
            errorMessage = value
        }
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["data"] as? NSArray{
            for item in value{
                dataArray.append(OrderHistoryData.init(dict: item as! [String : Any?]))
            }
        }
    }
}

class OrderHistoryData : NSObject{
    var id:Int = 0
    var order_date:String = ""
    var grand_total:Double = 0
    var historyArray = [OrderHistory]()
    init(dict:[String:Any?]) {
        if let value = dict["id"] as? Int{
            id = value
        }
        if let value = dict["order_date"] as? String{
            order_date = value
        }
        if let value = dict["grand_total"] as? Double{
            grand_total = value
        }
        if let value = dict["history"] as? NSArray{
            for item in value{
                historyArray.append(OrderHistory.init(dict: item as! [String : Any?]))
            }
        }
    }
}

class OrderHistory : NSObject{
    var product_id:Int = 0
    var product_name:String = ""
    var brand_name:String = ""
    var product_desc:String = ""
    var produc_image:String = ""
    var unit_pricce:Double = 0
    var quantity:Int = 0
    var order_id:Int = 0
    var availability:Int = 0
    var total_price:Double = 0
    var purchased_price:Double = 0
    init(dict:[String:Any?]) {
        if let value = dict["product_id"] as? Int{
            product_id = value
        }
        if let value = dict["productName"] as? String{
            product_name = value
        }
        if let value = dict["prod_description"] as? String{
            product_desc = value
        }
        if let value = dict["brand_name"] as? String{
            brand_name = value
        }
        if let value = dict["productImage"] as? String{
            produc_image = value
        }
        if let value = dict["unit_price"] as? Double{
            unit_pricce = value
        }
        if let value = dict["availability"] as? Int{
            availability = value
        }
        if let value = dict["quantity"] as? Int{
            quantity = value
        }
        if let value = dict["order_id"] as? Int{
            order_id = value
        }
        if let value = dict["total_price"] as? Double{
            total_price = value
        }
        if let value = dict["purchased_price"] as? Double{
            purchased_price = value
        }
    }
}

class PurchaseHistoryResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var url:String = ""
    var productArray = [ProductHistory]()
    var totalAmount:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        if let value = dict["errorMsg"] as? String{
            errorMessage = value
        }
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["url"] as? String{
            url = value
        }
        if let value = dict["Total_amount"] as? Int{
            totalAmount = value
        }
        if let value = dict["data"] as? NSArray{
            for item in value{
                productArray.append(ProductHistory.init(dict: item as! [String : Any?]))
            }
        }
    }
}

class ProductHistory : NSObject{
    var count:Int = 0
    var price:Double = 0
    var id:Int = 0
    var product_id:Int = 0
    var productName:String = ""
    var prod_description:String = ""
    var availability:Double = 0
    var subcategory_id:Int = 0
    var product_type:String = ""
    var last_updated_date:String = ""
    var categoryName:String = ""
    var productImage:String = ""
    init(dict:[String:Any?]) {
        if let value = dict["count"] as? Int{
            count = value
        }
        if let value = dict["price"] as? Double{
            price = value
        }
        if let value = dict["id"] as? Int{
            id = value
        }
        if let value = dict["product_id"] as? Int{
            product_id = value
        }
        if let value = dict["productName"] as? String{
            productName = value
        }
        if let value = dict["prod_description"] as? String{
            prod_description = value
        }
        if let value = dict["availability"] as? Double{
            availability = value
        }
        if let value = dict["subcategory_id"] as? Int{
            subcategory_id = value
        }
        if let value = dict["product_type"] as? String{
            product_type = value
        }
        if let value = dict["last_updated_date"] as? String{
            last_updated_date = value
        }
        if let value = dict["categoryName"] as? String{
            categoryName = value
        }
        if let value = dict["productImage"] as? String{
            productImage = value
        }
    }
}

class FetchProductResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var productArray = [FetchProduct]()
    var totalProducts:Int = 0
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        if let value = dict["errorMsg"] as? String{
            errorMessage = value
        }
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["total"] as? Int{
            totalProducts = value
        }
        if let value = dict["data"] as? NSArray{
            for item in value{
                productArray.append(FetchProduct.init(dict: item as! [String : Any?]))
            }
        }
    }
}

class FetchBrandResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var brandArray = [FetchBrand]()
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        if let value = dict["errorMsg"] as? String{
            errorMessage = value
        }
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["data"] as? NSArray{
            for item in value{
                brandArray.append(FetchBrand.init(dict: item as! [String : Any?]))
            }
        }
    }
}

class FetchBrand : NSObject{
    var brandId:Int = 0
    var brandName:String = ""
   
    init(dict:[String:Any?]) {
        if let value = dict["id"] as? Int{
            brandId = value
        }
        if let value = dict["brand_name"] as? String{
            brandName = value
        }
    }
}

class FetchBreedResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var breedArray = [FetchBreed]()
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        if let value = dict["errorMsg"] as? String{
            errorMessage = value
        }
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["data"] as? NSArray{
            for item in value{
                breedArray.append(FetchBreed.init(dict: item as! [String : Any?]))
            }
        }
    }
}

class FetchBreed : NSObject{
    var breedId:Int = 0
    var breedName:String = ""
    
    init(dict:[String:Any?]) {
        if let value = dict["id"] as? Int{
            breedId = value
        }
        if let value = dict["breed_name"] as? String{
            breedName = value
        }
    }
}

class FetchProduct : NSObject{
    var productAmount:Double = 0.0
    var productDescription = ""
    var productQuantity:Int = 0
    var selectedQuantity:Int = 1
    var productImage:String = ""
    var productName:String = ""
    var productId:Int = 0
    var created_date:String = ""
    var last_updated_date:String = ""
    var categoryName:String = ""
    var brandName:String = ""
    init(dict:[String:Any?]) {
        if let value = dict["product_id"] as? Int{
            productId = value
        }
        if let value = dict["productName"] as? String{
            productName = value
        }
        if let value = dict["productImage"] as? String{
            productImage = value
        }
        if let value = dict["prod_quantity"] as? Int{
            productQuantity = value
        }
        if let value = dict["prod_description"] as? String{
            productDescription = value
        }
        if let value = dict["prod_amount"] as? Double{
            productAmount = value
        }
        if let value = dict["last_updated_date"] as? String{
            last_updated_date = value
        }
        if let value = dict["created_date"] as? String{
            created_date = value
        }
        if let value = dict["categoryName"] as? String{
            categoryName = value
        }
        if let value = dict["brand_name"] as? String{
            brandName = value
        }
    }
}

class FetchProductDetailResponseModel : NSObject{
    var statusMessage:String = ""
    var errorMessage:String = ""
    var statusCode:Int = 0
    var product:FetchProduct?
    init(dict:[String:Any?]) {
        if let value = dict["statusMessage"] as? String{
            statusMessage = value
        }
        if let value = dict["errorMsg"] as? String{
            errorMessage = value
        }
        if let value = dict["statusCode"] as? Int{
            statusCode = value
        }
        if let value = dict["data"] as? NSDictionary{
            product = FetchProduct.init(dict: value as! [String : Any?])
        }
    }
}
