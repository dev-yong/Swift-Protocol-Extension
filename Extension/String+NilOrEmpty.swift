//
//  String+NilOrEmpty.swift
//  BBS
//
//  Created by 이광용 on 2018. 7. 6..
//  Copyright © 2018년 이광용. All rights reserved.
//

import Foundation

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces).trimmingCharacters(in: CharacterSet.newlines)
    }
    func isNilOrEmpty()->Bool{
        if(self.trim().isEmpty){return true}
        else{return false}
    }
}
