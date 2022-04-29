import SpyPuzzleGameState
import SwiftUI

struct NodesView : View {
  let map: NodeMap
  
  var body: some View {
    ForEach(nodes, id:\.0) { (position, node) in
      let gp = asPt(point: position)
      NodeView(nodeType: node.type).position(gp)
    }
  }
  
  private var nodes: [(Point, Node)] {
    var nodes = [(Point, Node)]()
    for (position, node) in map {
      nodes.append((position, node))
    }
    return nodes
  }
}
