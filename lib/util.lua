-- Math
function math.lerp(x1, x2, z) return x1 + (x2 - x1) * z end
function math.anglerp(d1, d2, z) return d1 + (math.anglediff(d1, d2) * z) end
function math.distance(x1, y1, x2, y2) return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ .5 end
function math.direction(x1, y1, x2, y2) return -math.atan2(x2 - x1, y2 - y1) end
function math.inside(px, py, rx, ry, rw, rh) return px >= rx and px <= rx + rw and py >= ry and py <= ry + rh end
function math.lineDistance(px, py, x1, y1, x2, y2)
	local a, b, c = math.distance(px, py, x1, y1), math.distance(px, py, x2, y2), math.distance(x1, y1, x2, y2)
	if b^2 > a^2 + c^2 then
		return a
	elseif a^2 > b^2 +c^2 then
		return b
	else
		local s = (a + b + c) / 2
		return 2 / c * (s * (s - a) * (s - b) * (s - c))^0.5
	end
end
function math.anglediff(d1, d2) return math.rad((((math.deg(d2) - math.deg(d1) % 360) + 540) % 360) - 180) end
function math.hcora(cx, cy, cr, rx, ry, rw, rh) -- Hot circle on rectangle action.
	local hw, hh = rw / 2, rh / 2
	local cdx, cdy = math.abs(cx - (rx + hw)), math.abs(cy - (ry + hh))
	if cdx > hw + cr or cdy > hh + cr then return false end
	if cdx <= hw or cdy <= hh then return true end
	return (cdx - hw) ^ 2 + (cdy - hh) ^ 2 <= (cr ^ 2)
end
function math.hloca(x1, y1, x2, y2, cx, cy, cr) -- Hot line on circle action.
	local dx, dy = (x2 - x1), (y2 - y1)
	local a2 = math.abs(dx * (cy - y1) - dy * (cx - x1))
	local l = (dx * dx + dy * dy) ^ .5
	local h = a2 / l
	if not (h < cr) then return false end
	local t = (dx / l) * (cx - x1) + (dy / l) * (cy - y1)
	if t < 0 then return false end
	return l > t - ((cr ^ 2 - h ^ 2) ^ .5)
end
function math.hcoca(x1, y1, r1, x2, y2, r2) -- Hot circle on circle action.
	local dx, dy, r = x2 - x1, y2 - y1, r1 + r2
	return (dx * dx) + (dy * dy) < r * r
end
function math.hlola(x1, y1, x2, y2, x3, y3, x4, y4) -- Hot line on line action.
	local function s(x1, y1, x2, y2, x3, y3)
		return (y3 - y1) * (x2 - x1) > (y2 - y1) * (x3 - x1)
	end
	return s(x1, y1, x3, y3, x4, y4) ~= s(x2, y2, x3, y3, x4, y4) and s(x1, y1, x2, y2, x3, y3) ~= s(x1, y1, x2, y2, x4, y4)
end
function math.hlora(x1, y1, x2, y2, rx, ry, rw, rh) -- Hot line on rectangle action.
	return math.hlola(x1, y1, x2, y2, rx, ry, rx + rw, ry)
			or math.hlola(x1, y1, x2, y2, rx, ry, rx, ry + rh)
			or math.hlola(x1, y1, x2, y2, rx + rw, ry, rx + rw, ry + rh)
			or math.hlola(x1, y1, x2, y2, rx, ry + rh, rx + rw, ry + rh)
end

-- Table
function table.eq(t1, t2)
	if type(t1) ~= type(t2) then return false end
	if type(t1) ~= 'table' then return t1 == t2 end
	if #t1 ~= #t2 then return false end
	for k, _ in pairs(t1) do
		if not table.eq(t1[k], t2[k]) then return false end
	end
	return true
end

function table.copy(x)
	local t = type(x)
	if t ~= 'table' then return x end
	local y = {}
	for k, v in next, x, nil do if v ~= x then y[k] = table.copy(v) end end
	setmetatable(y, getmetatable(x))
	return y
end

function table.has(t, x, deep)
	if not t or not x then return end
	local f = deep and table.eq or rawequal
	for _, v in pairs(t) do if f(v, x) then return true end end
	return false
end

function table.only(t, ks)
	local res = {}
	for _, k in pairs(ks) do res[k] = t[k] end
	return res
end

function table.except(t, ks)
	local res = table.copy(t)
	for _, k in pairs(ks) do res[k] = nil end
	return res
end

function table.with(t, f)
	if not t then return end
	for k, v in pairs(t) do f(v, k) end
end

function table.iwith(t, f)
	if not t then return end
	for k, v in ipairs(t) do f(v, k) end
end

function table.map(t, f)
	if not t then return end
	local res = {}
	table.with(t, function(v, k) res[k] = f(v, k) end)
	return res
end

function table.filter(t, f)
	return table.map(t, function(v, k) return f(v, k) and v or nil end)
end

function table.clear(t, v)
	table.with(t, function(_, k) t[k] = v end)
end

function table.merge(t1, t2, shallow)
	t2 = t2 or {}
	for k, v in pairs(t1) do
		if not shallow and type(v) == 'table' then t2[k] = table.merge(t1[k], t2[k], shallow)
		else t2[k] = v end
	end
	return t2
end

function table.interpolate(t1, t2, z)
	local interp = table.copy(t1)
	for k, v in pairs(interp) do
		if t2[k] then
			if type(v) == 'table' then interp[k] = table.interpolate(t1[k], t2[k], z)
			elseif type(v) == 'number' then
				if k == 'angle' then interp[k] = math.anglerp(t1[k], t2[k], z)
				else interp[k] = math.lerp(t1[k], t2[k], z) end
			end
		end
	end
	return interp
end 

function table.deltas(t1, t2)
	if not t1 or not t2 then return t2 end
	return table.filter(t2, function(v, k) return v ~= t1[k] end)
end

function table.count(t)
	local ct = 0
	table.with(t, function() ct = ct + 1 end)
	return ct
end

function table.print(t, n)
	n = n or 0
	if t == nil then print('nil') end
	if type(t) ~= 'table' then io.write(tostring(t)) io.write('\n')
	else
		for k, v in pairs(t) do
			io.write(string.rep('\t', n))
			io.write(k)
			if type(v) == 'table' then io.write('\n')
			else io.write('\t') end
			table.print(v, n + 1)
		end
	end
end

function table.stringify(t, pretty, n)
	n = n or 0
	if t == nil then return t end
	local str = ''
	if type(t) == 'string' then 
		str = str .. '\'' .. t:gsub('\'', '\\\'') .. '\''
	elseif type(t) ~= 'table' then
		str = str .. t
	else
		local c = table.count(t)
		if c == 0 then
			str = str .. '{}'
		elseif c == 1 then
			for k, v in pairs(t) do str = str .. '{' .. k .. (pretty and ' = ' or '=') .. table.stringify(v, pretty, n + 1) .. '}' end
		else
			str = str .. '{' .. (pretty and '\n' or '')
			for k, v in pairs(t) do
				if pretty then str = str .. string.rep('  ', n + 1) end
				str = str .. k .. (pretty and ' = ' or '=') .. table.stringify(v, pretty, n + 1) .. ',' .. (pretty and '\n' or '')
				indent = true
			end
			str = str:sub(1, pretty and -3 or -2) .. (pretty and '\n' .. string.rep('  ', n) or '') .. '}'
		end
	end

	return str
end

-- Functions
f = {}
f.empty = function() end
f.id = function(x) return x end
f.exe = function(x, ...) if x then x(...) end end
f.ego = function(f) return function(x, ...) x[f](x, ...) end end
f.egoexe = function(fn) return function(x, ...) f.exe(x[fn], x, ...) end end

function io.load(dir)
	for _, file in ipairs(love.filesystem.enumerate(dir)) do
		if file:match('\.lua') then require(dir .. '/' .. file:gsub('\.lua', '')) end
	end
	
	for _, file in ipairs(love.filesystem.enumerate(dir)) do
		if love.filesystem.isDirectory(dir .. '/' .. file) then io.load(dir .. '/' .. file) end
	end
end