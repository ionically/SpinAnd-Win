//
//  ContentView.swift
//  learningPoint
//
//  Created by chandni chaudhari on 19/03/23.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var card1 = " "
    var ball = "ball"
    @State var bounce = true
    @State private var initialVelocity:Double = 20
    @State private var damping:Double = 10
    @State private var stiffness:Double = 100
    @State var appear = false
    @State private var zRotateAnimation = false
    @State private var cpuCard = "card"
    @State private var playerCard = "card"
    @State private var cpuScore = 0
    @State private var playerScore = 0
    @State var counter = ("")
    @State var counter1 = (" Player Name :")
    @State var winnerName = "-- WINNER NAME --"
    
    var body: some View {
        VStack{
            Image("card1").hidden()
                .frame(height: 150)
                .cornerRadius(60)
            ScrollView(.horizontal){
                LazyHStack{
                    Circle()
                        .animation(.easeInOut, value: 1.0)
                        .foregroundColor(.red)
                        .frame(width: 0,height: 40,alignment: .trailing)
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 0,height: 40,alignment: .trailing)
                    
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 0,height: 40,alignment: .trailing)
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 0,height: 40,alignment: .trailing)
                    
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 0,height: 40,alignment: .trailing)
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 0,height: 40,alignment: .trailing)
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 0,height: 40,alignment: .trailing)
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 0,height: 40,alignment: .trailing)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                
            
            VStack {
                Circle().fill(Color.yellow)
                    .frame(width: 60,height: 40,alignment: .bottom)
                    .offset(y: bounce ? 0 : -100)
                    .rotationEffect(Angle(degrees: appear ? 50 : 0))
                    .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false))
                    .onAppear {
                        appear = true
                    }
                    .animation(
                        Animation.linear.repeatForever()
                    )
                Spacer()
            }
            ScrollView(.vertical){
                LazyHStack{
                    ScrollView(.horizontal){
                        LazyHStack{
                            ScrollView(.horizontal){
                                LazyHStack() {
                                    Circle()
                                        .frame(width: 60,height: 40,alignment: .center)
                                        .foregroundColor(.pink)
                                    
                                    Circle()
                                        .foregroundColor(.pink)
                                        .frame(width: 60,height: 40,alignment: .bottom)
                                    Circle()
                                        .foregroundColor(.pink)
                                        .frame(width: 60,height: 40,alignment: .bottom)
                                    Circle()
                                        .foregroundColor(.pink)
                                        .frame(width: 60,height: 40,alignment: .bottom)
                                    Circle()
                                        .foregroundColor(.pink)
                                        .frame(width: 60,height: 40,alignment: .bottom)
                                    Circle()
                                        .foregroundColor(.pink)
                                        .frame(width: 60,height: 40,alignment: .bottom)
                                }
                                }
                            }
                        }
                        
                    }
                }
            }
            VStack {
                HStack {
                    Spacer()
                    Image(playerCard)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                    Image(cpuCard)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                }
                .background(Color(.lightGray))
                Button(action: {
                    winnerName = "-- WINNER NAME --"
                    let playerRandom = Int.random(in: 1...14)
                    let cpuRandom = Int.random(in: 1...14)
                    
                    playerCard = "card" + String(playerRandom)
                    cpuCard = "card" + String(cpuRandom)
                    
                    
                    if playerRandom < cpuRandom {
                        playerScore += 1
                    }else if cpuRandom < playerRandom {
                        cpuScore += 1
                    }
                    
                }) {
                    VStack {
                        Text("PLAY".uppercased())
                            .foregroundColor(.white)
                            .font(.body)
                        Image("LOGO")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                        Spacer()
                        HStack{
                            VStack {
                                Spacer()
                                Text("Player")
                                Text(String(playerScore))
                                    .imageScale(.large)
                                    .fixedSize()
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                                    .font(.title)
                                Spacer()
                            }
                            VStack {
                                Spacer()
                                Text("CPU")
                                Text(String(cpuScore))
                                    .imageScale(.large)
                                    .fixedSize()
                                    .foregroundColor(.black)
                                    .font(.largeTitle)
                                Spacer()
                            }
                        }
                    }
                }
                Spacer()
                Button(action: {
                    if playerScore > cpuScore {
                        winnerName = "Player WON".uppercased()
                    } else if cpuScore > playerScore {
                        winnerName = "cpu WON".uppercased()
                    } else {
                        winnerName = "draw".uppercased()
                    }
                }) {
                    Text("stop game".uppercased())
                        .foregroundColor(.white)
                        .font(.title)
                }
                Spacer()
                Text(winnerName)
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
            
            Button(action: {}) {
                ZStack {
                    Button("ball"){
                        self.bounce.toggle()
                        
                    }
                    
                }
                
                
            }
           
            
        }
        .background(Color.purple)
        
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
