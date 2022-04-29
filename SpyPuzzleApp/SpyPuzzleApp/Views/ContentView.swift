import SpyPuzzleGameState
import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      LevelsView()
        .navigationTitle(Text("Levels"))
        .navigationBarTitleDisplayMode(.inline)
    }.padding()
  }
}

struct LevelsView: View {
  var body: some View {
    List(levels.keys.sorted(), id: \.self) { level in
      NavigationLink(destination:LevelView()
        .environmentObject(Model(initial: try! parse(level:levels[level]!)))
        .navigationTitle(Text(level))
        .navigationBarTitleDisplayMode(.inline)
      ){
        Text(level)
      }
    }
  }
}

struct LevelView : View {
  @EnvironmentObject private var model: Model
  var body: some View {
    VStack {
      SolutionView(model:model)
      ScrollView([.horizontal,.vertical]) {
        GameStateView(state: model.state)
      }
      ActionsView(actions: model.history.map(\.action))
      MoveView(model:model)
    }
  }
}
