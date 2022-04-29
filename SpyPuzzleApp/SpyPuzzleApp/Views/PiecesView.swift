import SpyPuzzleGameState
import SwiftUI

struct PiecesView : View {
  let state: GameState

  var body: some View {
    ForEach(pieces) { pieceView in
      pieceView
        .position(self.position(pieceView:pieceView))
    }
  }
  
  func position(pieceView:PieceView) -> CGPoint {
    let gp = asPt(point: pieceView.gameGridPoint)
    let offsetX: CGFloat = 30 * (CGFloat(pieceView.nodePieceIndex) -
    CGFloat(pieceView.nodePieceCount-1) * 0.5)
    return CGPoint(x: gp.x + offsetX, y: gp.y)
  }
  
  var pieces: [PieceView] {
    var pieceViews = [PieceView]()
    for (position, node) in state.map {
      let nodePieces = pieces(position: position, node:node)
      for (i, piece) in nodePieces.enumerated() {
        pieceViews.append(
          PieceView(
            piece: piece,
            gameGridPoint:position,
            nodePieceIndex: i,
            nodePieceCount: nodePieces.count
            )
        )
      }
    }
    return pieceViews
  }
  
  func pieces(position: Point, node: Node) -> [Piece] {
    var result = [Piece]()
    if position == state.hitman.position {
      result.append(.hitman(h: state.hitman))
    }
    if let item = node.item {
      result.append(.item(i: item))
    }
    for enemy in node.enemies {
      result.append(.enemy(e: enemy))
    }
    return result
  }
}
