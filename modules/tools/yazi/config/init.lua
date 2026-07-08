Status:children_add(function()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ui.Line({})
	end

	return ui.Line({
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		ui.Span(":"),
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		ui.Span(" "),
	})
end, 500, Status.RIGHT)

Header:children_add(function()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ui.Line({})
	end

	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end, 500, Header.LEFT)

-- Plugin Initializations
require("whoosh"):setup({})
require("git"):setup()
require("full-border"):setup()
require("spot"):setup({
	metadata_section = {
		enable = true,
		hash_cmd = "xxhsum", -- other hashing commands may be slower
		hash_filesize_limit = 150, -- in MB, set 0 to disable
		relative_time = true, -- 2026-01-01 or n days ago
		time_format = "%Y-%m-%d %H:%M", -- https://www.man7.org/linux/man-pages/man3/strftime.3.html
		show_compression = true, ---@type boolean
	},
	plugins_section = {
		enable = true,
	},
	style = {
		color = {
			metadata = true,
			title = "green",
			key = "reset",
			value = "blue",
			selected = "blue",
		},
		size = {
			height = 20, -- unused when auto_resize is set to true
			width = 60, -- unused when auto_resize is set to true
			auto_resize = true,
			min_width = 60,
			max_width = 80,
			min_height = 20,
			max_height = 40,
		},
		max_key_length = 25,
		key_indent_size = 2,
	},
})
