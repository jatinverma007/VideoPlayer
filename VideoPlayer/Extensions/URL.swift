//
//  URL.swift
//  VideoPlayer
//
//  Created by jatin verma on 29/04/21.
//

import Foundation

extension URL {
    func convertToRedirectURL(scheme: String) -> URL? {
        var components = URLComponents.init(url: self, resolvingAgainstBaseURL: false)
        let schemeCopy = components?.scheme ?? ""
        components?.scheme = schemeCopy + scheme
        return components?.url
    }
    
    func convertFromRedirectURL(prefix: String) -> URL? {
        guard var comps = URLComponents(url: self, resolvingAgainstBaseURL: false) else {return nil}
        guard let scheme = comps.scheme else {return nil}
        comps.scheme = scheme.replacingOccurrences(of: prefix, with: "")
        return comps.url
    }
}
