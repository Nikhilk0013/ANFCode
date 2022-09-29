//
//  String.swift
//  ANF Code Test
//
//  Created by Nikhil on 28/09/22.
//

import UIKit

extension String {
    
    func toHtmlAttributedString() -> NSMutableAttributedString? {
        if let data = self.data(using: .utf8) {
            if let attributedString = try? NSMutableAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil) {
                
                attributedString.enumerateAttributes(in: NSRange(0..<attributedString.length), options: []) { (attributes, range, _) -> Void in
                    for (attribute, _) in attributes {
                        if attribute.rawValue == "NSLink" {
                            attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.black, range: range)
                            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
                        }
                    }
                }
                
                return attributedString
            }
            
        }
        
        return nil
    }
    
}
