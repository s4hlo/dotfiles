LAZY_PLUGIN_SPEC = {}

function Plugin(name)
	local full_name = "plugins." .. name
	table.insert(LAZY_PLUGIN_SPEC, { import = full_name })
end
