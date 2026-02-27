-- VARIABLES
local number = 5

local string = 'hello world'
local single = 'also works'
local crazy = [[ This
is a multi line and literal ]]

local truth, lies = true, false
local nothing = nil

-- FUNCTIONS
local function hello(name) print('Hello!', name) end

local greet = function(name)
  -- .. ist string conactenation
  print('Greetings, ' .. name .. '!')
end

string.upper 'hello'

local higher_order = function(value)
  return function(another) return value + another end
end

local add_one = higher_order(1)
print('add_one(2) -> ', add_one(2))

-- TABLES
-- as a list
local list = {
  'first',
  2,
  false,
  function() print 'Fourth!' end,
}
print('Yup, 1-indexed:', list[1])
print('Fouth is 4...:', list[4]())

-- as a map / dict
local t = {
  literal_key = 'a string',
  ['an expression'] = 'also works',
  [function() end] = true,
}

print('literal_key	: ', t.literal_key)
print('an expression	: ', t['an expression'])
print('function() end	: ', t[function() end])

-- CONTROL FLOW
-- for do
local favorite_accounts = { 'teej_dv', 'ThePrimeagen', 'terminaldotshop' }
for index = 1, #favorite_accounts do
  print(index, favorite_accounts[index])
end

for index, value in ipairs(favorite_accounts) do
  print(index, value)
end

local reading_scores = { teej_dv = 10, ThePrimeagen = 'N/A' }
for index = 1, #reading_scores do -- not doing anything as #-length-operator = 0, => table = map not array
  print(reading_scores[index])
end

local reading_scores = { teej_dv = 9.5, ThePrimeagen = 'N/A' }
for key, value in pairs(reading_scores) do
  print(key, value)
end

-- if t hen
local function action(loves_coffee)
  if loves_coffee then
    print "Check out `ssh terminal.shop` - it's cool!"
  else
    print "Check out `ssh terminal.shop` - it's still cool!"
  end
end

-- "falsey": nil, false
action() -- same as nil
action(false)

-- Everythin else is "truthy"
action(true)
action(0)
action {}

-- -- MODULES
-- -- foo.lua
-- local M = {}
-- M.cool_function = function () end
-- return M

-- bar.lua
local foo = require 'foo'
foo.cool_function()

local returns_four_values = function() return 1, 2, 3, 4 end

local first, second, last = returns_four_values()
print('first:	', first)
print('second:	', second)
print('last:	', last)
-- the `4` is discarded

local variable_arguemts = function(...)
  local arguments = { ... }
  for i, v in ipairs { ... } do
    print(i, v)
  end
  return unpack(arguments)
end

print '====================='
print('1:', variable_arguemts('hello', 'world', '!'))
print '====================='
print('2:', variable_arguemts('hello', 'world', '!'), '<lost>')

local single_string = function(s) return s .. ' - WOW!' end

-- function calling shorthand (no parenthesis)
local y = single_string 'hi'
print(y)

-- table Shorthand
local setup = function(opts)
  if opts.default == nil then opts.default = 17 end
  print(opts.default, opts.other)
end

setup { default = 12, other = false }
setup { other = true }

-- ':' is just syntactical sugar for '.' and self
local MyTable = {}

function MyTable.something(self, ...) end
function MyTable:something(...) end

-- METATABLES
-- metamethod `__add`
local vector_mt = {}
vector_mt.__add = function(left, right)
  return setmetatable({
    left[1] + right[1],
    left[2] + right[2],
    left[3] + right[3],
  }, vector_mt)
end

local v1 = setmetatable({ 3, 1, 5 }, vector_mt)
local v2 = setmetatable({ -3, 2, 2 }, vector_mt)
local v3 = v1 + v2
print(v3[1], v3[2], v3[3])
print(v3 + v3)

-- metamethod `__index`
local fib_mt = {
  __index = function(self, key)
    if key < 2 then return 1 end
    -- Update the table, to save the intermediate resutls
    self[key] = self[key - 2] + self[key - 1]
    -- Return the results
    return self[key]
  end,
}

local fib = setmetatable({}, fib_mt)

print(fib[5])
print(fib[50])
