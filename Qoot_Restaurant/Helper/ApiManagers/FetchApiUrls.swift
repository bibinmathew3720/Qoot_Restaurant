//
//  FetchApiUrls.swift
//  Fetch
//
//  Created by Bibin Mathew on 6/25/18.
//  Copyright © 2018 CL. All rights reserved.
//

import UIKit

let LOCAL  = "https://qoot.online/ksa/test/"
let PRODUCTION  = "https://qoot.online/ksa/"

let BASE_URL = LOCAL

//Customer
let REGISTER_URL = "Ios/Customer/CustomerSignup"
let LOGIN_URL = "Ios/Customer/LoginAction"
let SENDOTP_URL = "Ios/Customer/SendOtp"
let CHECK_OTP_URL = "Ios/Customer/CheckOtp"
let GETCITYNAMES_URL = "Ios/Customer/ViewCityNames"
let VIEWMEALTYPE_URL = "Ios/Customer/ViewMealType"
let ViewCuisines_URL = "Ios/Customer/ViewCuisines"
let ViewKitchens_URL = "Ios/Customer/ViewKitchens"
let OfferDishes_URL = "Ios/Customer/ViewOfferDishes"
let ReadyNowDishes_URL = "Ios/Customer/ViewReadyNow"
let DishDetails_URL = "Ios/Customer/ViewDishDetails"
let KitchenDetails_URL = "Ios/Customer/ViewKitchenDetails"
let KitchenInfo_URL = "Ios/Customer/ViewKitchenInfo"
let KitchenAdminRating_URL = "Ios/Customer/ViewKitchenAdminRating"
let KitchenCustomerRating_URL = "Ios/Customer/ViewKitchenCustomerRating"
let GetAllAddresses_URL = "Ios/Customer/ViewCustomerdeliveryAddress"
let AddCustomerOrder_URL = "Ios/Customer/AddCustomerOrder"
let AddCustomerAddress_URL = "Ios/Customer/AddCustomerdeliveryAddress"
let RemoveCustomerAddress_URL = "Ios/Customer/DeleteCustomerAddress"
let CustomerOrderHistory_URL = "Ios/Customer/ViewCustomerOrderHistory"



let FORGOT_PASS_URL = "user/forgotPassword"
let CHANGE_PASS_URL = "user/changePassword"
let EDIT_PROFILE_URL = "user/editProfile"
let GET_LOCATIONS_URL = "location/allLocations"
let GET_CATEGORIES_URL = "category/allCategories"
let GET_CAT_SUBCAT_URL = "category/getCategoriesSub"
let GET_CAT_TYPES = "category/getProductsTypeList"
let GET_ALL_PRODUCTS = "category/getProductsList"
let GET_ALL_PRO_FROM_SUBCAT = "category/ProductFromSubcategory"
let GET_PRODUCT_DETAILS = "category/getProductDetails"
let GET_ALL_SEARCH_PRODUCTS = "category/searchProduct"
let GET_CART_LIST = "purchase/getMyCartDetails"
let GET_CART_LIST_HISTORY = "purchase/purchaseHistory"
let ADD_TO_CART = "purchase/addToCart"
let CHECK_OUT_URL = "order/checkOutMyCart"

let GET_COUPON_CODE = "order/promotionalCode"
let TERMS_AND_CONDITIONS = "documents/termsConditions"
let PAYMENT_URL = "payment/processPayment"
let GET_NOTIFICATIONS = "user/getMySettings"
let GET_NOTIFICATIONS_HISTORY = "notification/getMyNotificationHistory"
let REMOVE_NOTIFICATIONS = "notification/myNotificationRemove"
let CHANGE_NOTIFICATIONS = "user/changeMySettings"
let ADD_FEEDBACK_URL = "application/submitMyFeedback"
let LOGOUT_URL = "user/signOut"
let CONTACT_US_URL = "application/submitContactForm"

let GET_BRANDS_URL = "category/getAllBrands"
let GET_BREEDS_URL = "category/getAllBreeds"
