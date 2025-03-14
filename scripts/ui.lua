------------------------------------------------------------------------
--  OBSIDIAN  :  NUKLEAR UI INTERFACE
------------------------------------------------------------------------
--
--
--  Copyright (C) 2024 The OBSIDIAN Team
--
--  This program is free software; you can redistribute it and/or
--  modify it under the terms of the GNU General Public License
--  as published by the Free Software Foundation; either version 2,
--  of the License, or (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
------------------------------------------------------------------------

-- CAVEMAN SHIT BELOW THIS LINE --

local normal_font
local bold_font
local font_scale

function ob_gui_init_fonts(scale)
  if OB_NK_CTX == nil then return "bork" end
  if OB_NK_ATLAS == nil then return "bork" end
  normal_font = OB_NK_ATLAS:add(24 * scale, "data/fonts/SourceSansPro/SourceSansPro-Regular.ttf")
  normal_font:set_height(24)
  bold_font = OB_NK_ATLAS:add(24 * scale, "data/fonts/SourceSansPro/SourceSansPro-Bold.ttf")
  bold_font:set_height(24)
  nk.style_set_font(OB_NK_CTX, normal_font)
  font_scale = scale
  return "groovy"
end

local colortable = {}

colortable.white = {
   text = nk.color_from_bytes(70, 70, 70, 255),
   window = nk.color_from_bytes(175, 175, 175, 255),
   header = nk.color_from_bytes(175, 175, 175, 255),
   border = nk.color_from_bytes(0, 0, 0, 255),
   button = nk.color_from_bytes(185, 185, 185, 255),
   button_hover = nk.color_from_bytes(170, 170, 170, 255),
   button_active = nk.color_from_bytes(160, 160, 160, 255),
   toggle = nk.color_from_bytes(150, 150, 150, 255),
   toggle_hover = nk.color_from_bytes(120, 120, 120, 255),
   toggle_cursor = nk.color_from_bytes(175, 175, 175, 255),
   select = nk.color_from_bytes(190, 190, 190, 255),
   select_active = nk.color_from_bytes(175, 175, 175, 255),
   slider = nk.color_from_bytes(190, 190, 190, 255),
   slider_cursor = nk.color_from_bytes(80, 80, 80, 255),
   slider_cursor_hover = nk.color_from_bytes(70, 70, 70, 255),
   slider_cursor_active = nk.color_from_bytes(60, 60, 60, 255),
   property = nk.color_from_bytes(175, 175, 175, 255),
   edit = nk.color_from_bytes(150, 150, 150, 255),
   edit_cursor = nk.color_from_bytes(0, 0, 0, 255),
   combo = nk.color_from_bytes(175, 175, 175, 255),
   chart = nk.color_from_bytes(160, 160, 160, 255),
   chart_color = nk.color_from_bytes(45, 45, 45, 255),
   chart_color_highlight = nk.color_from_bytes( 255, 0, 0, 255),
   scrollbar = nk.color_from_bytes(180, 180, 180, 255),
   scrollbar_cursor = nk.color_from_bytes(140, 140, 140, 255),
   scrollbar_cursor_hover = nk.color_from_bytes(150, 150, 150, 255),
   scrollbar_cursor_active = nk.color_from_bytes(160, 160, 160, 255),
   tab_header = nk.color_from_bytes(180, 180, 180, 255),
}

colortable.red = {
   text = nk.color_from_bytes(190, 190, 190, 255),
   window = nk.color_from_bytes(30, 33, 40, 215),
   header = nk.color_from_bytes(181, 45, 69, 220),
   border = nk.color_from_bytes(51, 55, 67, 255),
   button = nk.color_from_bytes(181, 45, 69, 255),
   button_hover = nk.color_from_bytes(190, 50, 70, 255),
   button_active = nk.color_from_bytes(195, 55, 75, 255),
   toggle = nk.color_from_bytes(51, 55, 67, 255),
   toggle_hover = nk.color_from_bytes(45, 60, 60, 255),
   toggle_cursor = nk.color_from_bytes(181, 45, 69, 255),
   select = nk.color_from_bytes(51, 55, 67, 255),
   select_active = nk.color_from_bytes(181, 45, 69, 255),
   slider = nk.color_from_bytes(51, 55, 67, 255),
   slider_cursor = nk.color_from_bytes(181, 45, 69, 255),
   slider_cursor_hover = nk.color_from_bytes(186, 50, 74, 255),
   slider_cursor_active = nk.color_from_bytes(191, 55, 79, 255),
   property = nk.color_from_bytes(51, 55, 67, 255),
   edit = nk.color_from_bytes(51, 55, 67, 225),
   edit_cursor = nk.color_from_bytes(190, 190, 190, 255),
   combo = nk.color_from_bytes(51, 55, 67, 255),
   chart = nk.color_from_bytes(51, 55, 67, 255),
   chart_color = nk.color_from_bytes(170, 40, 60, 255),
   chart_color_highlight = nk.color_from_bytes( 255, 0, 0, 255),
   scrollbar = nk.color_from_bytes(30, 33, 40, 255),
   scrollbar_cursor = nk.color_from_bytes(64, 84, 95, 255),
   scrollbar_cursor_hover = nk.color_from_bytes(70, 90, 100, 255),
   scrollbar_cursor_active = nk.color_from_bytes(75, 95, 105, 255),
   tab_header = nk.color_from_bytes(181, 45, 69, 220),
}

colortable.blue = {
   text = nk.color_from_bytes(20, 20, 20, 255),
   window = nk.color_from_bytes(202, 212, 214, 215),
   header = nk.color_from_bytes(137, 182, 224, 220),
   border = nk.color_from_bytes(140, 159, 173, 255),
   button = nk.color_from_bytes(137, 182, 224, 255),
   button_hover = nk.color_from_bytes(142, 187, 229, 255),
   button_active = nk.color_from_bytes(147, 192, 234, 255),
   toggle = nk.color_from_bytes(177, 210, 210, 255),
   toggle_hover = nk.color_from_bytes(182, 215, 215, 255),
   toggle_cursor = nk.color_from_bytes(137, 182, 224, 255),
   select = nk.color_from_bytes(177, 210, 210, 255),
   select_active = nk.color_from_bytes(137, 182, 224, 255),
   slider = nk.color_from_bytes(177, 210, 210, 255),
   slider_cursor = nk.color_from_bytes(137, 182, 224, 245),
   slider_cursor_hover = nk.color_from_bytes(142, 188, 229, 255),
   slider_cursor_active = nk.color_from_bytes(147, 193, 234, 255),
   property = nk.color_from_bytes(210, 210, 210, 255),
   edit = nk.color_from_bytes(210, 210, 210, 225),
   edit_cursor = nk.color_from_bytes(20, 20, 20, 255),
   combo = nk.color_from_bytes(210, 210, 210, 255),
   chart = nk.color_from_bytes(210, 210, 210, 255),
   chart_color = nk.color_from_bytes(137, 182, 224, 255),
   chart_color_highlight = nk.color_from_bytes( 255, 0, 0, 255),
   scrollbar = nk.color_from_bytes(190, 200, 200, 255),
   scrollbar_cursor = nk.color_from_bytes(64, 84, 95, 255),
   scrollbar_cursor_hover = nk.color_from_bytes(70, 90, 100, 255),
   scrollbar_cursor_active = nk.color_from_bytes(75, 95, 105, 255),
   tab_header = nk.color_from_bytes(156, 193, 220, 255),
}
 
colortable.dark = {
   text = nk.color_from_bytes(210, 210, 210, 255),
   window = nk.color_from_bytes(57, 67, 71, 215),
   header = nk.color_from_bytes(51, 51, 56, 220),
   border = nk.color_from_bytes(46, 46, 46, 255),
   button = nk.color_from_bytes(48, 83, 111, 255),
   button_hover = nk.color_from_bytes(58, 93, 121, 255),
   button_active = nk.color_from_bytes(63, 98, 126, 255),
   toggle = nk.color_from_bytes(50, 58, 61, 255),
   toggle_hover = nk.color_from_bytes(45, 53, 56, 255),
   toggle_cursor = nk.color_from_bytes(48, 83, 111, 255),
   select = nk.color_from_bytes(57, 67, 61, 255),
   select_active = nk.color_from_bytes(48, 83, 111, 255),
   slider = nk.color_from_bytes(50, 58, 61, 255),
   slider_cursor = nk.color_from_bytes(48, 83, 111, 245),
   slider_cursor_hover = nk.color_from_bytes(53, 88, 116, 255),
   slider_cursor_active = nk.color_from_bytes(58, 93, 121, 255),
   property = nk.color_from_bytes(50, 58, 61, 255),
   edit = nk.color_from_bytes(50, 58, 61, 225),
   edit_cursor = nk.color_from_bytes(210, 210, 210, 255),
   combo = nk.color_from_bytes(50, 58, 61, 255),
   chart = nk.color_from_bytes(50, 58, 61, 255),
   chart_color = nk.color_from_bytes(48, 83, 111, 255),
   chart_color_highlight = nk.color_from_bytes(255, 0, 0, 255),
   scrollbar = nk.color_from_bytes(50, 58, 61, 255),
   scrollbar_cursor = nk.color_from_bytes(48, 83, 111, 255),
   scrollbar_cursor_hover = nk.color_from_bytes(53, 88, 116, 255),
   scrollbar_cursor_active = nk.color_from_bytes(58, 93, 121, 255),
   tab_header = nk.color_from_bytes(48, 83, 111, 255),
}

-- popups 
local show_manual_seed = false

-------------------------------------------------------------------------------
-- Menubar
-------------------------------------------------------------------------------

local menu1 = { prog=40, slider=10, check=true }
local menuwidgets = { prog = 60 }
local show_menu = true

local function Menubar(ctx)
   nk.menubar_begin(ctx)
   -- menu #1 -------------------------------------
   nk.layout_row_begin(ctx, 'static', 25, 5)
   nk.layout_row_push(ctx, 45)
   if nk.menu_begin(ctx, nil, "MENU", nk.TEXT_LEFT, {120, 200}) then
      nk.layout_row_dynamic(ctx, 25, 1)
      if nk.menu_item(ctx, nil, "Hide", nk.TEXT_LEFT) then show_menu = false end
      if nk.menu_item(ctx, nil, "About", nk.TEXT_LEFT) then show_manual_seed = true end
      menu1.prog = nk.progress(ctx, menu1.prog, 100, 'modifiable')
      menu1.slider = nk.slider(ctx, 0, menu1.slider, 16, 1)
      menu1.check = nk.checkbox(ctx, "check", menu1.check)
      nk.menu_end(ctx)
   end
   -- menu widgets ------------------------------
   nk.layout_row_push(ctx, 70)
   menuwidgets.prog = nk.progress(ctx, menuwidgets.prog, 100, 'modifiable')
   ----------------------------------------------
   nk.menubar_end(ctx)
end 

-------------------------------------------------------------------------------
-- Popup
-------------------------------------------------------------------------------

local input = 
{
   submit = "",
   flags = 0
}

local function ManualSeed(ctx, w, h)
   if nk.popup_begin(ctx, 'dynamic', _("New Seed"), nk.WINDOW_CLOSABLE, {w/2-140, h/2-60, 280, 120}) then
      nk.layout_row_dynamic(ctx, 25, 1)
      input.submit, input.flags = 
         nk.edit_string(ctx, nk.EDIT_FIELD|nk.EDIT_SIG_ENTER, input.submit, 64,  'default')
      if nk.button(ctx, nil, "Submit") or (input.flags & nk.EDIT_COMMITED ~= 0) then
         gui.calc_seed(input.submit)
         input.submit = ""
      end
      nk.popup_end(ctx)
   else 
      show_manual_seed = false
   end
end

-------------------------------------------------------------------------------

local ratio = {120, 150}

local current_tab = "build"

local module_categories = 
{
   "build", "arch", "combat", "pickup", "other", "experimental", "debug", "options"
}

local module_category_labels = 
{
   ["build"] = _("Build"),
   ["arch"] = _("Architecture"),
   ["combat"] = _("Combat"),
   ["pickup"] = _("Pickups"),
   ["other"] = _("Other"),
   ["debug"] = _("Debug"),
   ["experimental"] = _("Experimental"),
   ["options"] = _("Options")
}

function ob_gui_frame(width, height)
   if OB_NK_CTX == nil then return "quit" end

   nk.style_from_table(OB_NK_CTX, colortable["red"])

   if nk.window_begin(OB_NK_CTX, "OBSIDIAN Level Maker", {0, 0, width, height}, 0) then
      --if show_menu then Menubar(OB_NK_CTX) end
      if show_manual_seed then ManualSeed(OB_NK_CTX, width, height) end
      -- Header 
      nk.style_push_vec2(OB_NK_CTX, "window.spacing", {0,0})
      local f = bold_font
      nk.style_set_font(OB_NK_CTX, bold_font)
      nk.layout_row_dynamic(OB_NK_CTX, (f:height() * font_scale), #module_categories)
      for _, name in ipairs(module_categories) do
         -- make sure button perfectly fits text 
         local text_width = f:width(f:height() * font_scale, module_category_labels[name]) * font_scale
         local widget_width = text_width + 3 * nk.style_get_vec2(OB_NK_CTX, "button.padding")[1]
         if current_tab == name then
            -- active tab gets highlighted 
            local button_color = nk.style_get_style_item(OB_NK_CTX, "button.normal")
            local act = nk.style_get_style_item(OB_NK_CTX, "button.active")
            nk.style_set_style_item(OB_NK_CTX, "button.normal", nk.style_get_style_item(OB_NK_CTX, "button.active"))
            current_tab = nk.button(OB_NK_CTX, nil, module_category_labels[name]) and name or current_tab
            nk.style_set_style_item(OB_NK_CTX, "button.normal", button_color)
         else 
            current_tab = nk.button(OB_NK_CTX, nil, module_category_labels[name]) and name or current_tab
         end
      end
      nk.style_pop_vec2(OB_NK_CTX)
      -- Body
      nk.layout_row_dynamic(OB_NK_CTX, height - (f:height() * font_scale) - 75, 1)
      f = normal_font
      nk.style_set_font(OB_NK_CTX, normal_font)
      if nk.group_begin(OB_NK_CTX, "Notebook", nk.WINDOW_BORDER) then
         if current_tab == "build" then
            nk.layout_row_static(OB_NK_CTX, height/2, width/2, 1)
            if nk.button(OB_NK_CTX, nil, "BUILD") then
               gui.build_it()
            end
         elseif current_tab == "options" then
            -- TODO
         else
            for _,mod in pairs(OB_MODULES) do
               if mod.valid == true and mod.where == current_tab then
                  for _,opt in pairs(mod.options) do
                     nk.layout_row_static(OB_NK_CTX, 25, width/2, 2)
                     nk.label(OB_NK_CTX, opt.label, nk.TEXT_LEFT)
                     if opt.choices == YES_NO_CHOICES then
                        if nk.checkbox(OB_NK_CTX, "", opt.value == "yes") then
                           opt.value = "yes"
                           OB_CONFIG[opt.name] = "yes"
                        else
                           opt.value = "no"
                           OB_CONFIG[opt.name] = "no"
                        end
                     else
                        opt.choice_selection = nk.combo(OB_NK_CTX, opt.avail_labels, opt.choice_selection, 25, {200,200})
                        opt.value = opt.avail_choices[opt.choice_selection]
                        OB_CONFIG[opt.name] = opt.value
                     end
                  end
               end
            end
         end
         nk.group_end(OB_NK_CTX)
      end
      nk.layout_row_dynamic(OB_NK_CTX, 25, 3)
      nk.label(OB_NK_CTX, "Seed: " .. OB_CONFIG.seed, nk.TEXT_LEFT)
      if nk.button(OB_NK_CTX, nil, "New Random Seed") then
         gui.calc_seed(ob_get_random_words())
      end
      if nk.button(OB_NK_CTX, nil, "Enter Seed") then
         show_manual_seed = true
      end
      nk.layout_row_dynamic(OB_NK_CTX, 25, 1)
      nk.label(OB_NK_CTX, "Status: " .. OB_BUILD_STATUS, nk.TEXT_LEFT)
   end
   nk.window_end(OB_NK_CTX)
   return "ok"
end