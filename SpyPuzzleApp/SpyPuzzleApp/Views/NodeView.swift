import SpyPuzzleGameState
import SwiftUI

struct NodeView : View {
  let nodeType: NodeType

  var body: some View {
    switch nodeType {
    case .exit:
      word("exit")
    case .plain:
      plain
    case .rubble:
      word("rubble")
    case .statue:
      word("statue")
    case .subway:
      word("subway")
    case .target:
      word("target")
    case let .walkway(d):
      word("walkway \(d)")
    }
  }
    
  @ViewBuilder
  var plain: some View {
    ZStack {
      Circle()
        .fill(.white)
      Circle()
        .stroke(.black, lineWidth: 1)
    }
    .frame(width:8, height:8)
  }
  
  @ViewBuilder
  func word(_ word: String)-> some View {
    Text(word)
      .padding()
      .background(.white)
      .clipShape(RoundedRectangle(cornerRadius: 6))
      .overlay(RoundedRectangle(cornerRadius: 6)
        .stroke(.black))
  }
}
