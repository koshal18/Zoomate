//
//  KSConstant.swift
//  Zoomate
//
//  Created by Koshal Saini on 29/06/18.
//  Copyright © 2018 Koshal Saini. All rights reserved.
//

import UIKit

let appDel = UIApplication.shared.delegate as! AppDelegate

let BaseUrl = "http://13.232.96.69/zoomate/apis/"

let SignUpUrl                               = "signUp"
let VerifyAccountUrl                        = "verifyAccount"
let ResendOTPURL                            = "resendOtp"
let LoginURL                                = "login"
let ForgotPasswordURL                       = "forgotPassword"
let SelectTypeURL                           = "selectType"
let SelectProfessionalRoleURL               = "selectProfessionalRole"
let SelectProfessionalSkillURL              = "selectProfessionalSkill"
let SelectProfessionalSpecialtiesUrl        = "selectProfessionalSpecialties"
let SelectcompleteProfessionalProfileUrl    = "completeProfessionalProfile"
let UploadImageUrl                          = "uploadImage"
let GetGalleryImagesUrl                     = "galleryImage"
let GetChangePassword                       = "changePassword"
let GetforgotPassword                       = "forgotPassword"
let GetuserInfo                             = "userInfo"
let GetUserList                             = "userList"
let AddReviewsUrl                           = "addReviews"
let AddAllChatUrl                           = "allChat"
let InboxChatUrl                            = "inboxChat"
let SendMessageUrl                          = "sendMessage"
let BookNow                                 = "bookProfessional"
let UserReviewInfoUrl                       = "userReviewInfo"


class KSConstant: NSObject {
    // MARK:-
    // MARK:- For DataManager Class
    let PROGRESS_TITLE = "Loading..."
    let TITLE = "Zoomate"
    let BLANK = ""
    let MESSAGE = "Please check network connection"
    let ENTITY = "Entity"
    let LOGIN_DETAILS = "loginDetails"
    
    
    // MARK:-
    // MARK:- For Singup Class
    let MSG_SIGN_UP_VALID_EMAIL = "Please enter valid email Id."
    let MSG_SIGN_UP_PASSWORD = "Please enter password."
    let MSG_PHONE_CODE = "Please select at least one country code."
    let MSG_PHONE_NUMBER = "Please enter phone number."
    
    // MARK:-
    // MARK:- For Phone Code Class
    let MSG_OTP = "Please enter OTP"
    
}
