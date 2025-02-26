local id_generator = require('id_generator')
local xml_generator = require('xml_generator')
local attributes = require('attributes')

local doc = {}

function doc.is_exists(document, id)
    local success, result = pcall(function() return document[id].id end)
    return success
end

function doc.draw_component(gui, parent_id, el)
    if not doc.is_exists(gui.document, parent_id) then
        return
    end
    local attrs = attributes.concat(el.atr or el.atrs or el.attributes or el.attrs or el.attr or el.attribute, {
        id = id_generator.generate(gui.document)
    })
    local xml = xml_generator.generate({
        tag = el.tag,
        label = el.label,
        attributes = attributes.any2str(attrs)
    })
    gui.document[parent_id]:add(xml)
    return attrs.id
end

--  @param layouts = {
--      document: document,     -- document from *.xml.lua
--      package_id: string,     -- id of your package
--      src_path: string,       -- path to mod_directory/modules/ + src_path
--      App: App,               -- main component
--      root: string | nil      -- tag id, default 'root'
--  }
function doc.draw_app(layout)

    -- TODO прописать ошибки
    if layout == nil then
        return
    end
    if layout.document == nil then
        return
    end
    if layout.package_id == nil then
        return
    end
    if layout.src_path == nil then
        return
    end
    if layout.App == nil then
        return
    end
    layout.document.root:clear()

    local gui = {
        document = layout.document,
        root = layout.root or 'root',

        draw = doc.draw_component
    }
    layout.App.draw(gui)

end

return doc
