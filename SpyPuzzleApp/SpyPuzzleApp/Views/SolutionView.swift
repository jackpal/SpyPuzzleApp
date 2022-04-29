import SpyPuzzleGameState
import SpyPuzzleSolver
import SwiftUI

struct SolutionView : View {
  @ObservedObject var model: Model
  @State var solution: [Action]?
  var body: some View {
    Text(solutionMessage)
    AsyncButton(action: {
      let exitObjective : Objective = hasExit(map: model.state.map) ? .levelComplete : .killYourMark
      solution = await solve(exitObjective: exitObjective, statusObjectives: [])
    }, label: {
      Text("Solve")
    })
    Button("Step") {
      if let first = solution?.first {
        solution!.removeFirst()
        withAnimation {
          model.performAction(action: first)
        }
      }
    }.disabled(solution?.isEmpty ?? true)
  }
  
  var solutionMessage: String {
    guard let solution = solution else {
      return ""
    }
    let message = solution.map { $0.description }.joined(separator: ", ")
    if message.isEmpty {
      return ""
    } else {
      return message
    }

  }
  
  nonisolated func solve(exitObjective:Objective, statusObjectives:[Objective]) async -> [Action]? {
    return try! await SpyPuzzleSolver.solve(state:model.state, exitObjective: exitObjective, statusObjectives:statusObjectives )
  }
}
