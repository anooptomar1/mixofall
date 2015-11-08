//
//  mySeekTime.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 10/25/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import Foundation
final class mySeekTime: NSObject, NSCoding {
    var value: Int64 = 0
    var timescale: Int32 = 0
    var flags: UInt32 = 0
    var epoch: Int64 = 0

    override init() {
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeInt64(value, forKey: "value")
        aCoder.encodeInt32(timescale, forKey: "timescale")
        aCoder.encodeInt32(Int32(flags), forKey: "flags")
        aCoder.encodeInt64(epoch, forKey: "epoch")
    }
    
    required init(coder aDecoder: NSCoder) {
        value = aDecoder.decodeInt64ForKey("value")
        timescale = aDecoder.decodeInt32ForKey("timescale")
        flags = UInt32(aDecoder.decodeInt32ForKey("flags"))
        epoch = aDecoder.decodeInt64ForKey("epoch")
    }
}