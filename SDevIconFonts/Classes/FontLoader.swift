//
//  FontLoader.swift
//  SDevIconFontDemo
//
//  Created by Sedat Ciftci on 06/09/15.
//  Copyright © 2015 Sedat Ciftci. All rights reserved.
//

import UIKit
import CoreText

class FontLoader: NSObject {
    class func loadFont(fontName: String) {
        let bundle = NSBundle(forClass: FontLoader.self)
        var fontURL = NSURL()
        let identifier = bundle.bundleIdentifier
        
        if identifier?.hasPrefix("org.cocoapods") == true {
            fontURL = bundle.URLForResource(fontName, withExtension: "ttf", subdirectory: "SDevIconFonts.swift.bundle")!
        } else {
            fontURL = bundle.URLForResource(fontName, withExtension: "ttf")!
        }
        
        let data = NSData(contentsOfURL: fontURL)!
        
        let provider = CGDataProviderCreateWithCFData(data)
        let font = CGFontCreateWithDataProvider(provider)!
        
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            let errorDescription: CFStringRef = CFErrorCopyDescription(error!.takeUnretainedValue())
            let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
            NSException(name: NSInternalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
        }
    }
}
