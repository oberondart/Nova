#!/usr/bin/env lua
-- Nova Scripting Language Interpreter
-- Version 1.0.2 - New Syntax
-- 100% Lua Implementation

local NovaInterpreter = {}
NovaInterpreter.__index = NovaInterpreter

function NovaInterpreter:new()
    local instance = {
        varstorage = {},
        arraystorage = {},
        funcstorage = {}
    }
    setmetatable(instance, NovaInterpreter)
    return instance
end

function NovaInterpreter:let(name, value)
    self.varstorage[name] = value
end

function NovaInterpreter:out(name)
    if type(name) == "string" and self.varstorage[name] ~= nil then
        print(self.varstorage[name])
        return
    end
    if self.arraystorage[name] then
        print(self:table_to_string(self.arraystorage[name]))
        return
    end
    print(name)
end

function NovaInterpreter:input(name)
    local value = io.read("*line")
    self.varstorage[name] = value
end

function NovaInterpreter:equal(name, value)
    return self.varstorage[name] == value
end

function NovaInterpreter:notequal(name, value)
    return self.varstorage[name] ~= value
end

function NovaInterpreter:greater(name, name2)
    local a = self.varstorage[name]
    local b = self.varstorage[name2]
    if a > b then 
        self:out(a .. " is greater than " .. b) 
    else 
        self:out(b .. " is greater than " .. a) 
    end
end

function NovaInterpreter:less(name, name2)
    local a = self.varstorage[name]
    local b = self.varstorage[name2]
    if a < b then 
        self:out(a .. " is less than " .. b) 
    else 
        self:out(b .. " is less than " .. a) 
    end
end

function NovaInterpreter:greateroreqt(name, name2)
    local a = self.varstorage[name]
    local b = self.varstorage[name2]
    if a >= b then 
        self:out(a) 
    else 
        self:out(b) 
    end
end

function NovaInterpreter:lessoreqt(name, name2)
    local a = self.varstorage[name]
    local b = self.varstorage[name2]
    if a <= b then 
        self:out(a) 
    else 
        self:out(b) 
    end
end

function NovaInterpreter:loop(times, event)
    for i = 1, times do
        event()
    end
end

function NovaInterpreter:while_loop(times, event)
    local counter = 0
    while counter < times do
        event()
        counter = counter + 1
    end
end

function NovaInterpreter:func(name, fn)
    self.funcstorage[name] = fn
end

function NovaInterpreter:call(name, ...)
    if self.funcstorage[name] then
        return self.funcstorage[name](...)
    else
        self:out("error: invalid function: " .. name .. ".")
    end
end

function NovaInterpreter:ifdo(name, value, then_fn, else_fn)
    if self.varstorage[name] == value then
        then_fn()
    elseif else_fn then
        else_fn()
    end
end

function NovaInterpreter:and_op(a, b)
    return a and b
end

function NovaInterpreter:or_op(a, b)
    return a or b
end

function NovaInterpreter:not_op(a)
    return not a
end

function NovaInterpreter:runfile(filename)
    if not filename:match("%.nova$") then
        filename = filename .. ".nova"
    end
    local file = io.open(filename, "r")
    if not file then
        self:out("error: file " .. filename .. " not found")
        return
    end
    local code = file:read("*all")
    file:close()
    self:execute(code)
end

function NovaInterpreter:bool(name)
    local value = self.varstorage[name]
    if value == true then
        self:out("true")
    else
        self:out("false")
    end
end

function NovaInterpreter:array(name, arr)
    self.arraystorage[name] = arr
end

function NovaInterpreter:table_to_string(t)
    local items = {}
    for i, v in ipairs(t) do
        items[#items+1] = tostring(v)
    end
    return "[" .. table.concat(items, ", ") .. "]"
end

function NovaInterpreter:cut(name, index)
    local a = self.arraystorage[name]
    if a then
        table.remove(a, index)
    end
end

function NovaInterpreter:insert(name, pos, value)
    local a = self.arraystorage[name]
    if a then
        table.insert(a, pos, value)
    end
end

function NovaInterpreter:sort(name)
    local a = self.arraystorage[name]
    if a then
        table.sort(a)
    else
        self:out("error: array " .. name .. " doesn't exist")
    end
end

function NovaInterpreter:add(x, y)
    x = self.varstorage[x] or x
    y = self.varstorage[y] or y
    return x + y
end

function NovaInterpreter:sub(x, y)
    x = self.varstorage[x] or x
    y = self.varstorage[y] or y
    return x - y
end

function NovaInterpreter:mul(x, y)
    x = self.varstorage[x] or x
    y = self.varstorage[y] or y
    return x * y
end

function NovaInterpreter:div(x, y)
    x = self.varstorage[x] or x
    y = self.varstorage[y] or y
    if y == 0 then
        print("error: division by zero")
        return nil
    end
    return x / y
end

function NovaInterpreter:len(inputstring)
    inputstring = self.varstorage[inputstring] or inputstring
    if type(inputstring) ~= "string" then
        print("error: len() expects type string")
        return nil
    end
    return string.len(inputstring)
end

function NovaInterpreter:reverse(inputstring)
    inputstring = self.varstorage[inputstring] or inputstring
    if type(inputstring) ~= "string" then
        print("error: reverse() expects type string")
        return nil
    end
    return string.reverse(inputstring)
end

function NovaInterpreter:upper(inputstring)
    inputstring = self.varstorage[inputstring] or inputstring
    if type(inputstring) ~= "string" then
        print("error: upper() expects type string")
        return nil
    end
    return string.upper(inputstring)
end

function NovaInterpreter:lower(inputstring)
    inputstring = self.varstorage[inputstring] or inputstring
    if type(inputstring) ~= "string" then
        print("error: lower() expects type string")
        return nil
    end
    return string.lower(inputstring)
end

-- Helper function to trim whitespace
local function trim(s)
    return s:match("^%s*(.-)%s*$")
end

-- Helper function to split string
local function split(str, delimiter)
    local result = {}
    local pattern = string.format("([^%s]+)", delimiter)
    for match in str:gmatch(pattern) do
        table.insert(result, match)
    end
    return result
end

-- Helper function to find matching closing brace
local function find_matching_brace(lines, start_index)
    local depth = 0
    local in_block = false
    
    for i = start_index, #lines do
        local line = lines[i]
        
        -- Count braces in the line
        for j = 1, #line do
            local char = line:sub(j, j)
            if char == "{" then
                depth = depth + 1
                in_block = true
            elseif char == "}" then
                depth = depth - 1
                if depth == 0 and in_block then
                    return i
                end
            end
        end
    end
    
    return nil
end

function NovaInterpreter:parse_value(value_str)
    value_str = trim(value_str)
    
    -- Check for string literals
    if (value_str:match('^".*"$') or value_str:match("^'.*'$")) then
        return value_str:sub(2, -2)
    end
    
    -- Check for boolean
    if value_str:lower() == 'true' then
        return true
    end
    if value_str:lower() == 'false' then
        return false
    end
    
    -- Check for null/nil
    if value_str:lower() == 'nil' or value_str:lower() == 'null' then
        return nil
    end
    
    -- Check for function calls (e.g., add x y or add(x, y))
    -- New syntax: add x y
    local func_name = value_str:match("^(%w+)%s+")
    if func_name and not value_str:match("%(") then
        -- New syntax style: "add x y"
        local rest = value_str:sub(#func_name + 2)
        local args = {}
        for arg in rest:gmatch("%S+") do
            table.insert(args, self:parse_value(arg))
        end
        
        if self[func_name] and type(self[func_name]) == "function" then
            local success, result = pcall(function()
                return self[func_name](self, table.unpack(args))
            end)
            if success then
                return result
            end
        end
    end
    
    -- Old syntax with parentheses: add(x, y)
    local func_name_paren, args_str = value_str:match("^(%w+)%s*%((.*)%)$")
    if func_name_paren then
        local args = self:parse_arguments(args_str)
        if self[func_name_paren] and type(self[func_name_paren]) == "function" then
            local success, result = pcall(function()
                return self[func_name_paren](self, table.unpack(args))
            end)
            if success then
                return result
            end
        elseif self.funcstorage[func_name_paren] then
            return self:call(func_name_paren, table.unpack(args))
        end
    end
    
    -- Check for array
    if value_str:match('^%[.*%]$') then
        local items_str = value_str:sub(2, -2)
        items_str = trim(items_str)
        if items_str == "" then
            return {}
        end
        
        -- Simple comma split
        local items = {}
        local depth = 0
        local current = ""
        
        for i = 1, #items_str do
            local char = items_str:sub(i, i)
            if char == '[' then
                depth = depth + 1
                current = current .. char
            elseif char == ']' then
                depth = depth - 1
                current = current .. char
            elseif char == ',' and depth == 0 then
                table.insert(items, self:parse_value(current))
                current = ""
            else
                current = current .. char
            end
        end
        
        if current ~= "" then
            table.insert(items, self:parse_value(current))
        end
        
        return items
    end
    
    -- Check for number
    local num = tonumber(value_str)
    if num then
        return num
    end
    
    -- Check if it's a variable reference
    if self.varstorage[value_str] ~= nil then
        return self.varstorage[value_str]
    end
    
    -- Return as string
    return value_str
end

function NovaInterpreter:parse_arguments(args_str)
    args_str = trim(args_str)
    if args_str == "" then
        return {}
    end
    
    local args = {}
    local depth = 0
    local in_string = false
    local string_char = nil
    local current = ""
    
    for i = 1, #args_str do
        local char = args_str:sub(i, i)
        
        -- Handle string delimiters
        if (char == '"' or char == "'") and not in_string then
            in_string = true
            string_char = char
            current = current .. char
        elseif char == string_char and in_string then
            in_string = false
            string_char = nil
            current = current .. char
        elseif char == '(' or char == '[' then
            depth = depth + 1
            current = current .. char
        elseif char == ')' or char == ']' then
            depth = depth - 1
            current = current .. char
        elseif char == ',' and depth == 0 and not in_string then
            table.insert(args, self:parse_value(current))
            current = ""
        else
            current = current .. char
        end
    end
    
    if current ~= "" then
        table.insert(args, self:parse_value(current))
    end
    
    return args
end

function NovaInterpreter:evaluate_condition(condition_str)
    condition_str = trim(condition_str)
    
    -- Try == (equality)
    local var, val = condition_str:match("^(%w+)%s*==%s*(.+)$")
    if var then
        local var_value = self.varstorage[var]
        local compare_value = self:parse_value(val)
        return var_value == compare_value
    end
    
    -- Try != (not equal)
    var, val = condition_str:match("^(%w+)%s*!=%s*(.+)$")
    if var then
        local var_value = self.varstorage[var]
        local compare_value = self:parse_value(val)
        return var_value ~= compare_value
    end
    
    -- Try >= (greater or equal) - must come before >
    var, val = condition_str:match("^(%w+)%s*>=%s*(.+)$")
    if var then
        local var_value = self.varstorage[var]
        local compare_value = self:parse_value(val)
        return var_value >= compare_value
    end
    
    -- Try <= (less or equal) - must come before <
    var, val = condition_str:match("^(%w+)%s*<=%s*(.+)$")
    if var then
        local var_value = self.varstorage[var]
        local compare_value = self:parse_value(val)
        return var_value <= compare_value
    end
    
    -- Try > (greater than)
    var, val = condition_str:match("^(%w+)%s*>%s*(.+)$")
    if var then
        local var_value = self.varstorage[var]
        local compare_value = self:parse_value(val)
        return var_value > compare_value
    end
    
    -- Try < (less than)
    var, val = condition_str:match("^(%w+)%s*<%s*(.+)$")
    if var then
        local var_value = self.varstorage[var]
        local compare_value = self:parse_value(val)
        return var_value < compare_value
    end
    
    -- Try logical AND
    local left, right = condition_str:match("^(.+)%s+and%s+(.+)$")
    if left and right then
        return self:evaluate_condition(left) and self:evaluate_condition(right)
    end
    
    -- Try logical OR
    left, right = condition_str:match("^(.+)%s+or%s+(.+)$")
    if left and right then
        return self:evaluate_condition(left) or self:evaluate_condition(right)
    end
    
    return false
end

function NovaInterpreter:execute_if_block(lines, start_index)
    local if_line = trim(lines[start_index])
    local condition = if_line:match("^if%s+(.+)%s*{%s*$")
    
    if not condition then
        print("error: invalid if syntax on line " .. start_index)
        return start_index
    end
    
    -- Find the closing brace for the if block
    local if_end = find_matching_brace(lines, start_index)
    if not if_end then
        print("error: no matching } for if statement")
        return start_index
    end
    
    -- Check for else or else if
    local else_start = nil
    local else_end = nil
    local skip_to = if_end
    
    if if_end + 1 <= #lines then
        local next_line = trim(lines[if_end + 1])
        
        if next_line:match("^}%s*else%s+if%s+") or (if_end + 2 <= #lines and trim(lines[if_end + 2]):match("^else%s+if%s+")) then
            -- else if - will be handled recursively
            -- For now, treat as else block
            if next_line:match("^}%s*else%s*{") then
                else_start = if_end + 1
                -- Find where else starts (skip the } from if)
                local else_line = next_line:gsub("^}%s*", "")
                if else_line:match("^else%s*{") then
                    else_end = find_matching_brace(lines, else_start)
                    skip_to = else_end
                end
            end
        elseif next_line:match("^}%s*else%s*{") then
            -- } else { on same line as closing if
            else_start = if_end + 1
            -- Need to find the else block which starts after }
            -- Count braces differently
            local depth = 0
            local found_else_open = false
            for i = if_end + 1, #lines do
                local line = lines[i]
                for j = 1, #line do
                    local char = line:sub(j, j)
                    if char == "{" then
                        depth = depth + 1
                        found_else_open = true
                    elseif char == "}" then
                        depth = depth - 1
                        if depth == 0 and found_else_open then
                            else_end = i
                            break
                        end
                    end
                end
                if else_end then break end
            end
            skip_to = else_end or if_end
        elseif next_line:match("^else%s*{") then
            -- else { on next line
            else_start = if_end + 1
            else_end = find_matching_brace(lines, else_start)
            skip_to = else_end or if_end
        end
    end
    
    -- Evaluate the condition
    local condition_result = self:evaluate_condition(condition)
    
    if condition_result then
        -- Execute the if block
        for i = start_index + 1, if_end - 1 do
            local line = trim(lines[i])
            if line ~= "" then
                self:execute_line(line)
            end
        end
    elseif else_start and else_end then
        -- Execute the else block
        -- Find where the actual else code starts
        local else_code_start = else_start
        local first_line = trim(lines[else_start])
        
        -- Skip the } else { line
        if first_line:match("^}%s*else%s*{") or first_line:match("^else%s*{") then
            else_code_start = else_start + 1
        end
        
        for i = else_code_start, else_end - 1 do
            local line = trim(lines[i])
            if line ~= "" and line ~= "}" then
                self:execute_line(line)
            end
        end
    end
    
    return skip_to
end

function NovaInterpreter:execute_line(line)
    line = trim(line)
    
    -- Skip empty lines and comments
    if line == "" or line:match("^%-%-") or line:match("^//") or line:match("^#") then
        return
    end
    
    -- NEW SYNTAX PATTERNS
    
    -- Pattern: let x: value
    local var_name, value_str = line:match("^let%s+([%w_]+)%s*:%s*(.+)$")
    if var_name then
        local value = self:parse_value(value_str)
        self:let(var_name, value)
        return
    end
    
    -- Pattern: out x  (simple output without colon)
    local out_var = line:match("^out%s+([%w_]+)$")
    if out_var then
        self:out(out_var)
        return
    end
    
    -- Pattern: out "text" or out: text
    local out_text = line:match("^out%s*:%s*(.+)$")
    if out_text then
        local value = self:parse_value(out_text)
        self:out(value)
        return
    end
    
    -- Pattern: out text (literal string without quotes)
    if line:match("^out%s+") and not line:match(":") then
        local text = line:sub(5)
        text = trim(text)
        -- Check if it's a variable or literal
        if self.varstorage[text] or self.arraystorage[text] then
            self:out(text)
        else
            -- Treat as literal string
            print(text)
        end
        return
    end
    
    -- Pattern: array name: [items]
    local arr_name, arr_values = line:match("^array%s+([%w_]+)%s*:%s*(.+)$")
    if arr_name then
        local arr = self:parse_value(arr_values)
        self:array(arr_name, arr)
        return
    end
    
    -- Pattern: sort x
    local sort_arr = line:match("^sort%s+([%w_]+)$")
    if sort_arr then
        self:sort(sort_arr)
        return
    end
    
    -- Pattern: input x
    local input_var = line:match("^input%s+([%w_]+)$")
    if input_var then
        self:input(input_var)
        return
    end
    
    -- Pattern: insert array_name index value
    local ins_arr, ins_pos, ins_val = line:match("^insert%s+([%w_]+)%s+(%S+)%s+(.+)$")
    if ins_arr then
        local pos = self:parse_value(ins_pos)
        local val = self:parse_value(ins_val)
        self:insert(ins_arr, pos, val)
        return
    end
    
    -- Pattern: cut array_name index
    local cut_arr, cut_idx = line:match("^cut%s+([%w_]+)%s+(%S+)$")
    if cut_arr then
        local idx = self:parse_value(cut_idx)
        self:cut(cut_arr, idx)
        return
    end
    
    -- Pattern: greater x y
    local gr_a, gr_b = line:match("^greater%s+([%w_]+)%s+([%w_]+)$")
    if gr_a then
        self:greater(gr_a, gr_b)
        return
    end
    
    -- Pattern: less x y
    local ls_a, ls_b = line:match("^less%s+([%w_]+)%s+([%w_]+)$")
    if ls_a then
        self:less(ls_a, ls_b)
        return
    end
    
    -- OLD SYNTAX FALLBACK
    -- Pattern: function_name(args)
    local func_name, args_str = line:match("^(%w+)%s*%((.*)%)$")
    
    if func_name then
        -- Parse arguments (this will now evaluate nested function calls)
        local args = self:parse_arguments(args_str)
        
        -- Execute built-in functions
        if self[func_name] and type(self[func_name]) == "function" then
            local success, result = pcall(function()
                return self[func_name](self, table.unpack(args))
            end)
            
            if not success then
                print("error: " .. tostring(result))
            end
        elseif self.funcstorage[func_name] then
            -- Call user-defined function
            self:call(func_name, table.unpack(args))
        else
            print("error: unknown function '" .. func_name .. "'")
        end
    end
end

function NovaInterpreter:execute(code)
    -- Split code into lines
    local lines = {}
    for line in code:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end
    
    local i = 1
    while i <= #lines do
        local line = trim(lines[i])
        
        -- Check if this is an if statement
        if line:match("^if%s+") then
            i = self:execute_if_block(lines, i)
        else
            -- Only execute non-empty lines that aren't just braces
            if line ~= "" and line ~= "}" and not line:match("^}%s*else") then
                self:execute_line(line)
            end
        end
        
        i = i + 1
    end
end

-- Main function
local function main()
    local interpreter = NovaInterpreter:new()
    
    if arg[1] then
        -- Execute file
        local filename = arg[1]
        local file = io.open(filename, "r")
        if not file then
            print("error: file '" .. filename .. "' not found")
            os.exit(1)
        end
        local code = file:read("*all")
        file:close()
        interpreter:execute(code)
    else
        -- Interactive REPL
        print("Nova Interpreter v0.1.0 (New Syntax)")
        print("Type 'exit' or 'quit' to exit")
        print()
        
        while true do
            io.write("nova> ")
            io.flush()
            local line = io.read("*line")
            
            if not line then
                break
            end
            
            line = trim(line)
            
            if line:lower() == "exit" or line:lower() == "quit" then
                break
            end
            
            local success, err = pcall(function()
                interpreter:execute_line(line)
            end)
            
            if not success then
                print("error: " .. tostring(err))
            end
        end
    end
end

-- Run main
main()

collectgarbage()
