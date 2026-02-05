local M = {}

local function default_spec()
    return {
        light = { scheme = "NeoSolarized", background = "light" },
        dark = { scheme = "NeoSolarized", background = "dark" },
    }
end

M.defaults = default_spec()
M.current = { scheme = nil, background = nil }

local function apply_colorscheme(scheme)
    if scheme and scheme ~= "" then
        vim.cmd.colorscheme(scheme)
    end
end

local function normalize_spec(spec)
    spec = spec or {}
    return {
        scheme = spec.scheme or M.current.scheme,
        background = spec.background or M.current.background,
    }
end

local function apply_spec(spec)
    spec = normalize_spec(spec)
    if spec.background then
        vim.o.background = spec.background
    end
    if spec.scheme == "NeoSolarized" then
        local ok, neo = pcall(require, "NeoSolarized")
        if ok then
            neo.setup({
                style = spec.background or vim.o.background,
                transparent = false,
                terminal_colors = true,
                enable_italics = true,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                    functions = { bold = true },
                    variables = {},
                    string = { italic = true },
                    underline = true,
                    undercurl = true,
                },
            })
        end
    end
    apply_colorscheme(spec.scheme)
    M.current.scheme = spec.scheme
    M.current.background = spec.background
end

function M.apply(background)
    if type(background) == "table" then
        apply_spec(background)
    else
        apply_spec({ background = background })
    end
end

function M.toggle()
    if vim.o.background == "dark" then
        apply_spec(M.defaults.light)
        return
    end
    apply_spec(M.defaults.dark)
end

function M.select()
    local ok, telescope = pcall(require, "telescope.builtin")
    if ok then
        telescope.colorscheme({
            enable_preview = true,
            attach_mappings = function(_, map)
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")

                actions.select_default:replace(function(prompt_bufnr)
                    local entry = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    if not entry or not entry.value then
                        return
                    end
                    local scheme = entry.value
                    M.apply({ scheme = scheme, background = vim.o.background })
                    vim.ui.select(
                        { "session only", "set as light default", "set as dark default" },
                        { prompt = "Theme selection action:" },
                        function(choice)
                            if choice == "set as light default" then
                                M.set_default("light", { scheme = scheme, background = "light" })
                            elseif choice == "set as dark default" then
                                M.set_default("dark", { scheme = scheme, background = "dark" })
                            end
                        end
                    )
                end)

                map("i", "<C-l>", function()
                    local entry = action_state.get_selected_entry()
                    if entry and entry.value then
                        M.set_default("light", { scheme = entry.value, background = "light" })
                        vim.notify("Light default set: " .. entry.value)
                    end
                end)
                map("i", "<C-d>", function()
                    local entry = action_state.get_selected_entry()
                    if entry and entry.value then
                        M.set_default("dark", { scheme = entry.value, background = "dark" })
                        vim.notify("Dark default set: " .. entry.value)
                    end
                end)
                map("n", "<C-l>", function()
                    local entry = action_state.get_selected_entry()
                    if entry and entry.value then
                        M.set_default("light", { scheme = entry.value, background = "light" })
                        vim.notify("Light default set: " .. entry.value)
                    end
                end)
                map("n", "<C-d>", function()
                    local entry = action_state.get_selected_entry()
                    if entry and entry.value then
                        M.set_default("dark", { scheme = entry.value, background = "dark" })
                        vim.notify("Dark default set: " .. entry.value)
                    end
                end)

                return true
            end,
        })
    else
        vim.notify("Telescope not available", vim.log.levels.WARN)
    end
end

function M.set_default(kind, spec)
    if kind ~= "light" and kind ~= "dark" then
        vim.notify("theme.set_default: kind must be 'light' or 'dark'", vim.log.levels.WARN)
        return
    end
    spec = normalize_spec(spec)
    if not spec.background then
        spec.background = kind
    end
    if not spec.scheme then
        vim.notify("theme.set_default: no scheme set", vim.log.levels.WARN)
        return
    end
    M.defaults[kind] = { scheme = spec.scheme, background = spec.background }
end

function M.setup()
    if type(vim.g.theme_defaults) == "table" then
        local g = vim.g.theme_defaults
        if type(g.light) == "table" then
            M.defaults.light = vim.tbl_extend("force", M.defaults.light, g.light)
        end
        if type(g.dark) == "table" then
            M.defaults.dark = vim.tbl_extend("force", M.defaults.dark, g.dark)
        end
    end

    if vim.o.background ~= "light" and vim.o.background ~= "dark" then
        vim.o.background = M.defaults.dark.background or "dark"
    end

    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function(args)
            M.current.scheme = args.match
        end,
    })

    vim.api.nvim_create_user_command("ThemeSetLight", function(opts)
        local scheme = opts.args ~= "" and opts.args or M.current.scheme
        M.set_default("light", { scheme = scheme, background = "light" })
    end, { nargs = "?" })

    vim.api.nvim_create_user_command("ThemeSetDark", function(opts)
        local scheme = opts.args ~= "" and opts.args or M.current.scheme
        M.set_default("dark", { scheme = scheme, background = "dark" })
    end, { nargs = "?" })

    vim.api.nvim_create_user_command("ThemeApplyLight", function()
        apply_spec(M.defaults.light)
    end, {})

    vim.api.nvim_create_user_command("ThemeApplyDark", function()
        apply_spec(M.defaults.dark)
    end, {})

    if vim.o.background == "light" then
        apply_spec(M.defaults.light)
    else
        apply_spec(M.defaults.dark)
    end
end

return M
