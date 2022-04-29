import SpyPuzzleGameState
import SwiftUI

func asPt(x: CGFloat, y: CGFloat) -> CGPoint {
  let cellX: CGFloat = 100
  let cellY: CGFloat = 100
  return CGPoint(x: cellX * (CGFloat(x) + 0.5), y: cellY * (CGFloat(y) + 0.5))
}

func asPt(x: Int, y: Int) -> CGPoint {
  asPt(x:CGFloat(x), y: CGFloat(y))
}


func asPt(point: Point) -> CGPoint {
  asPt(x: point.x, y: point.y)
}

extension EdgeType {
  var color: Color {
    switch self {
    case .open:
      return Color.black
    case .red:
      return Color.red
    case .green:
      return Color.green
    case .blue:
      return Color.blue
    case .yellow:
      return Color.yellow
    }
  }
}
