-- Main grid methods
local layouts = {}

-- Define monitor names for layout purposes
local display_home  = "f.lux profile"
local display_laptop  = "Color LCD"
local display_monitor = "Thunderbolt Display"

-- Define window layouts
--   Format reminder:
--     {"App name", "Window name", "Display Name", "unitrect", "framerect", "fullframerect"},
layouts.layouts = {
    {
        name="Home Laptop",
        description='15" MacBook Pro personal laptop screen'
    },
    {
        name="Work Laptop",
        description='13" MacBook Air work laptop screen'
    },
    {
        name="Office Setup",
        description="Dual monitor setup at the office",
        small={
            {"Spark",         nil, display_laptop,  {hs.layout.maximized}, nil, nil},
            {"Fantastical 2", nil, display_laptop,  {hs.layout.maximized}, nil, nil},
        },
        large={
            {"Google Chrome", nil, display_monitor, {0, 0, 2/3, 1},        nil, nil},
            {"Sublime Text",  nil, display_monitor, {1/3, 1/3, 1/3, 2/3},  nil, nil}
        }
    },
}

function layouts.applyLayout(layout)
    print('Layout ' .. layout.name .. ' selected')

    if lastNumberOfScreens > 1 then
        -- Multiple monitors
        print('We have multiple monitors')
        hs.layout.apply(layout.large, function(windowTitle, layoutWindowTitle)
            return string.sub(windowTitle, 1, string.len(layoutWindowTitle)) == layoutWindowTitle
        end)
    end

    -- Multiple monitors
    print('We have a single screen')
    hs.layout.apply(layout.small, function(windowTitle, layoutWindowTitle)
        return string.sub(windowTitle, 1, string.len(layoutWindowTitle)) == layoutWindowTitle
    end)
end

layouts.chooser = hs.chooser.new(function(selection)
    if not selection then return end
    layouts.applyLayout(layouts.layouts[selection.uuid])
end)

-- chooser:choices(choices)
local i = 0
local choices = hs.fnutils.imap(layouts.layouts, function(layout)
    i = i + 1
    return {
        uuid=i,
        text=layout.name,
        subText=layout.description
    }
end)
layouts.chooser:choices(choices)
layouts.chooser:searchSubText(true)
layouts.chooser:rows(#choices)
layouts.chooser:width(20)

return layouts