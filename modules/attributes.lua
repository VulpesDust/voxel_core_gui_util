local this = {}

--[[
Предоставляет функции для преобразования атрибутов между строковым и табличным форматами,
а также для объединения атрибутов.
]]

--[[
Преобразует атрибуты в строковый формат.
@param attrs (table|string) Атрибуты в виде таблицы или строки.
@return (string) Строка атрибутов в формате key1="value1" key2="value2".
]]
function this.any2str(attrs)
    if not attrs then
        return ''
    end
    if type(attrs) == "table" then
        local xml = ''
        for k, v in pairs(attrs) do
            xml = xml .. ' ' .. k .. '="' .. tostring(v) .. '"'
        end
        return xml
    end
    if type(attrs) == "string" then
        return attrs
    end
    return ''
end

--[[
Преобразует атрибуты в табличный формат.
@param attrs (string|table) Атрибуты в виде строки или таблицы.
@return (table) Таблица с атрибутами, где ключи — имена атрибутов, а значения — их значения.
]]
function this.any2table(attrs)
    if not attrs then
        return {}
    end
    if type(attrs) == "string" then
        local t = {}
        if str then
            for key, value in attrs:gmatch('(%w+)="([^"]*)"') do
                t[key] = value
            end
        end
        return t
    end
    if type(attrs) == "table" then
        return attrs
    end
    return {}
end

--[[
Объединяет два набора атрибутов.
Если атрибуты присутствуют в обоих наборах, приоритет отдается второму набору (customAttributes).
@param defaultAttributes (table) Набор атрибутов по умолчанию.
@param customAttributes (table) Набор атрибутов, который имеет приоритет над defaultAttributes.
@return (table) Объединенная таблица атрибутов.
]]
function this.concat(defaultAttributes, customAttributes)
    if not customAttributes then
        return defaultAttributes
    end
    if not defaultAttributes then
        return customAttributes
    end

    local mergedAttributes = this.any2table(defaultAttributes)
    local customAttributesTable = this.any2table(customAttributes)

    for key, value in pairs(customAttributesTable) do
        mergedAttributes[key] = value
    end

    return mergedAttributes
end

return this
