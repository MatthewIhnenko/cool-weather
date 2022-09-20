//
//  String+Localazible.swift
//  cool weather
//
//  Created by Matthew on 6.07.22.
//

import Foundation


extension String {
    
    func localized() -> String {
      
        return NSLocalizedString(self, comment: "")
    }
    
}

