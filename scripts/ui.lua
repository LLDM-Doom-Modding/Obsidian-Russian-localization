------------------------------------------------------------------------
--  OBSIDIAN  :  NUKLEAR UI
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

local font_scale

local UI_GUI_THEMES =
{
   ["default"] =
   {
      label = _("Default"),
      normal_font_file = "SourceSansPro-Regular.ttf",
      normal_font_size = 24,
      bold_font_file = "SourceSansPro-Bold.ttf",
      bold_font_size = 24,
      icon_font_file = "bootstrap-icons.ttf",
      icon_font_size = 24,
      colortable = 
      {
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
         edit = nk.color_from_bytes(51, 55, 67, 225),
         edit_cursor = nk.color_from_bytes(190, 190, 190, 255),
         combo = nk.color_from_bytes(51, 55, 67, 255),
         scrollbar = nk.color_from_bytes(30, 33, 40, 255),
         scrollbar_cursor = nk.color_from_bytes(64, 84, 95, 255),
         scrollbar_cursor_hover = nk.color_from_bytes(70, 90, 100, 255),
         scrollbar_cursor_active = nk.color_from_bytes(75, 95, 105, 255),
         tab_header = nk.color_from_bytes(181, 45, 69, 220),
      }
   }
}

local current_gui_theme = UI_GUI_THEMES["default"]

function ob_gui_init_themes(scale)
  if OB_NK_CTX == nil then return "bork" end
  if OB_NK_ATLAS == nil then return "bork" end
  assert(UI_GUI_THEMES and UI_GUI_THEMES["default"])
  for _,theme in pairs(UI_GUI_THEMES) do
   assert(theme.normal_font_file and theme.normal_font_size and theme.bold_font_file and theme.bold_font_size and theme.icon_font_file and theme.icon_font_size) 
   theme.normal_font = OB_NK_ATLAS:add(theme.normal_font_size * scale, "data/fonts/" .. theme.normal_font_file)
   theme.normal_font:set_height(theme.normal_font_size)
   if (theme.bold_font_file ~= theme.normal_font_file or theme.bold_font_size ~= theme.normal_font_size) then
      theme.bold_font = OB_NK_ATLAS:add(theme.bold_font_size * scale, "data/fonts/" .. theme.bold_font_file)
      theme.bold_font:set_height(theme.bold_font_size)
   else
      theme.bold_font = theme.normal_font
   end
   theme.icon_font = OB_NK_ATLAS:add(theme.icon_font_size * scale, "data/fonts/" .. theme.icon_font_file)
  end
  nk.style_set_font(OB_NK_CTX, UI_GUI_THEMES["default"].normal_font)
  font_scale = scale
  return "groovy"
end

-------------------------------------------------------------------------------
-- Manual Entry
-------------------------------------------------------------------------------

local manual_entry_context = nil

local manual_input = 
{
   submit = "",
   flags = 0
}

local function ManualEntry(ctx, w, h)
   local popup_label = ""

   if manual_entry_context == "seed" then
      popup_label = _("Enter Seed")
   elseif manual_entry_context == "filename" then
      popup_label = _("Enter Filename")
   elseif manual_entry_context == "path" then
      popup_label = _("Enter Path")
   end

   if nk.popup_begin(ctx, 'dynamic', popup_label, nk.WINDOW_CLOSABLE, {w/2-140, h/2-60, 280, 120}) then
      nk.layout_row_dynamic(ctx, 25, 1)
      manual_input.submit, manual_input.flags = 
         nk.edit_string(ctx, nk.EDIT_FIELD|nk.EDIT_SIG_ENTER, manual_input.submit, 64,  'default')
      if nk.button(ctx, nil, _("Submit")) or (manual_input.flags & nk.EDIT_COMMITED ~= 0) then
         if manual_entry_context == "seed" then
           gui.calc_seed(manual_input.submit)
         elseif manual_entry_context == "filename" and manual_input.submit ~= "" then
            OB_CONFIG.output_filename = manual_input.submit
         elseif manual_entry_context == "path" and manual_input.submit ~= "" then
            if gui.is_directory(manual_input.submit) then
              OB_CONFIG.output_path = manual_input.submit
            end
         end
         manual_input.submit = ""
      end
      nk.popup_end(ctx)
   else 
      manual_entry_context = nil
   end
end

-------------------------------------------------------------------------------
-- Path Picker
-------------------------------------------------------------------------------

local show_path_picker = false

local function PathPicker(ctx, w, h)
   if nk.popup_begin(ctx, 'dynamic', _("Select Directory"), nk.WINDOW_CLOSABLE, {w/2-w*3/8, h/2-h*3/8, w*3/4, h*3/4}) then
      local subdirs = gui.directory_list(OB_CONFIG.output_path)
      table.sort(subdirs)
      for _,dir in ipairs(subdirs) do
         nk.layout_row_begin(ctx, 'dynamic', 25, 2)
         nk.layout_row_push(ctx, 0.1)
         nk.style_set_font(ctx, current_gui_theme.icon_font)
         nk.label(ctx, "F", nk.TEXT_RIGHT)
         nk.layout_row_push(ctx, 0.2)
         nk.style_set_font(ctx, current_gui_theme.normal_font)
         nk.label(ctx, dir, nk.TEXT_LEFT)
         nk.layout_row_end(ctx)
      end
      nk.layout_row_dynamic(ctx, 25, 1)
      if nk.button(ctx, nil, _("Submit")) then
         show_path_picker = false
      end
      nk.popup_end(ctx)
   else 
      show_path_picker = false
   end
end

-------------------------------------------------------------------------------
-- Main Program Window
-------------------------------------------------------------------------------

-- menuwidgets.prog = nk.progress(ctx, menuwidgets.prog, 100, 'modifiable')

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

   nk.style_from_table(OB_NK_CTX, current_gui_theme.colortable)

   local window_flags = 0

   local need_update_all = false

   if OB_BUILD_ROUTINE ~= nil then
      local status = coroutine.status(OB_BUILD_ROUTINE)
      if status == "dead" then
         OB_BUILD_ROUTINE = nil
      elseif status == "suspended" then
         window_flags = nk.WINDOW_NO_INPUT
         coroutine.resume(OB_BUILD_ROUTINE)
      end
   end

   if nk.window_begin(OB_NK_CTX, "OBSIDIAN Level Maker", {0, 0, width, height}, window_flags) then
      if show_path_picker == true then PathPicker(OB_NK_CTX, width, height) end
      if manual_entry_context ~= nil then ManualEntry(OB_NK_CTX, width, height) end
      -- Header 
      nk.style_push_vec2(OB_NK_CTX, "window.spacing", {0,0})
      local f = current_gui_theme.bold_font
      nk.style_set_font(OB_NK_CTX, f)
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
      f = current_gui_theme.normal_font
      nk.style_set_font(OB_NK_CTX, f)
      if nk.group_begin(OB_NK_CTX, "Notebook", nk.WINDOW_BORDER) then
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
                     if opt.name == "game" or opt.name == "port" then
                        if OB_CONFIG[opt.name] ~= opt.value then
                           need_update_all = true
                        end
                     end
                     OB_CONFIG[opt.name] = opt.value
                  end
               end
            end
         end
         if current_tab == "build" then
            nk.layout_row_dynamic(OB_NK_CTX, 25, 1)
            nk.layout_row_dynamic(OB_NK_CTX, 25, 3)
            nk.label(OB_NK_CTX, "Output Path: " .. OB_CONFIG.output_path, nk.TEXT_LEFT)
            if nk.button(OB_NK_CTX, nil, _("Select New Path")) then
               show_path_picker = true
            end
            if nk.button(OB_NK_CTX, nil, _("Enter Path")) then
               manual_entry_context = "path"
            end
            nk.layout_row_dynamic(OB_NK_CTX, 25, 3)
            if OB_CONFIG.compress_output == "yes" then
               nk.label(OB_NK_CTX, "Output Filename: " .. OB_CONFIG.output_filename .. ".zip", nk.TEXT_LEFT)
            else
               nk.label(OB_NK_CTX, "Output Filename: " .. OB_CONFIG.output_filename .. ".wad", nk.TEXT_LEFT)
            end
            if nk.button(OB_NK_CTX, nil, _("Generate New Filename")) then
               OB_CONFIG.output_filename = ob_default_filename()
            end
            if nk.button(OB_NK_CTX, nil, _("Enter Filename")) then
               manual_entry_context = "filename"
            end
            nk.layout_row_static(OB_NK_CTX, 25, width/2, 1)
            if nk.button(OB_NK_CTX, nil, _("BUILD")) then
               if OB_BUILD_ROUTINE == nil then
                  ob_do_build()
               end
            end
            -- seed grid test - Dasho
            nk.layout_row_dynamic(OB_NK_CTX, 50, 2)
            local canvas = nk.window_get_canvas(OB_NK_CTX)
            local rect = nk.widget_bounds(OB_NK_CTX)
            nk.widget(OB_NK_CTX, rect)
            local rgb = nk.color_from_bytes
            canvas:fill_rect({rect[1]+1,rect[2]+1,rect[3]-2,rect[3]-2}, 5, rgb(0, 0, 0))
            local inc = (rect[3]-2) / 50
            for i = rect[1]+1, rect[1]+rect[3]-1, inc do
               canvas:stroke_line(i, rect[2]+1, i, rect[2]+rect[3]-1, 2.0, rgb(26, 26, 238))
            end
            inc = (rect[3]-2) / 50
            for i = rect[2]+1, rect[2]+rect[3]-1, inc do
               canvas:stroke_line(rect[1]+1, i, rect[1]+rect[3]-1, i, 2.0, rgb(26, 26, 238))
            end
         end
         nk.group_end(OB_NK_CTX)
      end
      nk.layout_row_dynamic(OB_NK_CTX, 25, 3)
      nk.label(OB_NK_CTX, _("Seed") .. ": " .. OB_CONFIG.seed, nk.TEXT_LEFT)
      if nk.button(OB_NK_CTX, nil, _("New Random Seed")) then
         gui.calc_seed(ob_get_random_phrase())
      end
      if nk.button(OB_NK_CTX, nil, _("Enter Seed")) then
         manual_entry_context = "seed"
      end
      nk.layout_row_dynamic(OB_NK_CTX, 25, 1)
      nk.label(OB_NK_CTX, _("Status") .. ": " .. OB_BUILD_STATUS, nk.TEXT_LEFT)
   end
   nk.window_end(OB_NK_CTX)
   if need_update_all then
      ob_update_all()
   end
   return "ok"
end