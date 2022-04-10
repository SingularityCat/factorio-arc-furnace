-- disable rotation
script.on_event(defines.events.on_built_entity, function(event)
    if event.created_entity.name == "arc-furnace" then
        event.created_entity.rotatable = false
    end
end)
