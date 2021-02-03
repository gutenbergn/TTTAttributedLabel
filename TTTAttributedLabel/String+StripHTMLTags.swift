//
//  String+StripHTMLTags.swift
//  VHX
//
//  Created by Gutenberg Neto on 08/10/20.
//  Copyright © 2020 VHX. All rights reserved.
//

import UIKit
import FuzeUtils

extension String {
    private static func getFixedLink(originalLink: String) -> String {
        var fixedLink = originalLink
        
        // first removes any space character from the link [GN]
        let linkComponents = originalLink.components(separatedBy: " ")
        if !linkComponents.isEmpty {
            fixedLink = linkComponents[0]
        }
        
        // then ensures that the link does not begin with a character that isn't a letter [GN]
        while fixedLink.count > 0 && !(fixedLink.first?.isLetter ?? false) {
            fixedLink = String(fixedLink.dropFirst())
        }
        
        // finally, ensures that the link does not end with a character that isn't a letter [GN]
        while fixedLink.count > 0 && !(fixedLink.last?.isLetter ?? false) {
            fixedLink = String(fixedLink.dropLast())
        }
        
        return fixedLink
    }
    
    static func linksFromHTMLTags(in str: String) -> [[String : String]] {
        var links: [[String : String]] = []
        let pattern = "(?i)<a([^>]+)>(.+?)</a>" // pattern for the "a href" HTML tag [GN]
        var rangePattern: Range<Index>?
        var lastLocationIndex = str.startIndex
        
        rangePattern = str.range(of: pattern, options: .regularExpression, range: lastLocationIndex..<str.endIndex)
        
        while let actualRangePattern = rangePattern {
            // checks for patterns that indicate the beginning/ending of the link and also the keyword [GN]
            let rangeBeginningURL = str.range(of: "=\"", options: .caseInsensitive,
                                                            range: actualRangePattern)
            let rangeEndingURL = str.range(of: "\">", options: .caseInsensitive,
                                                                       range: actualRangePattern)
            let rangeEndingTag = str.range(of: "</a>", options: .caseInsensitive,
                                                                       range: actualRangePattern)
            
            if let actualRangeBeginningURL = rangeBeginningURL, let actualRangeEndingURL = rangeEndingURL,
                let actualRangeEndingTag = rangeEndingTag {
                var link = String(str[actualRangeBeginningURL.upperBound..<actualRangeEndingURL.lowerBound])
                link = Self.getFixedLink(originalLink: link)
                
                let keyword = String(str[actualRangeEndingURL.upperBound..<actualRangeEndingTag.lowerBound])
                links.append(["link": link, "keyword": keyword])
            }
            
            lastLocationIndex = actualRangePattern.upperBound
            rangePattern = str.range(of: pattern, options: .regularExpression, range: lastLocationIndex..<str.endIndex)
        }
        
        return links
    }
    
    static func stripHTMLTags(from str: String) -> String {
        var finalString = str
        
        var range: Range<Index>?
        range = str.range(of: "<[^>]+>", options: .regularExpression)
        
        while let actualRange = range {
            finalString = finalString.replacingCharacters(in: actualRange, with: "")
            range = finalString.range(of: "<[^>]+>", options: .regularExpression)
        }
        
        return finalString
    }
}
