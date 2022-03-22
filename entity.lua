local UUID = require("plugin.uuid")

-- dont run this function on one frame

local getEntity = function ()
    local id = UUID.new()
    local components = {}

    local function getID()
        return id
    end 

    local function getComponents() 
        return components
    end

    local function addComponent(component) 
        components[component.name] = component
    end

    local function removeComponent(name)
        components[name] = nil
    end

    return {
        getID = getID,
        getComponents = getComponents,
        addComponent = addComponent,
        removeComponent = removeComponent,
    }
end

return getEntity