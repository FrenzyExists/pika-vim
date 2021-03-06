
local present, telescope = pcall(require, "telescope")

if not present then
    return
end

telescope.setup(
    {
        defaults = {
            vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case"
            },
            prompt_prefix = "   ",
            selection_caret = "  ",
            entry_prefix = " ",
            initial_mode = "insert",
            scroll_strategy = "cycle",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.45,
                    results_width = 0.7
                },
                vertical = {
                    mirror = false
                },
                width = 0.78,
                height = 0.70,
                preview_cutoff = 120
            },
            file_sorter = require("telescope.sorters").get_fuzzy_file,
            file_ignore_patterns = {},
            generic_sorter = require("telescope.sorters").get_fzy_sorter,
            path_display = { shorten = 5 },
            winblend = 0,
            border = {},
            borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
            color_devicons = true,
            use_less = true,
            set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            },
            media_files = {
                filetypes = {"png", "webp", "jpg", "jpeg"},
                find_cmd = "rg" -- find command (defaults to `fd`)
            }
        }
    }
)
