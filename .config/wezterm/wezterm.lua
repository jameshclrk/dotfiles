local wezterm = require("wezterm")

local function segments_for_right_status(window)
    return {
        window:active_workspace(),
        wezterm.strftime('%a %b %-d %H:%M'),
        wezterm.hostname(),
    }
end

wezterm.on('update-right-status', function(window, _)
    local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
    local segments = segments_for_right_status(window)

    local color_scheme = window:effective_config().resolved_palette
    local bg = wezterm.color.parse(color_scheme.background)
    local fg = color_scheme.foreground

    local gradient_to, gradient_from = bg
    gradient_from = gradient_to:lighten(0.2)

    local gradient = wezterm.color.gradient(
        {
            orientation = 'Horizontal',
            colors = { gradient_from, gradient_to },
        },
        #segments -- only gives us as many colours as we have segments.
    )
    local elements = {}

    for i, seg in ipairs(segments) do
        local is_first = i == 1

        if is_first then
            table.insert(elements, { Background = { Color = 'none' } })
        end
        table.insert(elements, { Foreground = { Color = gradient[i] } })
        table.insert(elements, { Text = SOLID_LEFT_ARROW })

        table.insert(elements, { Foreground = { Color = fg } })
        table.insert(elements, { Background = { Color = gradient[i] } })
        table.insert(elements, { Text = ' ' .. seg .. ' ' })
    end

    window:set_right_status(wezterm.format(elements))
end)

local config = wezterm.config_builder()
config.color_scheme = "Dracula"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 12.0
config.window_padding = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2,
}
-- config.use_fancy_tab_bar = true
config.window_decorations = 'RESIZE|INTEGRATED_BUTTONS'
config.keys = {
    { key = "LeftArrow",  mods = "ALT",   action = wezterm.action({ SendString = "\x1bb" }) },
    { key = "RightArrow", mods = "ALT",   action = wezterm.action({ SendString = "\x1bf" }) },
    { key = "LeftArrow",  mods = "SUPER", action = wezterm.action({ SendString = "\x1bOH" }) },
    { key = "RightArrow", mods = "SUPER", action = wezterm.action({ SendString = "\x1bOF" }) },
}

return config
