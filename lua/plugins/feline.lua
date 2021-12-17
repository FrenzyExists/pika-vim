-- Feline

if not pcall(require, "feline") then
  return
end

local vi_mode_utils = require 'feline.providers.vi_mode'
local pika_colors = require 'colors'
local cursor = require 'feline.providers.cursor'
local lsp = require 'feline.providers.lsp'

local vi_mode_colors = {
    NORMAL = pika_colors.gui0D,
    INSERT = pika_colors.gui08,
    VISUAL = pika_colors.gui0E,
    OP = pika_colors.gui0B,
    BLOCK = pika_colors.gui0A,
    REPLACE = pika_colors.gui0E,
    ['V-REPLACE'] = pika_colors.gui0E,
    ENTER = pika_colors.gui0C,
    MORE = pika_colors.gui0C,
    SELECT = pika_colors.gui09,
    COMMAND = pika_colors.gui0B,
    SHELL = pika_colors.gui0B,
    TERM = pika_colors.gui0B,
    NONE = pika_colors.gui0F
}


local vi_mode_text = {
    n = "NORMIE",
    no = "OP-PENDING",

    i = "INSERT",
    ic = "INSCOMP",

    v = "VISUAL",
    [''] = "V-BLOCK",
    V = "V-LINE",

    c = "COMMAND",
    cv = "EX",
    ce = "NORMEX",

    s = "SELECT",
    S = "SELECT",

    R = "REPLACE",
    Rv = "VIRTUAL",
    r = "HIT-ENTER",
    rm = "CONFIRM",

    t = "TERM"
}

local function file_osinfo()
    local os = vim.bo.fileformat:upper()
    local icon
    if os == 'UNIX' then
        icon = ' '
    elseif os == 'MAC' then
        icon = ' '
    else
        icon = ' '
    end
    return icon .. os
end

local lsp_get_diag = function(str)
  local count = vim.lsp.diagnostic.get_count(0, str)
  return (count > 0) and ' '..count..' ' or ''
end

-- LuaFormatter off

local comps = {
    vi_mode = {
        icon = {
            provider = function() return ' ⋓ ' end,
            hl = {
                bg = pika_colors.gui03,
                fg = pika_colors.gui09,
            }
        },
        left = {
            provider = function()
              return vi_mode_text[vim.fn.mode()]..' '
            end,
            hl = function()
                local val = {
                    name = vi_mode_utils.get_mode_highlight_name(),
                    bg = vi_mode_utils.get_mode_color(),
                    -- fg = colors.bg
                }
                return val
            end,
            left_sep = {
                str = ' ',
                hl = function()
                    local val = {
                        name = vi_mode_utils.get_mode_highlight_name(),
                        bg = vi_mode_utils.get_mode_color(),
                        fg = pika_colors.gui03
                    }
                      return val
                  end,
            },
            right_sep = {
                str = '',
                hl = function()
                    local val = {
                        fg = vi_mode_utils.get_mode_color(),
                        bg = pika_colors.gui03
                    }
                      return val
                  end,
            }
        },
    },
    file = {
        div = {
            provider = function() return '' end,
            h1 = {
               bg = pika_colors.gui03,
            },
        },
        info = {
            provider = {
              name = 'file_info',
              opts = {
                type = 'short',
                file_readonly_icon = '',
                file_modified_icon = '',
                icons = false,

              }
            },
            right_sep = {
                str = ''
            },
            hl = {
                fg = pika_colors.gui04,
                bg = pika_colors.gui03,
                style = 'italic'
            }
        },
        type = {
            provider = 'file_type',
            left_sep = '',
            right_sep = '█',
            hl = {
                fg = pika_colors.gui08,
                bg = pika_colors.gui03
            }
        },
        os = {
            provider = file_osinfo,
            left_sep = ' ',
            hl = {
                fg = pika_colors.gui0E,
                style = 'bold'
            }
        },
        right_end = {  -- ﲹ
            provider = function() return ' ' end,
            left_sep = {
                str = '',
                hl = {
                    bg = pika_colors.gui03,
                    fg = pika_colors.gui0B
                },
            },
            hl = {
                fg = pika_colors.gui03,
                bg = pika_colors.gui0B,
            }
        },
    },

    line_percentage = {
        provider = {
            name = 'line_percentage',
        },
        right_sep = {
            str = ' ',
            hl = {
                bg = pika_colors.gui03,
                fg = pika_colors.gui0B
            },
        },
        left_sep = {
            str = ' ',
            hl = {
                bg = pika_colors.gui03,
                fg = pika_colors.gui0B
            },
        },
        hl = {
            style = 'bold',
            bg = pika_colors.gui03,
            fg = pika_colors.gui0B,

        }
    },
    git = {
        branch = {
            provider = 'git_branch',
            left_sep = {
                str = '',
                hl = {
                    bg = pika_colors.gui03,
                    fg = pika_colors.gui09
                },
            },
            right_sep = {
                str = ' ',
               hl = {
                    bg = pika_colors.gui03,
                    fg = pika_colors.gui09
                },
            },
            icon = {
                str = 'ᛃ ' .. '█',
                hl = {
                    bg = pika_colors.gui09,
                    fg = pika_colors.gui03,
                }
            },
            hl = {
                fg = pika_colors.gui09,
                bg = pika_colors.gui03,
            },
        },
        add = {
            provider = 'git_diff_added',
            icon = {
                str = ' +',
            },
            hl = {
                fg = pika_colors.gui0B
            }
        },
        change = {
            provider = 'git_diff_changed',
            icon = {
                str = ' ~',
            },
            hl = {
                fg =pika_colors.gui09
            }
        },
        remove = {
            provider = 'git_diff_removed',
            icon = {
                str = ' -',
            },
            hl = {
                fg =pika_colors.gui08
            }
        },
    }
}

local components = {
  active = {},
  inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

table.insert(components.active[1], comps.vi_mode.icon)
table.insert(components.active[1], comps.vi_mode.left)
table.insert(components.active[1], comps.file.info)
table.insert(components.active[1], comps.file.os)
table.insert(components.active[1], comps.file.div)
table.insert(components.active[1], comps.git.add)
table.insert(components.active[1], comps.git.change)
table.insert(components.active[1], comps.git.remove)

table.insert(components.active[3], comps.file.type)
table.insert(components.active[3], comps.git.right_end)
table.insert(components.active[3], comps.git.branch)
table.insert(components.active[3], comps.file.right_end)
table.insert(components.active[3], comps.line_percentage)

--table.insert(components.inactive[1], comps.file.info)

--table.insert(components.inactive[3], comps.file.type)

-- require'feline'.setup {}
require'feline'.setup {
    colors = {
        bg = pika_colors.gui01,
        fg = pika_colors.gui05
    },
    components = components,
    vi_mode_colors = vi_mode_colors,
    force_inactive = {
        buftypes = {'terminal'},
        bufnames = {}
    }
}
