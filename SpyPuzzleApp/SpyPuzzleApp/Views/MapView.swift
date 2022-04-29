import SpyPuzzleGameState
import SwiftUI

struct MapView : View {
  let map: NodeMap
  
  var body: some View {
    Canvas { context, size in
      for (position,node) in map {
        for dir in Direction.allCases {
          if let edgeType = node.edges[dir] {
            let neighborPosition = position.offset(direction: dir)
            var path = Path()
            let aPos = asPt(point:position)
            let bPos = asPt(point:neighborPosition)
            path.move(to: aPos)
            path.addLine(to: bPos)
            context.stroke(path, with: GraphicsContext.Shading.color(.black))
            if edgeType != .open {
              func avg(_ a: CGFloat, _ b: CGFloat) -> CGFloat {
                (a + b) * 0.5
              }
              var doorContext = context
              doorContext.translateBy(x:avg(aPos.x, bPos.x),
                                      y: avg(aPos.y, bPos.y))
              doorContext.rotate(by:dir.rotation)
              let doorRect = CGRect(x:-2, y: -20, width: 4, height: 40)
              let door = Path(doorRect)
              doorContext.fill(door, with: GraphicsContext.Shading.color(edgeType.color))
            }
          }
        }
      }
    }
  }
}
