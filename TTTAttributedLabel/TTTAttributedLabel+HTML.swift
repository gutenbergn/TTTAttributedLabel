//
//  TTTAttributedLabel+HTML.swift
//  VHX
//
//  Created by Gutenberg Neto on 20/10/17.
//  Copyright © 2017 VHX. All rights reserved.
//

import UIKit

extension TTTAttributedLabel {
    func setText(_ text: String, lineSpacing: CGFloat = 20, addHTMLLinks: Bool = false, shouldAppend: Bool = false) {
        // ensures that no HTML tags will be displayed on the description [GN]
        let strippedText = String.stripHTMLTags(from: text)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = lineSpacing
        paragraphStyle.minimumLineHeight = lineSpacing
        
        let attributedText = NSAttributedString(
            string: strippedText,
            attributes: [NSAttributedString.Key.font: self.font,
                         NSAttributedString.Key.foregroundColor: self.textColor,
                         NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        if shouldAppend, let labelText = self.attributedText {
            let mutableAttributedString = NSMutableAttributedString()
            mutableAttributedString.append(labelText)
            mutableAttributedString.append(attributedText)
            self.text = NSAttributedString(attributedString: mutableAttributedString)
        } else {
            self.text = attributedText
        }

        guard let labelText = self.attributedText, addHTMLLinks else {
            return
        }
        
        // iterates through the original text and looks for HTML tags that will be added as links [GN]
        for linkDictionary in String.linksFromHTMLTags(in: text) {
            guard let linkKeyword = linkDictionary["keyword"],
                let linkValue = linkDictionary["link"],
                let linkURL = URL(string: linkValue) else {
                    continue
            }
            
            // ensures that the keyword exists in the label text [GN]
            let keywordRange = labelText.range(of: linkKeyword)
            if keywordRange.location != NSNotFound {
                self.addLink(to: linkURL, with: keywordRange)
            }
        }
    }
}
