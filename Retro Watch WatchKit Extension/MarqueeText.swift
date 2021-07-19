//
//  MarqueeText.swift
//  Retro Watch WatchKit Extension
//
//  Created by Sakun on 4/27/21.
//

import SwiftUI

struct MarqueeText : View {
@State var text = ""
@State private var animate = false
private let animationOne = Animation.linear(duration: 10).delay(2.5).repeatForever(autoreverses: false)

var body : some View {
    let stringWidth = text.widthOfString(usingFont: UIFont.systemFont(ofSize: 15))
    return ZStack {
            GeometryReader { geometry in
                Text(self.text).lineLimit(1)
                    .font(.subheadline)
                    .offset(x: self.animate ? -stringWidth * 2 : 0)
                    .animation(self.animationOne)
                    .onAppear() {
                        if geometry.size.width < stringWidth {
                             self.animate = true
                        }
                }
                .fixedSize(horizontal: true, vertical: false)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                
                Text(self.text).lineLimit(1)
                    .font(.subheadline)
                    .offset(x: self.animate ? 0 : stringWidth * 2)
                    .animation(self.animationOne)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
}
extension String {

       func widthOfString(usingFont font: UIFont) -> CGFloat {
           let fontAttributes = [NSAttributedString.Key.font: font]
           let size = self.size(withAttributes: fontAttributes)
           return size.width
       }

       func heightOfString(usingFont font: UIFont) -> CGFloat {
           let fontAttributes = [NSAttributedString.Key.font: font]
           let size = self.size(withAttributes: fontAttributes)
           return size.height
       }

       func sizeOfString(usingFont font: UIFont) -> CGSize {
           let fontAttributes = [NSAttributedString.Key.font: font]
           return self.size(withAttributes: fontAttributes)
       }
    }
