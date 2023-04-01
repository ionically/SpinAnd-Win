import SwiftUI
enum BallDirection {
    case right
    case down
    case left
    case up
}

var Y : CGFloat = 0.0
var X : CGFloat = 0.0
var direction: BallDirection = .right
var ballBorderStartHeight: CGFloat = 0
var ballBorderStartWidth: CGFloat = 0
var ballBorderEndHeight: CGFloat = UIScreen.main.bounds.height/2
var ballBorderEndWidth: CGFloat = UIScreen.main.bounds.width
var widthEnds: CGFloat = UIScreen.main.bounds.width
var heightEnds: CGFloat = UIScreen.main.bounds.height/2
var interval = 0.01
var greenBall = Text("🎾")

func updateXYValues() {
    if direction == .right {
        Y = Y+1
        X = X+1
        if X >= (widthEnds-10) {
            print("moved down")
            direction = .down
            return
        }
    } else if direction == .down {
        Y = Y+1
        X = X-1
        if Y >= (heightEnds-10) {
            print("moved left")
            direction = .left
            return
        }
    } else if direction == .left {
        Y = Y-1
        X = X-1
        if X <= -10 {
            print("moved up")
            direction = .up
            return
        }
    } else if direction == .up {
        Y = Y-1
        X = X+1
        if Y <= -10 {
            direction = .right
            print("moved right")
            return
        }
    }
    print("X \(X) Y \(Y)")
}
