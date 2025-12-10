-------------------------------------------------
-- LEXER
-------------------------------------------------
local function lex(s)
    local t,i,L={},1,#s
    local function add(a,b) t[#t+1]={type=a,value=b} end

    local KW = {let=true,out=true,func=true,call=true,array=true,if=true,else=true}

    while i<=L do
        local c=s:sub(i,i)

        if c:match("%s") then i=i+1

        elseif c:match("%d") then
            local m=s:match("^[0-9]+",i)
            add("NUM",tonumber(m)); i=i+#m

        elseif c=='"' then
            local j=i+1 local buf={}
            while j<=L and s:sub(j,j)~='"' do buf[#buf+1]=s:sub(j,j); j=j+1 end
            add("STR",table.concat(buf)); i=j+1

        elseif c:match("[%a_]") then
            local id=s:match("^[%a_][%a%d_]*",i)
            if KW[id] then add("KW",id) else add("ID",id) end
            i=i+#id

        elseif c:match("[=+%-/*]") then add("OP",c); i=i+1
        elseif c=="[" or c=="]" or c=="{" or c=="}" then add("DL",c); i=i+1
        elseif c=="," then add("CM",","); i=i+1
        else error("bad char "..c) end
    end
    return t
end

-------------------------------------------------
-- PARSER
-------------------------------------------------
local function parse(tokens)
    local i=1; local function p() return tokens[i] end
    local function eat() local v=p(); i=i+1; return v end

    local function expr()
        local a=eat()
        if a.type=="NUM" or a.type=="STR" then return a.value end
        if a.type=="ID" then return {"var",a.value} end
        if a.type=="DL" and a.value=="[" then
            local arr={}
            while p().value~="]" do
                arr[#arr+1]=expr()
                if p().type=="CM" then eat() end
            end
            eat()
            return arr
        end
    end

    local function block()
        local b={}
        eat() -- {
        while p().value~="}" do
            local t=p()

            if t.value=="let" then
                eat()
                local name=eat().value
                eat() -- =
                b[#b+1]={"let",name,expr()}

            elseif t.value=="out" then
                eat()
                b[#b+1]={"out",expr()}

            elseif t.value=="if" then
                b[#b+1]=stmt() -- recurse

            end
        end
        eat() -- }
        return b
    end

    function stmt()
        local tok=p()

        -- let name = expr
        if tok.value=="let" then
            eat()
            local name=eat().value
            eat()
            return {"let",name,expr()}

        -- out expr
        elseif tok.value=="out" then
            eat()
            return {"out",expr()}

        -- array name = [...]
        elseif tok.value=="array" then
            eat()
            local name=eat().value
            eat()
            return {"array",name,expr()}

        -- func name { ... }
        elseif tok.value=="func" then
            eat()
            local name=eat().value
            local body=block()
            return {"func",name,body}

        -- call name
        elseif tok.value=="call" then
            eat()
            return {"call",eat().value}

        -- if var = value { block } else { block }
        elseif tok.value=="if" then
            eat()
            local var=eat().value
            eat() -- =
            local val=expr()
            local ifbody=block()
            local elsebody=nil

            if p() and p().value=="else" then
                eat()
                elsebody=block()
            end

            return {"if",var,val,ifbody,elsebody}
        end
    end

    local program={}
    while p() do
        program[#program+1]=stmt()
    end
    return program
end

-------------------------------------------------
-- EXECUTOR
-------------------------------------------------
local function eval(v)
    if type(v)~="table" then return v end
    if v[1]=="var" then return varstorage[v[2]] end
    return v
end

function interpret(code)
    local tokens=lex(code)
    local ast=parse(tokens)

    for _,node in ipairs(ast) do
        local t=node[1]

        if t=="let" then
            let(node[2],eval(node[3]))

        elseif t=="out" then
            out(eval(node[2]))

        elseif t=="array" then
            array(node[2],eval(node[3]))

        elseif t=="func" then
            local name=node[2]
            local body=node[3]
            func(name,function()
                for _,s in ipairs(body) do
                    local k=s[1]
                    if k=="let" then let(s[2],eval(s[3]))
                    elseif k=="out" then out(eval(s[2])) end
                end
            end)

        elseif t=="call" then
            call(node[2])

        elseif t=="if" then
            local var=node[2]
            local val=node[3]
            local ifb=node[4]
            local elseb=node[5]

            if varstorage[var]==val then
                for _,s in ipairs(ifb) do
                    local k=s[1]
                    if k=="let" then let(s[2],eval(s[3]))
                    elseif k=="out" then out(eval(s[2])) end
                end
            elseif elseb then
                for _,s in ipairs(elseb) do
                    local k=s[1]
                    if k=="let" then let(s[2],eval(s[3]))
                    elseif k=="out" then out(eval(s[2])) end
                end
            end
        end
    end
end

--[[ example novascirpt code
     let x = 10
     out x

    array nums = [1, 2, 3]
    out nums

    func show {
        out x
    }

    call show

    let x = 10

    if x = 10 {
        out "correct"
    } else {
        out "wrong"
    }
]]
