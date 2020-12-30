//
//  Extensions.swift
//  Tofy
//
//  Created by usuario on 28/12/20.
//

import Foundation


extension String{
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
