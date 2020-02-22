
import Foundation
import UIKit

public enum Fonts: String, CaseIterable {
    case starJediSpecialEdition = "StarJediSpecialEdition"
    
    static var installed = false
}

public extension Fonts {
    static func install(from bundles: [Bundle] = [ Bundle.main ] ) {
        Fonts.installed = true
        for each in Fonts.allCases {
            for bundle in bundles {
                if let cfURL = bundle.url(forResource:each.rawValue, withExtension: "ttf") {
                    CTFontManagerRegisterFontsForURL(cfURL as CFURL, .process, nil)
                } else {
                    assertionFailure("Could not find font:\(each.rawValue) in bundle:\(bundle)")
                }
            }
        }
    }
}


/// Use this extension function to get a font with the specified size
public extension Fonts {
    func size(_ size : CGFloat) -> UIFont {
        if Fonts.installed == false {
            Fonts.install()
        }
        return UIFont(name: self.rawValue, size:  size)!
    }
}
