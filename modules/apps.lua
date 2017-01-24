apps = {}

apps.launchers = {
    {
        name="Home - Coding",
        description="Launch apps for coding.",
        apps={
            "Sublime Text",
            "iTerm",
            "Dash"
        }
    },
    {
        name="Work - Essential",
        description="Launch bare minimum apps (for single screen).",
        apps={
            "Google Chrome",
            "Spark",
            "Fantastical 2",
            "Adium"
        }
    },
    {
        name="Work - Full Spread",
        description="Launch apps used in multi-monitor setup.",
        apps={
            "Google Chrome",
            "Spark",
            "Fantastical 2",
            "Adium",
            "Sublime Text"
        }
    },
    {
        name="Work - Coding",
        description="Launch apps for coding projects at work.",
        apps={
            "Sublime Text",
            "iTerm"
        }
    }
}

function apps.launchApps(launcher)
    print('Launcher ' .. launcher.name .. ' selected')

    for _, app in ipairs(launcher.apps) do
        if app then
            hs.application.launchOrFocus(app)
        end
    end
end

apps.launcher = hs.chooser.new(function(selection)
    if not selection then return end
    apps.launchApps(apps.launchers[selection.uuid])
end)

local i = 0
local choices = hs.fnutils.imap(apps.launchers, function(launcher)
    i = i + 1
    return {
        uuid=i,
        text=launcher.name,
        subText=launcher.description
    }
end)
apps.launcher:choices(choices)
apps.launcher:searchSubText(true)
apps.launcher:rows(#choices)
apps.launcher:width(20)

return apps