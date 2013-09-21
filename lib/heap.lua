Heap = Class {}

function Heap:init()
	self.heap = {}
	self.nodes = {}
end

function Heap:push(k, v)
  assert(v ~= nil, 'cannot push nil')
  local t = self.nodes
  local h = self.heap
  local n = #h + 1 -- node position in heap array (leaf)
  local p = (n - n % 2) / 2 -- parent position in heap array
  h[n] = k -- insert at a leaf
  t[k] = v
  while n > 1 and t[h[p]] < v do -- climb heap?
    h[p], h[n] = h[n], h[p]
    n = p
    p = (n - n % 2) / 2
  end
end

function Heap:pop ()
  local t = self.nodes
  local h = self.heap
  local s = #h
  assert(s > 0, 'cannot pop from empty heap')
  local e = h[1] -- min (heap root)
  local r = t[e]
  local v = t[h[s]]
  h[1] = h[s] -- move leaf to root
  h[s] = nil -- remove leaf
  t[e] = nil
  s = s - 1
  local n = 1 -- node position in heap array
  local p = 2 * n -- left sibling position
  if s > p and t[h[p]] < t[h[p + 1]] then
    p = 2 * n + 1 -- right sibling position
  end
  while s >= p and t[h[p]] > v do -- descend heap?
    h[p], h[n] = h[n], h[p]
    n = p
    p = 2 * n
    if s > p and t[h[p]] < t[h[p + 1]] then
      p = 2 * n + 1
    end
  end
  return e, r
end

function Heap:isempty() return self.heap[1] == nil end