import Foundation

protocol NilOrEmpty {
    func trim() -> String?
    func isNilOrEmpty() -> Bool
}

extension String: NilOrEmpty {
    func trim() -> String? {
        return self.trimmingCharacters(in: CharacterSet.whitespaces).trimmingCharacters(in: CharacterSet.newlines)
    }
    func isNilOrEmpty()->Bool{
        guard let str = self.trim() else {return false}
        if(str.isEmpty){return true}
        else{return false}
    }
}

extension Optional: NilOrEmpty where Wrapped == String {
    func trim() -> String? {
        guard let `self` = self else {return nil}
        return self.trimmingCharacters(in: CharacterSet.whitespaces).trimmingCharacters(in: CharacterSet.newlines)
    }
    func isNilOrEmpty()->Bool{
        guard let str = self.trim() else {return false}
        if(str.isEmpty){return true}
        else{return false}
    }
}

/*
    str.isNilOrEmpty()
 */
