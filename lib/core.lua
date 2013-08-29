function class()
  local t = {}
  setmetatable(t, mt)
  return t
end

function new(class, ...)
  local self = {}
  setmetatable(self, {__index = class})
  self.super = class
  f.exe(class.init, self, ...)
  return self
end

local mt = {}
mt.__call = new