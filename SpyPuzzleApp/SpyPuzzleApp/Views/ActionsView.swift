import SpyPuzzleGameState
import SwiftUI

struct ActionsView : View {
  let actions: [Action]
  var body: some View {
    Text("\(actions.description)")
  }
}
