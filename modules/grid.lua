-- Main grid methods
local grid = {}
local window = hs.window

function grid.snap(win, x, y, w, h)
    local newframe = {
        x = x,
        y = y,
        w = w,
        h = h,
    }
    win:setFrame(newframe, 0)
end

function grid.getAllValidWindows()
    local allWindows = hs.window.allWindows()
    local windows = {}
    local index = 1
    for i = 1, #allWindows do
        local w = allWindows[i]
        if w:screen() then
            windows[index] = w
            index = index + 1
        end
    end
    return windows
end

-- +------------------+
-- | +--------------+ +
-- | |              | |
-- | |     HERE     | |
-- | |              | |
-- | +--------------+ |
-- +------------------+
function grid.center_fullscreen()
    local win = window.focusedWindow()
    local s = win:screen():frame()
    grid.snap(win, s.x, s.y, s.w, s.h)
end

-- +-----------------+
-- |      HERE       |
-- +-----------------+
-- |                 |
-- +-----------------+
function grid.snap_north()
    local win = window.focusedWindow()
    local s = win:screen():frame()
    grid.snap(win, s.x, 0, s.w, s.h/2)
end

-- +-----------------+
-- |                 |
-- +-----------------+
-- |      HERE       |
-- +-----------------+
function grid.snap_south()
    local win = window.focusedWindow()
    local s = win:screen():frame()
    grid.snap(win, s.x, s.y+(s.h/2), s.w, s.h/2)
end

-- +-----------------+
-- |        |        |
-- |        |  HERE  |
-- |        |        |
-- +-----------------+
function grid.snap_east()
    local win = window.focusedWindow()
    local s = win:screen():frame()
    grid.snap(win, s.x+s.w/2, 0, s.w/2, s.h)
end

-- +-----------------+
-- |        |        |
-- |  HERE  |        |
-- |        |        |
-- +-----------------+
function grid.snap_west()
    local win = window.focusedWindow()
    local s = win:screen():frame()
    grid.snap(win, s.x, 0, s.w/2, s.h)
end

-- +-----------------+
-- |  HERE  |        |
-- +--------+        |
-- |                 |
-- +-----------------+
function grid.snap_northwest()
    local win = window.focusedWindow()
    local s = win:screen():frame()
    grid.snap(win, s.x, 0, s.w/2, s.h/2)
end

-- +-----------------+
-- |        |  HERE  |
-- |        +--------|
-- |                 |
-- +-----------------+
function grid.snap_northeast()
    local win = window.focusedWindow()
    local s = win:screen():frame()
    grid.snap(win, s.x+s.w/2, 0, s.w/2, s.h/2)
end

-- +-----------------+
-- |                 |
-- +--------+        |
-- |  HERE  |        |
-- +-----------------+
function grid.snap_southwest()
    local win = window.focusedWindow()
    local s = win:screen():frame()
    grid.snap(win, s.x, s.y+(s.h/2), s.w/2, s.h/2)
end

-- +-----------------+
-- |                 |
-- |        +--------|
-- |        |  HERE  |
-- +-----------------+
function grid.snap_southeast()
    local win = window.focusedWindow()
    local s = win:screen():frame()
    grid.snap(win, s.x+s.w/2, s.y+(s.h/2), s.w/2, s.h/2)
end

-- +-----------------+
-- |     |           |
-- |  H  |           |
-- |     |           |
-- +-----------------+
function grid.snap_west_one_third()
    local win = window.focusedWindow()
    local s = win:screen():frame()
    grid.snap(win, s.x, 0, s.w/3, s.h)
end

-- +-----------------+
-- |           |     |
-- |   HERE    |     |
-- |           |     |
-- +-----------------+
function grid.snap_west_two_thirds()
    local win = window.focusedWindow()
    local s = win:screen():frame()
    grid.snap(win, s.x, 0, s.w*(2/3), s.h)
end

-- +-----------------+
-- |           |     |
-- |           |  H  |
-- |           |     |
-- +-----------------+
function grid.snap_east_one_third()
    local win = window.focusedWindow()
    local s = win:screen():frame()
    grid.snap(win, s.x+s.w*(2/3), 0, s.w/3, s.h)
end

-- +-----------------+
-- |     |           |
-- |     |   HERE    |
-- |     |           |
-- +-----------------+
function grid.snap_east_two_thirds()
    local win = window.focusedWindow()
    local s = win:screen():frame()
    grid.snap(win, s.x+s.w/3, 0, s.w*(2/3), s.h)
end

-- +-----------------+
-- |      HERE       |
-- +-----------------+
-- |                 |
-- |                 |
-- +-----------------+
function grid.snap_north_one_third()
    local win = window.focusedWindow()
    local s = win:screen():frame()
    grid.snap(win, s.x, 0, s.w, s.h/3)
end

-- +-----------------+
-- |                 |
-- |      HERE       |
-- +-----------------+
-- |                 |
-- +-----------------+
function grid.snap_north_two_thirds()
    local win = window.focusedWindow()
    local s = win:screen():frame()
    grid.snap(win, s.x, 0, s.w, s.h*(2/3))
end

-- +-----------------+
-- |                 |
-- |                 |
-- +-----------------+
-- |      HERE       |
-- +-----------------+
function grid.snap_south_one_third()
    local win = window.focusedWindow()
    local s = win:screen():frame()
    grid.snap(win, s.x, s.y+(s.h*(2/3)), s.w, s.h/3)
end

-- +-----------------+
-- |                 |
-- +-----------------+
-- |      HERE       |
-- |                 |
-- +-----------------+
function grid.snap_south_two_thirds()
    local win = window.focusedWindow()
    local s = win:screen():frame()
    grid.snap(win, s.x, s.y+(s.h/3), s.w, s.h*(2/3))
end

return grid