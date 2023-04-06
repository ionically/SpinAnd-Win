import SwiftUI
import Combine

struct PingPongGameOLD: View {
    @State private var ballPosition = CGPoint(x: 50, y: 50)
    @State private var ballDirection = CGSize(width: 1, height: 1)
    @State private var linePosition = CGPoint(x: 150, y: 0)
    @State private var scorePosition = CGPoint(x: 150, y: 0)
    @State private var gameOver = false
    @State private var showExplosion = false
    @State private var restartButtonVisible = false
    @State var score = 0;
    @State var timer: Publishers.Autoconnect<Timer.TimerPublisher> = Timer.publish(every: 1/60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack(spacing: 15) {
            Circle()
                .fill(Color.red)
                .frame(width: 25, height: 25)
            Circle()
                .fill(Color.red)
                .frame(width: 25, height: 25)
            Circle()
                .fill(Color.red)
                .frame(width: 25, height: 25)
            Circle()
                .fill(Color.red)
                .frame(width: 25, height: 25)
            Circle()
                .fill(Color.yellow)
                .frame(width: 25, height: 25)
            Circle()
                .fill(Color.red)
                .frame(width: 25, height: 25)
            Circle()
                .fill(Color.red)
                .frame(width: 25, height: 25)
            Circle()
                .fill(Color.red)
                .frame(width: 25, height: 25)
            Circle()
                .fill(Color.red)
                .frame(width: 25, height: 25)
        }
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .fill(Color.yellow)
                    .frame(width: 30, height: 30)
                    .position(ballPosition)
                    .opacity(gameOver ? 0 : 1)

//                Line()
//                    .position(linePosition)

                MovingCircles()
                    .position(linePosition)
                
                if gameOver {
                    if showExplosion {
                        ExplosionView()
                            .frame(width: 200, height: 200)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    restartButtonVisible = true
                                }
                            }
                    } else {
                        Text("You lost")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
                if restartButtonVisible {
                    VStack {
                        ScoreView(playerScore: $score)
                            
                        Button("Restart") {
                            
                            ballPosition = CGPoint(x: 50, y: 50)
                            ballDirection = CGSize(width: 1, height: 1)
                            linePosition = CGPoint(x: 150, y: geometry.size.height - 30) // Reset the line position
                            gameOver = false
                            showExplosion = false
                            restartButtonVisible = false
                            let newTimer = Timer.publish(every: 1/60, on: .main, in: .common).autoconnect()
                            self.timer = newTimer
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .frame(width: 150, height: 50)
                    } .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    
                }
            }
            .onAppear {
                linePosition.y = geometry.size.height - 40
                scorePosition.y = geometry.size.height
                let newTimer = Timer.publish(every: 1/60, on: .main, in: .common).autoconnect()
                self.timer = newTimer
            }
            .onReceive(timer) { _ in
                guard !gameOver else { return }

                ballPosition.x += ballDirection.width * 5
                ballPosition.y += ballDirection.height * 5
                
                if ballPosition.x <= 25 || ballPosition.x >= geometry.size.width - 25 {
                    ballDirection.width *= -1
                }
                
                if ballPosition.y <= 25 {
                    ballDirection.height *= -1
                } else if ballPosition.y >= geometry.size.height - 25 - 4 {
                    let distance = abs(ballPosition.x - linePosition.x)
                    if distance <= 40 {
                        ballDirection.height *= -1
                        ballPosition.y = geometry.size.height - 25 - 4 - 25
                        // Ball has hit the line, so increment the score
                        score = score + 1
                    } else {
                        gameOver = true
                        showExplosion = true
                        timer.upstream.connect().cancel()
                    }
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let newX = value.location.x
                        linePosition.x = min(max(newX, 40), geometry.size.width - 40)
                    }
            )
            .ignoresSafeArea()
        }
    }
}

struct Line: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.blue)
            .frame(width: 80, height: 8)
    }
}

struct ScoreView: View {
    @Binding var playerScore: Int
    var body: some View {
        Text("You played like a champion 👌")
            .foregroundColor(.blue)
            .padding()
            .cornerRadius(10)
            .shadow(radius: 5)
            .frame(height: 50, alignment: .center)
        Text("Player Score \(playerScore)")
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(radius: 5)
            .frame(width: 150, height: 50, alignment: .center)
    }
}

struct MovingCircles: View {
    var body: some View {
        HStack(spacing: 15) {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 25, height: 25)
            Rectangle()
                .fill(Color.blue)
                .frame(width: 25, height: 25)
            Rectangle()
                .fill(Color.blue)
                .frame(width: 25, height: 25)
            Rectangle()
                .fill(Color.blue)
                .frame(width: 25, height: 25)
            Rectangle()
                .fill(Color.blue)
                .frame(width: 25, height: 25)
            Rectangle()
                .fill(Color.blue)
                .frame(width: 25, height: 25)
            Rectangle()
                .fill(Color.blue)
                .frame(width: 25, height: 25)
        }
    }
}


struct ExplosionView: View {
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 1
    
    let timer = Timer.publish(every: 1/60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.red.opacity(opacity))
                .scaleEffect(scale)
            
            Circle()
                .fill(Color.yellow.opacity(opacity))
                .scaleEffect(scale * 0.8)
            
            Circle()
                .fill(Color.white.opacity(opacity))
                .scaleEffect(scale * 0.6)
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                scale = 1.5
                opacity = 0
            }
        }
        .onReceive(timer) { _ in
            guard opacity > 0 else {
                timer.upstream.connect().cancel()
                return
            }
            opacity -= 0.03
            scale += 0.02
        }
    }
}
struct PingPongGameOLD_Previews: PreviewProvider {
    static var previews: some View {
        PingPongGameOLD()
    }
}
