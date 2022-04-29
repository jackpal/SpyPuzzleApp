import SpyPuzzleGameState
import SwiftUI

enum Piece : Identifiable {
  case hitman(h: Hitman)
  case enemy(e: Enemy)
  case item(i: Item)

  var id: Int {
    switch self {
    case let .hitman(h):
    return h.id
    case let .enemy(e):
      return e.id
    case let .item(i):
      return i.id
    }
  }
}

struct TriangleShape : Shape {
  func path(in rect: CGRect) -> Path {
      Path { path in
        path.move(to: CGPoint(x:rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
      }
  }
}

extension Direction {
  var rotation: Angle {
    switch self {
    case .north: return .degrees(-90)
    case .east: return .degrees(0)
    case .south: return .degrees(90)
    case .west: return .degrees(180)
    }
  }
}

/// A piece view that is not bound to a piece, all aspects
/// are set when constructing it.
struct PieceHelperView: View, Identifiable {
  let id: Int
  let label: String
  let ringColor: Color
  let facings: [Direction]
  let armored: Bool
  let badge: String?
  
  static let height: CGFloat = 40
  static let width: CGFloat = 40
  
  var body: some View {
    ZStack {
      if !facings.isEmpty {
        facingArrows
      }
      Circle()
        .fill(.white)
      Circle()
        .stroke(ringColor, lineWidth: 4)
      Text(label)
    }.frame(width:PieceHelperView.width,
            height:PieceHelperView.height)
    Text(badge ?? " ")
      .bold()
      .padding(2)
      .background(RoundedRectangle(cornerRadius: 4).fill(.white))
      .overlay(RoundedRectangle(cornerRadius: 4).stroke())
      .offset(x:PieceHelperView.width * 0.28,
              y:PieceHelperView.height * -0.42)
      .opacity(badge != nil ? 1.0 : 0.0)
    Text("🛡")
      .offset(x:PieceHelperView.width * -0.28,
              y:PieceHelperView.height * -0.42)
      .opacity(armored ? 1.0 : 0.0)
  }
  
  @ViewBuilder
  var facingArrows: some View {
    ForEach(Direction.allCases, id: \.self) { direction in
      TriangleShape()
        .size(width:18,height:18)
        .offset(x:38,y: 11.0)
        .rotation(direction.rotation)
        .opacity(facings.contains(direction) ? 1.0 : 0.0)
    }
  }
    
}

extension EnemyType {
  var ringColor : Color {
    switch self {
    case .blue:
      return .blue
    case .yellow:
      return .yellow
    case .green:
      return .green
    case .duo:
      return .gray
    case .dog:
      return .blue
    case .flashlight:
      return .blue
    case .patrol:
      return .green
    case .mark:
      return .red
    case .sniper:
      return .yellow
    }
  }
  
  var label : String {
    switch self {
    case .blue:
      return "Bl"
    case .yellow:
      return "Ye"
    case .green:
      return "Gr"
    case .duo:
      return "2"
    case .dog:
      return "Do"
    case .flashlight:
      return "Fl"
    case .patrol:
      return "Pa"
    case .mark:
      return "Ma"
    case .sniper:
      return "Sn"
    }
  }

}

extension ItemType {
  var ringColor : Color {
    switch self {
    case .briefcase:
      return .black
    case let .suit(e):
      return e.ringColor
    case .gun:
      return .black
    case let .key(k):
      return k.color
    case .pistols:
      return .black
    case .plant:
      return .green
    case .rock:
      return  .black
    case .waitPoint:
      return  .black
    }
  }
  
  var label : String {
    switch self {
    case .briefcase:
      return "Ca"
    case .suit:
      return "Su"
    case .gun:
      return "Gu"
    case .key:
      return "Ke"
    case .pistols:
      return "Pi"
    case .plant:
      return "Pl"
    case .rock:
      return "Ro"
    case .waitPoint:
      return "Wa"
    }
  }
}

extension Enemy {
  
  func piece(position: Point) -> some View {
    PieceHelperView(id: id,
                    label: type.label,
                    ringColor: type.ringColor,
                    facings: facings,
                    armored: armored,
                    badge: badge(position: position)
    )
  }
  
  var facings: [Direction] {
    var facings = [facing]
    if type == .duo {
      facings.append(facing.opposite)
    }
    return facings
  }
  
  func badge(position: Point) -> String? {
    if goal != nil {
      return "?"
    }
    switch type {
    case let .dog(chasing):
      if !chasing.isEmpty {
        return "!"
      }
    case let .patrol(route):
      if !route.contains(p: position) {
        return "R"
      }
    default:
      break
    }
    return nil
  }
}

extension Item {
  var piece: some View {
    PieceHelperView(id:id,
                    label:type.label,
                    ringColor:type.ringColor,
                    facings:[],
                    armored: false,
                    badge:nil
    )
  }

}


extension Hitman {
  var piece: some View {
    PieceHelperView(id:id,
                    label:"A",
                    ringColor:ringColor,
                    facings:[],
                    armored: false,
                    badge:nil
    )
  }
  
  var ringColor: Color {
    switch costume {
    case .normal:
      return .black
    case .trenchcoat:
      return .gray
    case let .suit(type):
      return type.ringColor
    }
  }

}

struct PieceView : View, Identifiable {
  let piece: Piece
  let gameGridPoint: Point
  let nodePieceIndex: Int
  let nodePieceCount: Int
  var id: Int {
    piece.id
  }

  var body: some View {
    switch piece {
    case let .hitman(h):
      h.piece
    case let .enemy(e):
      e.piece(position:gameGridPoint)
    case let .item(i):
      i.piece
    }
  }
  
}
