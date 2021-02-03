//
//  TTTAttributedLabel+Links.swift
//  VHX
//
//  Created by Gutenberg Neto on 05/11/20.
//  Copyright © 2020 VHX. All rights reserved.
//

import UIKit

extension TTTAttributedLabel {
    public func setupLinkLabel(text: String, font: UIFont?, color: UIColor, linkColor: UIColor? = nil,
                        shouldIncludeLinkUnderline: Bool = true, alignment: NSTextAlignment = .left,
                        alpha: CGFloat = 1.0) {
        let textColor = color
        
        let attributedString = NSMutableAttributedString(
            string: text,
            attributes: self.defaultLinkedLabelAttributesDictionary(
                font: font, color: textColor) as? [NSAttributedStringKey: Any] ?? [:])
        
        let paragraphStyle = self.defaultAttributedLabelParagraphStyle(alignment: alignment)
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle,
                                      range: NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
        self.textAlignment = alignment
        
        self.setupLinkAttributes(font: font, color: linkColor ?? textColor,
                                 shouldIncludeLinkUnderline: shouldIncludeLinkUnderline)
    }
    
    private func setupLinkAttributes(font: UIFont?, color: UIColor, shouldIncludeLinkUnderline: Bool) {
        let linkAttributes = self.defaultLinkedLabelAttributesDictionary(font: font, color: color)
        if shouldIncludeLinkUnderline {
            linkAttributes[NSAttributedStringKey.underlineStyle] = NSNumber(integerLiteral: NSUnderlineStyle.styleSingle.rawValue)
        }
        
        self.linkAttributes = linkAttributes as? [AnyHashable : Any] ?? [:]
        
        let activeLinkAttributes = self.defaultLinkedLabelAttributesDictionary(font: font, color: color)
        if shouldIncludeLinkUnderline {
            activeLinkAttributes[NSAttributedStringKey.underlineStyle] = NSNumber(integerLiteral: NSUnderlineStyle.styleSingle.rawValue)
        }
        
        activeLinkAttributes[NSAttributedStringKey.foregroundColor] = UIColor.lightGray
        self.activeLinkAttributes = activeLinkAttributes as? [AnyHashable : Any] ?? [:]
    }
    
    private func defaultLinkedLabelAttributesDictionary(font: UIFont?, color: UIColor) -> NSMutableDictionary {
        return NSMutableDictionary(objects: [font as Any, color],
                                   forKeys: [NSAttributedStringKey.font as NSCopying, NSAttributedStringKey.foregroundColor as NSCopying])
    }
    
    private func defaultAttributedLabelParagraphStyle(lineSpacing: CGFloat = 3,
                                                      alignment: NSTextAlignment = .center) -> NSMutableParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineSpacing = lineSpacing
        
        return paragraphStyle
    }
}
