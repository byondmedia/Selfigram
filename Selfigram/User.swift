//
//  User.swift
//  Selfigram
//
//  Created by Alejandra Anderson on 2016-11-10.
//  Copyright © 2016 Alejandra Anderson. All rights reserved.
//

import UIKit
import Foundation

class User {
    
    let username:String
    let profileImage:UIImage
    
    init(aUsername:String, aProfileImage:UIImage) {
        //we are setting the User property of "username" to an aUsername property you are going to pass in
        username = aUsername
        profileImage = aProfileImage
    }
    
}
