import Combine
import Foundation
import SpyPuzzleGameState

class Model : ObservableObject {
  typealias HistoryItem = (state: GameState, action: Action)
  private let initial : GameState
  @Published private(set) var state: GameState
  @Published private(set) var history: [HistoryItem]
  @Published private(set) var undone: [Action]

  init(initial: GameState) {
    self.initial = initial
    state = initial
    history = []
    undone = []
  }
  
  func reset() {
    state = initial
    history = []
    undone = []
  }
  
  func performAction(action: Action) {
    undone = []
    internalPerform(action:action)
  }
  
  private func internalPerform(action:Action) {
    history.append((state, action))
    perform(action: action, on: &state)
  }
  
  func canUndo() -> Bool {
    return !history.isEmpty
  }
  
  func undo() {
    if canUndo() {
      let last = history.removeLast()
      state = last.0
      undone.append(last.1)
    }
  }
  
  func canRedo() -> Bool {
    return !undone.isEmpty
  }
  
  func redo() {
    if canRedo() {
      let last = undone.removeLast()
      internalPerform(action: last)
    }
  }
  
}
