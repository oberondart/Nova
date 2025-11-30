-- Nova v0.0.2

var_name = nil
var_value = nil

local function out(input)
    if var_name == input then
        print(var_value)
    else
        print(input)
    end
end

local function let(name, value)
    var_name = name
    var_value = value
end

local function equal(name, value)
    return var_name == name and var_value == value
end

local function notequal(name, value)
    return var_name ~= name and var_value ~= value
end

local function loop(times, event)
    for i = 1, times do
        event()
    end
end
