local wezterm = require("wezterm")
local act = wezterm.action

-- My Palette

Black = "#16161D"
Red = "#C34043"
Green = "#76946A"
Yellow = "#C0A36E"
Blue = "#7E9CD8"
Magenta = "#957FB8"
Cyan = "#6A9589"
White = "#C8C093"
Black_b = "#727169"
Red_b = "#E82424"
Green_b = "#98BB6C"
Yellow_b = "#E6C384"
Blue_b = "#7FB4CA"
Magenta_b = "#938AA9"
Cyan_b = "#7AA89F"
White_b = "#DCD7BA"

Main = White_b
Background = "#000000"

return {
  default_cwd = "/home/leo",

  font = wezterm.font_with_fallback({
    "ComicShannsMono Nerd Font",
  }),

  font_size = 12,

  window_background_opacity = 0.90,
  inactive_pane_hsb = {
    saturation = 0.9,
  },

  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,

  colors = {
    -- The default text color
    foreground = White_b,
    -- The default background color
    background = Background,

    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    cursor_bg = Main,
    -- Overrides the text color when the current cell is occupied by the cursor
    cursor_fg = Background,
    -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- Bar or Underline.
    cursor_border = Main,

    -- the foreground color of selected text
    selection_fg = Background,
    -- the background color of selected text
    selection_bg = Main,

    -- The color of the split lines between panes
    split = Black_b,
    tab_bar = {
      -- The color of the strip that goes along the top of the window
      -- (does not apply when fancy tab bar is in use)
      background = Main,

      -- The active tab is the one that has focus in the window
      active_tab = {
        -- The color of the background area for the tab
        bg_color = Main,
        -- The color of the text for the tab
        fg_color = Background,

        -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
        -- label shown for this tab.
        -- The default is "Normal"
        -- font = 'ComicCode',

        -- Specify whether you want "None", "Single" or "Double" underline for
        -- label shown for this tab.
        -- The default is "None"
        underline = "None",

        -- Specify whether you want the text to be italic (true) or not (false)
        -- for this tab.  The default is false.
        italic = false,

        -- Specify whether you want the text to be rendered with strikethrough (true)
        -- or not for this tab.  The default is false.
        strikethrough = false,
      },

      -- Inactive tabs are the tabs that do not have focus
      inactive_tab = {
        bg_color = Background,
        fg_color = White_b,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab`.
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over inactive tabs
      inactive_tab_hover = {
        bg_color = Main,
        fg_color = Background,
        italic = false,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab_hover`.
      },

      -- The new tab button that let you create new tabs
      new_tab = {
        bg_color = Background,
        fg_color = White_b,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab`.
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over the new tab button
      new_tab_hover = {
        bg_color = Main,
        fg_color = Background,
        italic = false,

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab_hover`.
      },
    },

    ansi = {
      Black,
      Red,
      Green,
      Yellow,
      Blue,
      Magenta,
      Cyan,
      White,
    },

    brights = {
      Black_b,
      Red,
      Green_b,
      Yellow_b,
      Blue_b,
      Magenta_b,
      Cyan_b,
      White_b,
    },
  },

  keys = {
    -- Create a new tab in the same domain as the current pane.
    -- This is usually what you want.
    {
      key = "y",
      mods = "SHIFT|CTRL",
      action = act.SpawnTab("CurrentPaneDomain"),
    },
    -- Create a new tab in the default domain
    { key = "t", mods = "SHIFT|CTRL", action = act.SpawnTab("DefaultDomain") },
    {
      key = "w",
      mods = "SHIFT|CTRL",
      action = wezterm.action.CloseCurrentTab({ confirm = false }),
    },
    { key = "LeftArrow", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
    { key = "RightArrow", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(1) },
    { key = "h", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
    { key = "l", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(1) },
    -- This will create a new split and run your default program inside it
    {
      key = "s",
      mods = "SHIFT|CTRL",
      action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "UpArrow",
      mods = "SHIFT|CTRL",
      action = act.ActivatePaneDirection("Up"),
    },
    {
      key = "DownArrow",
      mods = "SHIFT|CTRL",
      action = act.ActivatePaneDirection("Down"),
    },
    {
      key = "k",
      mods = "SHIFT|CTRL",
      action = act.ActivatePaneDirection("Up"),
    },
    {
      key = "j",
      mods = "SHIFT|CTRL",
      action = act.ActivatePaneDirection("Down"),
    },
    {
      key = "q",
      mods = "SHIFT|CTRL",
      action = wezterm.action.CloseCurrentPane({ confirm = true }),
    },
  },
}
