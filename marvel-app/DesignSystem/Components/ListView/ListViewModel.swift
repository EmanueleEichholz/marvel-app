//
//  ListViewModel.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 05/01/23.
//

import Foundation

struct ListViewModel {
    let type: TextType
    let title: String
    let items: [String]
}

enum TextType {
    case plainText
    case link
}
