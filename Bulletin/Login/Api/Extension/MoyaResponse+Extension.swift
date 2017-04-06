//
//  MoyaResponse+Extension.swift
//  Bulletin
//
//  Created by huangyuan on 06/04/2017.
//  Copyright © 2017 hYDev. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

extension Response {
    var responseJSON: JSON {
        guard let json = try? mapJSON() else {
            return JSON([])
        }
        return JSON(json)
    }
    
    var dataJSON: JSON {
        return responseJSON["data"]
    }
    
    var metaJSON: JSON {
        return responseJSON["metaData"]
    }
    
    var message: String {
        return responseJSON["message"].stringValue
    }
}
