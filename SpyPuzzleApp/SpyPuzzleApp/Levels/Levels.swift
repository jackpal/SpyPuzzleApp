public let levels: [String:String] = [
  "test-patrol": """
  1-1-1 A-+-X
  |   |
  1   1
  |   |
  1   1
  
  1: e(p,0,0,2,2)
  """,
  "test-goal-go-to-exit" : """
  A-X
  """,
  "test-goal-kill-your-mark" : """
  A-1
  
  1: e(m,e)
  """,
  "test-goal-kill-your-mark-2" : """
  A-G 1
  
  1: e(m,e);target()
  """,
  "test-goal-kill-your-mark-3" : """
  A-G 1
  |
  C
  
  1: e(m,e);target()
  """,
  "test-waitpoint": """
  A-W-X 1-+-+-+-+
  
  1: e(y,e)
  """,
  "test-high-alert": """
    +-+-+-1
    |     |
    +-+-+-+
    | | |
  X-A-+-+

  1: e(f,w)
  """,
  "test-return-to-patrol": """
  1-1
  | |
  1 1 +-R-A-X
  | | |   |
  1-1-+   +
  
  1:e(p,0,0,1,2)
  """,
  "test-level-keys": """
  A-rrb
      b
      X
  """
]
