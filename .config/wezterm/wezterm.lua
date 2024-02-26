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

return {
	font = wezterm.font("Hack Nerd Font"),
	font_size = 12.0,
	color_scheme = "Dracula",
	use_fancy_tab_bar = false,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	initial_rows = 42,
	initial_cols = 115,
	use_ime = true,
	keys = {
		{ key = "LeftArrow", mods = "ALT", action = wezterm.action({ SendString = "\x1bb" }) },
		{ key = "RightArrow", mods = "ALT", action = wezterm.action({ SendString = "\x1bf" }) },
		{ key = "LeftArrow", mods = "SUPER", action = wezterm.action({ SendString = "\x1bOH" }) },
		{ key = "RightArrow", mods = "SUPER", action = wezterm.action({ SendString = "\x1bOF" }) },
	},
  window_background_opacity = 0.75,
  macos_window_background_blur = 20,
}
