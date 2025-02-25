local id_generator = require('id_generator')
local xml_generator = require('xml_generator')
local attributes = require('attributes')

local doc = {}

function doc.is_exists(document, id)
    local success, result = pcall(function() return document[id].id end)
    return success
end

function doc.draw_component(info, parent_id, el)
    if not doc.is_exists(info.document, parent_id) then
        return
    end
    local id = id_generator.generate(info.document)
    local attrs = attributes.concat(el.attributes, {
        id = id
    })
    local xml = xml_generator.generate({
        tag = el.tag,
        label = el.label,
        attributes = attributes.any2str(attrs)
    })
    info.document[parent_id]:add(xml)
    return id
end

--  @param info = {
--      document: document,     -- document from *.xml.lua
--      package_id: string,     -- id of your package
--      src_path: string,       -- path to mod_directory/modules/ + src_path
--      App: App,               -- main component
--      root: string | nil      -- tag id, default 'root'
--  }
function doc.draw_app(info)

    -- TODO прописать ошибки
    if info == nil then
        return
    end
    if info.document == nil then
        return
    end
    if info.package_id == nil then
        return
    end
    if info.src_path == nil then
        return
    end
    if info.App == nil then
        return
    end
    info.root = info.root or 'root'
    info.document_util = doc
    info.document.root:clear()

    info.App.draw(info)

end

return doc
