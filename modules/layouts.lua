-- Main grid methods
local layout = {}

-- Define monitor names for layout purposes
local display_home  = "f.lux profile"
local display_laptop  = "Color LCD"
local display_monitor = "Thunderbolt Display"

-- Define window layouts
--   Format reminder:
--     {"App name", "Window name", "Display Name", "unitrect", "framerect", "fullframerect"},
layout.layouts = {
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
            {"Airmail",       nil, display_laptop,  {hs.layout.maximized}, nil, nil},
            {"Fantastical 2", nil, display_laptop,  {hs.layout.maximized}, nil, nil},
        },
        large={
            {"Google Chrome", nil, display_monitor, {0, 0, 2/3, 1},        nil, nil},
        }
    },
}

return layout