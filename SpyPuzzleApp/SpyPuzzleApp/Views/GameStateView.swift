import SpyPuzzleGameState
import SwiftUI

struct GameStateView : View {
  let state: GameState
  
  var body: some View {
    let size = size(map:state.map)
    let sizePt = asPt(x:CGFloat(size.x) + 0.5,
                      y:CGFloat(size.y) + 0.5)
    ZStack {
      MapView(map:state.map)
      NodesView(map:state.map)
      PiecesView(state:state)
    }
    .frame(width:sizePt.x, height: sizePt.y)
  }
  
}
