//
//  ContentView.swift
//  learningPoint
//
//  Created by chandni chaudhari on 19/03/23.
//

import SwiftUI
import UIKit

struct ContentViewCopy2: View {
    @State var ballOffset: CGSize = CGSize(width: 0, height: 0)
    
    var body: some View {
        VStack(spacing:0) {
            VStack {
                GeometryReader { insideSize in
                    VStack(spacing: 0) {
                        greenBall
                            .border(.black)
                    }.offset(ballOffset)
                }
            }
            .frame(minWidth: ballBorderStartWidth,
                   maxWidth: ballBorderEndWidth ,
                   minHeight: ballBorderStartHeight,
                   maxHeight: ballBorderEndHeight)
            .border(.black)
            .background(.purple)
            VStack(spacing:0) {
                Button(action: {
                    animate()
                }) {
                    Text("🎾")
                        .frame(width: 50, height: 50)
                        .border(.black)
                }
            }
        }
        
        .onAppear {
           
        }
        
    }
    
    func animate() {
        Timer.scheduledTimer(withTimeInterval:interval, repeats: true) { _ in
            withAnimation(.linear(duration: interval)) {
                self.setBallOffset()
            }
        }
    }
    
    func setBallOffset() {
        updateXYValues()
        withAnimation {
            ballOffset = CGSize(width: X, height:  Y)
        }
    }
    
    struct ContentViewCopy2_Previews: PreviewProvider {
        static var previews: some View {
            ContentViewCopy2()
        }
    }
}
