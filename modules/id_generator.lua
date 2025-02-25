local this = {}

local function is_exists(document, id)
    local success, result = pcall(function() return document[id].id end)
    return success
end

local function rand_str()
    local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local randomString = ""
    for i = 1, 8 do
        local randIndex = math.random(1, #charset)
        randomString = randomString .. charset:sub(randIndex, randIndex)
    end
    return randomString
end

function this.generate(document)
    for i = 1, 100, 1 do
        local id = rand_str()
        if not is_exists(document, id) then
            return id
        else
            print('WARN: Element with id=' .. id .. ' already exists!')
        end
    end
end

return this
