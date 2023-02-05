//
//  URLBuilder.swift
//  Marvel
//
//  Created by Emanuele Eichholz on 13/12/22.
//

import Foundation

class MarvelURLBuilder {
    
    let baseURL = "https://gateway.marvel.com/v1/public"
    let timeStamp = Int(Date().timeIntervalSince1970)
    let privateKey = Bundle.main.object(forInfoDictionaryKey:  "PrivateKey") as? String
    let publicKey = Bundle.main.object(forInfoDictionaryKey: "PublicKey") as? String
    let listType: ListTypeEnum
    var offset: Int?
    var limit: Int?
    var nameStartsWith: String?
    
    init(with listType: ListTypeEnum) {
        self.listType = listType
    }
    
    func withFilterByName(_ nameStartsWith: String?) -> Self {
        self.nameStartsWith = nameStartsWith
        return self
    }
    
    func withOffset(_ offset: Int?) -> Self {
        self.offset = offset
        return self
    }
    
    func withLimit(_ limit: Int?) -> Self {
        self.limit = limit
        return self
    }
    
    func buildURL() -> String? {
        guard let privateKey = privateKey, let publicKey = publicKey else { return nil }
        let contentHash = (String(timeStamp) + privateKey + publicKey).MD5
        var url = "\(baseURL)/\(listType)?ts=\(timeStamp)&apikey=\(publicKey)&hash=\(contentHash)"
        
        if let offset = offset {
            url.append("&offset=\(offset)")
        }
        
        if let nameStartsWith = nameStartsWith {
            url.append("&nameStartsWith=\(nameStartsWith)")
        }
        
        if let limit = limit {
            url.append("&limit=\(limit)")
        }
        
        return url
    }
}

