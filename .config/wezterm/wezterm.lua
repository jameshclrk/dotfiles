local wezterm = require("wezterm")

wezterm.on("update-right-status", function(window, pane)
	-- "Wed Mar 3 08:14"
	local date = wezterm.strftime("%a %b %-d %H:%M ")

	local bat = ""
	for _, b in ipairs(wezterm.battery_info()) do
		bat = "🔋 " .. string.format("%.0f%%", b.state_of_charge * 100)
	end

	window:set_right_status(wezterm.format({
		{ Text = bat .. "   " .. date },
	}))
end)

local config = wezterm.config_builder()
config.color_scheme = "Dracula"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 12.0
config.window_background_opacity = 0.75
config.macos_window_background_blur = 20
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.use_fancy_tab_bar = true
config.keys = {
	{ key = "LeftArrow", mods = "ALT", action = wezterm.action({ SendString = "\x1bb" }) },
	{ key = "RightArrow", mods = "ALT", action = wezterm.action({ SendString = "\x1bf" }) },
	{ key = "LeftArrow", mods = "SUPER", action = wezterm.action({ SendString = "\x1bOH" }) },
	{ key = "RightArrow", mods = "SUPER", action = wezterm.action({ SendString = "\x1bOF" }) },
}

return config
