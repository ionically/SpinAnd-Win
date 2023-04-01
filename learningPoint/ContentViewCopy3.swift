//
//  ContentView.swift
//  learningPoint
//
//  Created by chandni chaudhari on 19/03/23.
//

import SwiftUI
import UIKit

struct ContentViewCopy3: View {

    @State private var cpuCard = "card"
    @State private var playerCard = "card"
    @State private var cpuScore = 0
    @State private var playerScore = 0
    @State var winnerName = "-- WINNER NAME --"
    @State var ballOffset: CGSize = CGSize(width: 0, height: 0)
    @State var counter1 = (" Player Name :")
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Circle().fill(Color.yellow)
                        .frame(width: 30,height: 30,alignment: .center)
                }
                .offset(ballOffset)
                .position(x:10,y:10)
            }
//            .border(.black)
            .frame(width: ballBorderEndWidth, height: ballBorderEndHeight)
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(1..<10) { i in
                        Circle()
                            .foregroundColor(.pink)
                            .frame(width: 40,height: 40,alignment: .center)
                    }
                }.frame(width: ballBorderEndWidth, height: 40)
            }
            VStack(spacing:0) {
                Text("PLAYER SCORE: \(playerScore)")
                    .frame(width: ballBorderEndWidth,height: 100,alignment: .center)
                Button(action: {
                    animate()
                }) {
                    Text("🎾")
                        .frame(width: 50, height: 50)
                        .border(.black)
                }
                Spacer()
            }
            
        }
        .background(Color.purple)
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
    
    struct ContentViewCopy3_Previews: PreviewProvider {
        static var previews: some View {
            ContentViewCopy3()
        }
    }
}
