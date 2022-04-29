import SpyPuzzleGameState
import SwiftUI

fileprivate let compassRose: [Direction] = [.west, .north, .south, .east]

struct MoveView : View {
  @ObservedObject var model: Model

  var body: some View {
    HStack {
      ForEach(possibleActions, id:\.self) {action in
        Button(action.description) {
          model.performAction(action: action)
        }
      }
      Spacer(minLength: 80)
      Button("Undo") {
        withAnimation {
          model.undo()
        }
      }
        .disabled(!model.canUndo())
      Button("Redo") {
        withAnimation {
          model.redo()
        }
      }
        .disabled(!model.canRedo())
      Button("Reset") {
        withAnimation {
          model.reset()
        }
      }
    }
  }
  
  private var possibleActions : [Action] {
    func displayOrder(lhs: Action, rhs: Action) -> Bool {
      switch (lhs, rhs) {
      case let (.fire(a),.fire(b)):
        return gridOrder(lhs: a, rhs: b)
      case (.fire,.toss), (.fire,.subway), (.fire,.move):
        return true
      case (.toss, .fire), (.subway, .fire), (.move,.fire):
        return false
      case let (.toss(a), .toss(b)):
        return compassRose.firstIndex(of: a)! < compassRose.firstIndex(of: b)!
      case (.toss,.subway), (.toss,.move):
        return true
      case (.subway,.toss), (.move,.toss):
        return false
      case let (.subway(a),.subway(b)):
        return a < b
      case (.subway,.move):
        return true
      case (.move,.subway):
        return false
      case let (.move(a),.move(b)):
        return compassRose.firstIndex(of: a)! < compassRose.firstIndex(of: b)!
      }
    }
    return actions(state:model.state).sorted(by: displayOrder)
  }

}
