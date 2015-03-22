// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
paragraphStyle.lineSpacing = 4.0

var attributes = [NSParagraphStyleAttributeName: paragraphStyle]

var attributedString = NSAttributedString(string: str, attributes: attributes)
