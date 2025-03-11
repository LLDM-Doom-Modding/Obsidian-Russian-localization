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

function ob_gui_init_fonts(font_scale)
  if OB_NK_CTX == nil then return "bork" end
  if OB_NK_ATLAS == nil then return "bork" end
  normal_font = OB_NK_ATLAS:add(24 * font_scale, "data/fonts/SourceSansPro/SourceSansPro-Regular.ttf")
  normal_font:set_height(24)
  bold_font = OB_NK_ATLAS:add(28 * font_scale, "data/fonts/SourceSansPro/SourceSansPro-Bold.ttf")
  bold_font:set_height(28)
  nk.style_set_font(OB_NK_CTX, normal_font)
  return "groovy"
end

local colortable = {}
local rgba = nk.color_from_bytes

colortable.white = {
   text = rgba(70, 70, 70, 255),
   window = rgba(175, 175, 175, 255),
   header = rgba(175, 175, 175, 255),
   border = rgba(0, 0, 0, 255),
   button = rgba(185, 185, 185, 255),
   button_hover = rgba(170, 170, 170, 255),
   button_active = rgba(160, 160, 160, 255),
   toggle = rgba(150, 150, 150, 255),
   toggle_hover = rgba(120, 120, 120, 255),
   toggle_cursor = rgba(175, 175, 175, 255),
   select = rgba(190, 190, 190, 255),
   select_active = rgba(175, 175, 175, 255),
   slider = rgba(190, 190, 190, 255),
   slider_cursor = rgba(80, 80, 80, 255),
   slider_cursor_hover = rgba(70, 70, 70, 255),
   slider_cursor_active = rgba(60, 60, 60, 255),
   property = rgba(175, 175, 175, 255),
   edit = rgba(150, 150, 150, 255),
   edit_cursor = rgba(0, 0, 0, 255),
   combo = rgba(175, 175, 175, 255),
   chart = rgba(160, 160, 160, 255),
   chart_color = rgba(45, 45, 45, 255),
   chart_color_highlight = rgba( 255, 0, 0, 255),
   scrollbar = rgba(180, 180, 180, 255),
   scrollbar_cursor = rgba(140, 140, 140, 255),
   scrollbar_cursor_hover = rgba(150, 150, 150, 255),
   scrollbar_cursor_active = rgba(160, 160, 160, 255),
   tab_header = rgba(180, 180, 180, 255),
}

colortable.red = {
   text = rgba(190, 190, 190, 255),
   window = rgba(30, 33, 40, 215),
   header = rgba(181, 45, 69, 220),
   border = rgba(51, 55, 67, 255),
   button = rgba(181, 45, 69, 255),
   button_hover = rgba(190, 50, 70, 255),
   button_active = rgba(195, 55, 75, 255),
   toggle = rgba(51, 55, 67, 255),
   toggle_hover = rgba(45, 60, 60, 255),
   toggle_cursor = rgba(181, 45, 69, 255),
   select = rgba(51, 55, 67, 255),
   select_active = rgba(181, 45, 69, 255),
   slider = rgba(51, 55, 67, 255),
   slider_cursor = rgba(181, 45, 69, 255),
   slider_cursor_hover = rgba(186, 50, 74, 255),
   slider_cursor_active = rgba(191, 55, 79, 255),
   property = rgba(51, 55, 67, 255),
   edit = rgba(51, 55, 67, 225),
   edit_cursor = rgba(190, 190, 190, 255),
   combo = rgba(51, 55, 67, 255),
   chart = rgba(51, 55, 67, 255),
   chart_color = rgba(170, 40, 60, 255),
   chart_color_highlight = rgba( 255, 0, 0, 255),
   scrollbar = rgba(30, 33, 40, 255),
   scrollbar_cursor = rgba(64, 84, 95, 255),
   scrollbar_cursor_hover = rgba(70, 90, 100, 255),
   scrollbar_cursor_active = rgba(75, 95, 105, 255),
   tab_header = rgba(181, 45, 69, 220),
}

colortable.blue = {
   text = rgba(20, 20, 20, 255),
   window = rgba(202, 212, 214, 215),
   header = rgba(137, 182, 224, 220),
   border = rgba(140, 159, 173, 255),
   button = rgba(137, 182, 224, 255),
   button_hover = rgba(142, 187, 229, 255),
   button_active = rgba(147, 192, 234, 255),
   toggle = rgba(177, 210, 210, 255),
   toggle_hover = rgba(182, 215, 215, 255),
   toggle_cursor = rgba(137, 182, 224, 255),
   select = rgba(177, 210, 210, 255),
   select_active = rgba(137, 182, 224, 255),
   slider = rgba(177, 210, 210, 255),
   slider_cursor = rgba(137, 182, 224, 245),
   slider_cursor_hover = rgba(142, 188, 229, 255),
   slider_cursor_active = rgba(147, 193, 234, 255),
   property = rgba(210, 210, 210, 255),
   edit = rgba(210, 210, 210, 225),
   edit_cursor = rgba(20, 20, 20, 255),
   combo = rgba(210, 210, 210, 255),
   chart = rgba(210, 210, 210, 255),
   chart_color = rgba(137, 182, 224, 255),
   chart_color_highlight = rgba( 255, 0, 0, 255),
   scrollbar = rgba(190, 200, 200, 255),
   scrollbar_cursor = rgba(64, 84, 95, 255),
   scrollbar_cursor_hover = rgba(70, 90, 100, 255),
   scrollbar_cursor_active = rgba(75, 95, 105, 255),
   tab_header = rgba(156, 193, 220, 255),
}
 
colortable.dark = {
   text = rgba(210, 210, 210, 255),
   window = rgba(57, 67, 71, 215),
   header = rgba(51, 51, 56, 220),
   border = rgba(46, 46, 46, 255),
   button = rgba(48, 83, 111, 255),
   button_hover = rgba(58, 93, 121, 255),
   button_active = rgba(63, 98, 126, 255),
   toggle = rgba(50, 58, 61, 255),
   toggle_hover = rgba(45, 53, 56, 255),
   toggle_cursor = rgba(48, 83, 111, 255),
   select = rgba(57, 67, 61, 255),
   select_active = rgba(48, 83, 111, 255),
   slider = rgba(50, 58, 61, 255),
   slider_cursor = rgba(48, 83, 111, 245),
   slider_cursor_hover = rgba(53, 88, 116, 255),
   slider_cursor_active = rgba(58, 93, 121, 255),
   property = rgba(50, 58, 61, 255),
   edit = rgba(50, 58, 61, 225),
   edit_cursor = rgba(210, 210, 210, 255),
   combo = rgba(50, 58, 61, 255),
   chart = rgba(50, 58, 61, 255),
   chart_color = rgba(48, 83, 111, 255),
   chart_color_highlight = rgba(255, 0, 0, 255),
   scrollbar = rgba(50, 58, 61, 255),
   scrollbar_cursor = rgba(48, 83, 111, 255),
   scrollbar_cursor_hover = rgba(53, 88, 116, 255),
   scrollbar_cursor_active = rgba(58, 93, 121, 255),
   tab_header = rgba(48, 83, 111, 255),
}

-- window flags 
local window_flags = 0
local show_menu = true
local titlebar = true
local border = true
local resize = true
local movable = true
local no_scrollbar = false
local scale_left = false
local minimizable = true

-- popups 
local show_app_about = false

local LEFT, CENTERED, RIGHT  = nk.TEXT_LEFT, nk.TEXT_CENTERED, nk.TEXT_RIGHT
local fmt = function(...) return string.format(...) end
local floor, abs = math.floor, math.abs
local cos, sin = math.cos, math.sin

local STEP = 2*math.pi/32

-------------------------------------------------------------------------------
-- Menubar
-------------------------------------------------------------------------------

local menu1 = { prog=40, slider=10, check=true }
local menu2 = { state='NONE', values={26.0,13.0,30.0,15.0,25.0,10.0,20.0,40.0,12.0,8.0,22.0,28.0} }
local menuwidgets = { prog = 60, slider = 10, check = true }

local function Menubar(ctx)
   nk.menubar_begin(ctx)
   local state = menu2.state
   -- menu #1 -------------------------------------
   nk.layout_row_begin(ctx, 'static', 25, 5)
   nk.layout_row_push(ctx, 45)
   if nk.menu_begin(ctx, nil, "MENU", LEFT, {120, 200}) then
      nk.layout_row_dynamic(ctx, 25, 1)
      if nk.menu_item(ctx, nil, "Hide", LEFT) then show_menu = false end
      if nk.menu_item(ctx, nil, "About", LEFT) then show_app_about = true end
      menu1.prog = nk.progress(ctx, menu1.prog, 100, 'modifiable')
      menu1.slider = nk.slider(ctx, 0, menu1.slider, 16, 1)
      menu1.check = nk.checkbox(ctx, "check", menu1.check)
      nk.menu_end(ctx)
   end
   -- menu widgets ------------------------------
   nk.layout_row_push(ctx, 70)
   menuwidgets.prog = nk.progress(ctx, menuwidgets.prog, 100, 'modifiable')
   ----------------------------------------------
   menu2.state = state
   nk.menubar_end(ctx)
end 

-------------------------------------------------------------------------------
-- Popup
-------------------------------------------------------------------------------

local function About(ctx)
   if nk.popup_begin(ctx, 'static', "About", nk.WINDOW_CLOSABLE, {20, 100, 300, 190}) then
      nk.layout_row_dynamic(ctx, 20, 1)
      nk.label(ctx, "Nuklear", LEFT)
      nk.label(ctx, "By Micha Mettke", LEFT)
      nk.label(ctx, "nuklear is licensed under the",  LEFT)
      nk.label(ctx, "public domain License.",  LEFT)
      nk.popup_end(ctx)
   else 
      show_app_about = false
   end
end

-------------------------------------------------

local input = {
   text = {"", "", "", "", "", ""},
   password = "",
   field = "",
   box = "",
   submit = "",
   flags = 0,
}

local function Input(ctx)
   if nk.tree_push(ctx, 'node', "Input", 'minimized', 'input') then
      local ratio = {120, 150}
      nk.layout_row(ctx, 'static', 25, ratio)
      nk.label(ctx, "Default:", LEFT)
      input.text[1] = nk.edit_string(ctx, nk.EDIT_SIMPLE, input.text[1], 64, 'default')
      nk.label(ctx, "Int:", LEFT)
      input.text[2] = nk.edit_string(ctx, nk.EDIT_SIMPLE, input.text[2], 64, 'decimal')
      nk.label(ctx, "Float:", LEFT)
      input.text[3] = nk.edit_string(ctx, nk.EDIT_SIMPLE, input.text[3], 64, 'float')
      nk.label(ctx, "Hex:", LEFT)
      input.text[4] = nk.edit_string(ctx, nk.EDIT_SIMPLE, input.text[4], 64, 'hex')
      nk.label(ctx, "Octal:", LEFT)
      input.text[5] = nk.edit_string(ctx, nk.EDIT_SIMPLE, input.text[5], 64, 'oct')
      nk.label(ctx, "Binary:", LEFT)
      input.text[6] = nk.edit_string(ctx, nk.EDIT_SIMPLE, input.text[6], 64, 'binary')
      nk.label(ctx, "Password:", LEFT) --@@ rivedere
      local mask = string.rep('*', #input.password)
      input.password = nk.edit_string(ctx, nk.EDIT_FIELD, mask, 64, 'default')
--    nk.label(ctx, "Password: "..input.password, LEFT)
      nk.label(ctx, "Field:", LEFT)
      input.field = nk.edit_string(ctx, nk.EDIT_FIELD, input.field, 64, 'default')
      nk.label(ctx, "Box:", LEFT)
      nk.layout_row_static(ctx, 180, 278, 1)
      input.box = nk.edit_string(ctx, nk.EDIT_BOX, input.box, 512, 'default')
      nk.layout_row(ctx, 'static', 25, ratio)
      input.submit, input.flags = 
         nk.edit_string(ctx, nk.EDIT_FIELD|nk.EDIT_SIG_ENTER, input.submit, 64,  'decimal')
      if nk.button(ctx, nil, "Submit") or (input.flags & nk.EDIT_COMMITED ~= 0) then
         OB_CONFIG.seed = tonumber(input.submit)
         input.submit = ""
      end
      nk.tree_pop(ctx)
   end
end

-------------------------------------------------------------------------------


local chart = {
   line_index = 0,
   col_index = 0,
}

local function Chart(ctx)
-- Chart Widgets
-- This library has two different rather simple charts. The line and the column chart.
-- Both provide a simple way of visualizing values and have a retained mode and immediate
-- mode API version. For the retain mode version `nk.plot` and `nk.plot_function` you
-- either provide an array or a callback to call to handle drawing the graph.
-- For the immediate mode version you start by calling `nk.chart_begin` and need to
-- provide min and max values for scaling on the Y-axis and then call `nk.chart_push`
-- to push values into the chart.
-- Finally `nk.chart_end` needs to be called to end the process. 
   if nk.tree_push(ctx, 'tab', "Chart", 'minimized', "widgets chart") then
      -- line chart ---------------------------------------
      local id, index = 0, 0
      nk.layout_row_dynamic(ctx, 100, 1)
      local bounds = nk.widget_bounds(ctx)
      if nk.chart_begin(ctx, 'lines', 32, -1.0, 1.0) then
         for i = 1, 32 do
            local res = nk.chart_push(ctx, cos(id))
            if res & nk.CHART_HOVERING ~= 0 then index = i end
            if res & nk.CHART_CLICKED ~= 0 then chart.line_index = i end
            id = id + STEP
         end
         nk.chart_end(ctx)
      end
      if index ~= 0 then nk.tooltip(ctx, fmt("Value: %.2f", cos((index-1)*STEP))) end
      if chart.line_index ~= 0 then
         nk.layout_row_dynamic(ctx, 20, 1)
         nk.label(ctx, fmt("Selected value: %.2f", cos((index-1)*STEP)), LEFT)
      end
      -- column chart -------------------------------------
      id, index = 0, 0
      nk.layout_row_dynamic(ctx, 100, 1)
      bounds = nk.widget_bounds(ctx)
      if nk.chart_begin(ctx, 'column', 32, 0.0, 1.0) then
         for i = 1, 32 do
            local res = nk.chart_push(ctx, abs(sin(id)))
            if res & nk.CHART_HOVERING ~= 0 then index = i end
            if res & nk.CHART_CLICKED ~= 0 then chart.col_index = i end
            id = id + STEP
         end
         nk.chart_end(ctx)
      end
      if index ~= 0 then nk.tooltip(ctx, fmt("Value: %.2f", abs(sin(STEP*(index-1))))) end
      if chart.col_index ~= 0 then
         nk.layout_row_dynamic(ctx, 20, 1)
         nk.label(ctx, fmt("Selected value: %.2f", abs(sin(STEP*(chart.col_index-1)))), LEFT)
      end
      -- mixed chart --------------------------------------
      nk.layout_row_dynamic(ctx, 100, 1)
      bounds = nk.widget_bounds(ctx)
      if nk.chart_begin(ctx, 'column', 32, 0.0, 1.0) then -- slot 1
         nk.chart_add_slot(ctx, 'lines', 32, -1.0, 1.0)   -- slot 2
         nk.chart_add_slot(ctx, 'lines', 32, -1.0, 1.0)   -- slot 3
         id = 0
         for i = 1, 32 do
            nk.chart_push(ctx, abs(sin(id)), 1) 
            nk.chart_push(ctx, cos(id), 2)
            nk.chart_push(ctx, sin(id), 3)
            id = id + STEP
         end
      end
      nk.chart_end(ctx)
      -- mixed colored chart ------------------------------
      nk.layout_row_dynamic(ctx, 100, 1)
      bounds = nk.widget_bounds(ctx)
      if nk.chart_begin(ctx, 'lines', 32, 0.0, 1.0, {1,0,0}, {150/255,0,0}) then   -- slot 1
         nk.chart_add_slot(ctx, 'lines',32, -1.0, 1.0, {0, 0, 1}, {0, 0, 150/255}) -- slot 2
         nk.chart_add_slot(ctx, 'lines', 32, -1.0, 1.0, {0,1,0}, {0,150/255,0})    -- slot 3
         id = 0
         for i = 1, 32 do
            nk.chart_push(ctx, abs(sin(id)), 1)
            nk.chart_push(ctx, cos(id), 2)
            nk.chart_push(ctx, sin(id), 3)
            id = id + STEP
         end
      end
      nk.chart_end(ctx)
      nk.tree_pop(ctx)
   end
end
 
-------------------------------------------------------------------------------

local popup = {
   color = {1, 0,0, 1},
   select = {false, false, false, false},
   active = false,
   prog = 40,
   slider = 10,
}

local function Popup(ctx) 
   if nk.tree_push(ctx, 'tab', "Popup", 'minimized', 'popup') then
      -- menu contextual ----------------------------------
      nk.layout_row_static(ctx, 30, 160, 1)
      local bounds = nk.widget_bounds(ctx)
      nk.label(ctx, "Right click me for menu", LEFT)
      if nk.contextual_begin(ctx, 0, {100, 300}, bounds) then
         nk.layout_row_dynamic(ctx, 25, 1)
         show_menu = nk.checkbox(ctx, "Menu", show_menu)
         popup.prog = nk.progress(ctx, popup.prog, 100, 'modifiable')
         popup.slider = nk.slider(ctx, 0, popup.slider, 16, 1)
         if nk.contextual_item(ctx, nil, "About", CENTERED) then  show_app_about = true end
         local sel = popup.select
         sel[1] = nk.selectable(ctx, nil, sel[1] and "Unselect" or "Select", LEFT, sel[1])
         sel[2] = nk.selectable(ctx, nil, sel[2] and "Unselect" or "Select", LEFT, sel[2])
         sel[3] = nk.selectable(ctx, nil, sel[3] and "Unselect" or "Select", LEFT, sel[3])
         sel[4] = nk.selectable(ctx, nil, sel[4] and "Unselect" or "Select", LEFT, sel[4])
         nk.contextual_end(ctx)
      end
      -- color contextual ---------------------------------
      nk.layout_row_begin(ctx, 'static', 30, 2)
      nk.layout_row_push(ctx, 120)
      nk.label(ctx, "Right Click here:", LEFT)
      nk.layout_row_push(ctx, 50)
      bounds = nk.widget_bounds(ctx)
      nk.button(ctx, popup.color)
      nk.layout_row_end(ctx)
      if nk.contextual_begin(ctx, 0, {350, 60}, bounds) then
         nk.layout_row_dynamic(ctx, 30, 4)
         local r, g, b, a = nk.color_bytes(popup.color)
         r = nk.property(ctx, "#r", 0, r, 255, 1, 1)
         g = nk.property(ctx, "#g", 0, g, 255, 1, 1)
         b = nk.property(ctx, "#b", 0, b, 255, 1, 1)
         a = nk.property(ctx, "#a", 0, a, 255, 1, 1)
         popup.color = nk.color_from_bytes(r,g,b,a)
         nk.contextual_end(ctx)
      end
      -- popup --------------------------------------------
      nk.layout_row_begin(ctx, 'static', 30, 2)
      nk.layout_row_push(ctx, 120)
      nk.label(ctx, "Popup:", LEFT)
      nk.layout_row_push(ctx, 50)
      if nk.button(ctx, nil, "Popup") then popup.active = true end
      nk.layout_row_end(ctx)
      if popup.active then
         if nk.popup_begin(ctx, 'static', "Error", 0, {20, 100, 220, 90}) then
            nk.layout_row_dynamic(ctx, 25, 1)
            nk.label(ctx, "A terrible error as occured", LEFT)
            nk.layout_row_dynamic(ctx, 25, 2)
            if nk.button(ctx, nil, "OK") then
               popup.active = false
               nk.popup_close(ctx)
            end
            if nk.button(ctx, nil, "Cancel") then
               popup.active = false
               nk.popup_close(ctx)
            end
            nk.popup_end(ctx)
         else 
            popup.active = false
         end
      end

      -- tooltip ------------------------------------------
      nk.layout_row_static(ctx, 30, 150, 1)
      bounds = nk.widget_bounds(ctx)
      nk.label(ctx, "Hover me for tooltip", LEFT)
      if ctx:is_mouse_hovering_rect(bounds) then
         nk.tooltip(ctx, "This is a tooltip")
      end

      nk.tree_pop(ctx)
   end
end


--------------------------------------------------------------------------------

local layout = {
   group_titlebar = false,
   group_border = true,
   group_no_scrollbar = false,
   group_width = 320,
   group_height = 200,
   group_selected = { false,false,false,false,false,false,false,false,
                false,false,false,false,false,false,false,false},
   current_tab = "Lines",
   tab_names = {"Lines", "Columns", "Mixed"},
   selected_left = {},
   selected_right_top = {},
   selected_right_center = {},
   selected_right_bottom = {},
   vertical = { a = 100, b = 100, c = 100 },
   horizontal = { a = 100, b = 100, c = 100 },
   root_selected = false,
   selected = { false,false,false,false,false,false,false,false },
   sel_nodes = { false,false,false,false },
}

local function Layout(ctx)
   if nk.tree_push(ctx, 'tab', "Layout", 'minimized', 'layout') then
      -----------------------------------------------------
      if nk.tree_push(ctx, 'node', "Widget", 'minimized', 'layout widget') then
         nk.layout_row_dynamic(ctx, 30, 1)
         nk.label(ctx, "Dynamic fixed column layout with generated position and size:", LEFT)
         nk.layout_row_dynamic(ctx, 30, 3)
         nk.button(ctx, nil, "button")
         nk.button(ctx, nil, "button")
         nk.button(ctx, nil, "button")

         nk.layout_row_dynamic(ctx, 30, 1)
         nk.label(ctx, "static fixed column layout with generated position and size:", LEFT)
         nk.layout_row_static(ctx, 30, 100, 3)
         nk.button(ctx, nil, "button")
         nk.button(ctx, nil, "button")
         nk.button(ctx, nil, "button")

         nk.layout_row_dynamic(ctx, 30, 1)
         nk.label(ctx, "Dynamic array-based custom column layout with generated position and custom size:",LEFT)
         nk.layout_row(ctx, 'dynamic', 30, {0.2, 0.6, 0.2})
         nk.button(ctx, nil, "button")
         nk.button(ctx, nil, "button")
         nk.button(ctx, nil, "button")

         nk.layout_row_dynamic(ctx, 30, 1)
         nk.label(ctx, "Static array-based custom column layout with generated position and custom size:",LEFT )
         nk.layout_row(ctx, 'static', 30, {100, 200, 50})
         nk.button(ctx, nil, "button")
         nk.button(ctx, nil, "button")
         nk.button(ctx, nil, "button")

         nk.layout_row_dynamic(ctx, 30, 1)
         nk.label(ctx, "Dynamic immediate mode custom column layout with generated position and custom size:",LEFT)
         nk.layout_row_begin(ctx, 'dynamic', 30, 3)
         nk.layout_row_push(ctx, 0.2)
         nk.button(ctx, nil, "button")
         nk.layout_row_push(ctx, 0.6)
         nk.button(ctx, nil, "button")
         nk.layout_row_push(ctx, 0.2)
         nk.button(ctx, nil, "button")
         nk.layout_row_end(ctx)

         nk.layout_row_dynamic(ctx, 30, 1)
         nk.label(ctx, "Static immediate mode custom column layout with generated position and custom size:", LEFT)
         nk.layout_row_begin(ctx, 'static', 30, 3)
         nk.layout_row_push(ctx, 100)
         nk.button(ctx, nil, "button")
         nk.layout_row_push(ctx, 200)
         nk.button(ctx, nil, "button")
         nk.layout_row_push(ctx, 50)
         nk.button(ctx, nil, "button")
         nk.layout_row_end(ctx)

         nk.layout_row_dynamic(ctx, 30, 1)
         nk.label(ctx, "Static free space with custom position and custom size:", LEFT)
         nk.layout_space_begin(ctx, 'static', 60, 4)
         nk.layout_space_push(ctx, {100, 0, 100, 30})
         nk.button(ctx, nil, "button")
         nk.layout_space_push(ctx, {0, 15, 100, 30})
         nk.button(ctx, nil, "button")
         nk.layout_space_push(ctx, {200, 15, 100, 30})
         nk.button(ctx, nil, "button")
         nk.layout_space_push(ctx, {100, 30, 100, 30})
         nk.button(ctx, nil, "button")
         nk.layout_space_end(ctx)

         nk.layout_row_dynamic(ctx, 30, 1)
         nk.label(ctx, "Row template:", LEFT)
         nk.layout_row_template_begin(ctx, 30)
         nk.layout_row_template_push_dynamic(ctx)
         nk.layout_row_template_push_variable(ctx, 80)
         nk.layout_row_template_push_static(ctx, 80)
         nk.layout_row_template_end(ctx)
         nk.button(ctx, nil, "button")
         nk.button(ctx, nil, "button")
         nk.button(ctx, nil, "button")
         nk.tree_pop(ctx)
      end

      -----------------------------------------------------
      if nk.tree_push(ctx, 'node', "Group", 'minimized', 'layout group') then
         local flags = 0
         if layout.group_border then flags = flags | nk.WINDOW_BORDER end
         if layout.group_no_scrollbar then flags = flags | nk.WINDOW_NO_SCROLLBAR end
         if layout.group_titlebar then flags = flags | nk.WINDOW_TITLE end
         nk.layout_row_dynamic(ctx, 30, 3)
         layout.group_titlebar =  nk.checkbox(ctx, "Titlebar", layout.group_titlebar)
         layout.group_border = nk.checkbox(ctx, "Border", layout.group_border)
         layout.group_no_scrollbar = nk.checkbox(ctx, "No Scrollbar", layout.group_no_scrollbar)
         nk.layout_row_begin(ctx, 'static', 22, 3)
         nk.layout_row_push(ctx, 50)
         nk.label(ctx, "size:", LEFT)
         nk.layout_row_push(ctx, 130)
         layout.group_width = nk.property(ctx, "#Width:", 100, layout.group_width, 500, 10, 1)
         nk.layout_row_push(ctx, 130)
         layout.group_height = nk.property(ctx, "#Height:", 100, layout.group_height, 500, 10, 1)
         nk.layout_row_end(ctx)

         nk.layout_row_static(ctx, layout.group_height, layout.group_width, 2)
         if nk.group_begin(ctx, "Group", flags) then
            nk.layout_row_static(ctx, 18, 100, 1)
            local sel = layout.group_selected
            for i = 1,16 do
               sel[i] = nk.selectable(ctx, nil, sel[i] and "Selected" or "Unselected", CENTERED, sel[i])
            end
           nk.group_end(ctx)
         end
         nk.tree_pop(ctx)
      end
      -----------------------------------------------------
      if nk.tree_push(ctx, 'node', "Tree", 'minimized', 'layout tree') then
         local sel, ok = layout.root_selected, nil
         ok, sel = nk.tree_element_push(ctx, 'node', "Root", 'minimized', sel, "layout tree root")
         if ok then
            if sel ~= layout.root_selected then
               layout.root_selected = sel
               for i=1, 8 do layout.selected[i] = sel end
            end
            local sel = layout.selected[1]
            ok, sel = nk.tree_element_push(ctx, 'node', "Node", 'minimized', sel, "layout tree node")
            if ok then
               if sel ~= layout.selected[1] then
                  layout.selected[1] = sel
                  for i=1,4 do layout.sel_nodes[i] = sel end
               end
                  nk.layout_row_static(ctx, 18, 100, 1)
                  sel = layout.sel_nodes
                  for i=1,4 do
                     sel[i] = nk.selectable(ctx, 'circle solid', sel[i] and "Selected" or "Unselected", RIGHT, sel[i])
                  end
               nk.tree_element_pop(ctx)
            end
            nk.layout_row_static(ctx, 18, 100, 1)
            sel = layout.selected
            for i=1,8 do
               sel[i] = nk.selectable(ctx, 'circle solid', sel[i] and "Selected" or "Unselected", RIGHT, sel[i])
            end
            nk.tree_element_pop(ctx)
         end
         nk.tree_pop(ctx)
      end
      -----------------------------------------------------
      if nk.tree_push(ctx, 'node', "Notebook", 'minimized', 'layout notebook') then
         -- Header 
         nk.style_push_vec2(ctx, "window.spacing", {0,0})
         nk.style_push_float(ctx, "button.rounding", 0)
         nk.layout_row_begin(ctx, 'static', 20, 3)
         for _, name in ipairs(layout.tab_names) do
            local f = ctx:font()
            -- make sure button perfectly fits text 
            local text_width = f:width(f:height(), name)
            local widget_width = text_width + 3 * nk.style_get_vec2(ctx, "button.padding")[1]
            nk.layout_row_push(ctx, widget_width)
            if layout.current_tab == name then
               -- active tab gets highlighted 
               local button_color = nk.style_get_style_item(ctx, "button.normal")
               local act = nk.style_get_style_item(ctx, "button.active")
               nk.style_set_style_item(ctx, "button.normal", nk.style_get_style_item(ctx, "button.active"))
               layout.current_tab = nk.button(ctx, nil, name) and name or layout.current_tab
               nk.style_set_style_item(ctx, "button.normal", button_color)
            else 
               layout.current_tab = nk.button(ctx, nil, name) and name or layout.current_tab
            end
         end
         nk.style_pop_float(ctx)
         nk.style_pop_vec2(ctx)
         -- Body 
         nk.layout_row_dynamic(ctx, 140, 1)
         if nk.group_begin(ctx, "Notebook", nk.WINDOW_BORDER) then
            if layout.current_tab == "Lines" then
               nk.layout_row_dynamic(ctx, 100, 1)
               local bounds = nk.widget_bounds(ctx)
               if nk.chart_begin(ctx, 'lines', 32, 0.0, 1.0, {1, 0, 0}, {150/255, 0, 0}) then
                  nk.chart_add_slot(ctx, 'lines',32, -1.0, 1.0, {0, 0, 1}, {0, 0,150/255})
                  local id = 0
                  for i = 1, 32 do
                     nk.chart_push(ctx, abs(sin(id)), 1)
                     nk.chart_push(ctx, cos(id), 2)
                     id = id + STEP
                  end
               end 
               nk.chart_end(ctx)
            elseif layout.current_tab == "Columns" then
               nk.layout_row_dynamic(ctx, 100, 1)
               local bounds = nk.widget_bounds(ctx)
               if nk.chart_begin(ctx, 'column', 32, 0.0, 1.0, {1, 0, 0}, {150/255,0,0}) then
                  local id = 0
                  for i = 1, 32 do
                     nk.chart_push(ctx, abs(sin(id)), 1)
                     id = id + STEP
                  end
               end
               nk.chart_end(ctx)
            elseif layout.current_tab == "Mixed" then
               nk.layout_row_dynamic(ctx, 100, 1)
               local bounds = nk.widget_bounds(ctx)
               if nk.chart_begin(ctx, 'lines', 32, 0.0, 1.0, {1, 0, 0}, {150/255,0,0}) then
                  nk.chart_add_slot(ctx, 'lines',32, -1.0, 1.0, {0,0,1}, {0,0,150/255})
                  nk.chart_add_slot(ctx, 'column', 32, 0.0, 1.0, {0,1,0}, {0,150/255,0})
                  local id = 0
                  for i = 1, 32 do
                     nk.chart_push(ctx, abs(sin(id)), 1)
                     nk.chart_push(ctx, abs(cos(id)), 2)
                     nk.chart_push(ctx, abs(sin(id)), 3)
                     id = id + STEP
                  end
               end
               nk.chart_end(ctx)
            end
            nk.group_end(ctx)
         end
         nk.tree_pop(ctx)
      end
      -----------------------------------------------------
      if nk.tree_push(ctx, 'node', "Simple", 'minimized', 'layout simple') then
         nk.layout_row_dynamic(ctx, 300, 2)
         if nk.group_begin(ctx, "Group_Without_Border", 0) then
            nk.layout_row_static(ctx, 18, 150, 1)
            for i = 0, 63 do
               nk.label(ctx, fmt("0x%02x: scrollable region", i), LEFT)
            end
            nk.group_end(ctx)
         end
         if (nk.group_begin(ctx, "Group_With_Border", nk.WINDOW_BORDER)) then
            nk.layout_row_dynamic(ctx, 25, 2)
            for i = 0, 63 do
               --nk.button(ctx, nil, fmt("%08d", floor(((((i%7)*10)^32))+(64+(i%2)*2)))) @@
               nk.button(ctx, nil, fmt("%08d", 1<<i))
            end
            nk.group_end(ctx)
         end
         nk.tree_pop(ctx)
      end
      -----------------------------------------------------
      if nk.tree_push(ctx, 'node', "Complex", 'minimized', 'layout complex') then
         nk.layout_space_begin(ctx, 'static', 500, 64)
         nk.layout_space_push(ctx, {0,0,150,500})
         if nk.group_begin(ctx, "Group_left", nk.WINDOW_BORDER) then
            local sel = layout.selected_left
            nk.layout_row_static(ctx, 18, 100, 1)
            for i = 1, 32 do
               sel[i] = nk.selectable(ctx, nil, sel[i] and "Selected" or "Unselected", CENTERED, sel[i] or false)
            end
            nk.group_end(ctx)
         end
         nk.layout_space_push(ctx, {160,0,150,240})
         if nk.group_begin(ctx, "Group_top", nk.WINDOW_BORDER) then
            nk.layout_row_dynamic(ctx, 25, 1)
            nk.button(ctx, nil, "#FFAA")
            nk.button(ctx, nil, "#FFBB")
            nk.button(ctx, nil, "#FFCC")
            nk.button(ctx, nil, "#FFDD")
            nk.button(ctx, nil, "#FFEE")
            nk.button(ctx, nil, "#FFFF")
            nk.group_end(ctx)
         end
         nk.layout_space_push(ctx, {160,250,150,250})
         if nk.group_begin(ctx, "Group_buttom", nk.WINDOW_BORDER) then
            nk.layout_row_dynamic(ctx, 25, 1)
            nk.button(ctx, nil, "#FFAA")
            nk.button(ctx, nil, "#FFBB")
            nk.button(ctx, nil, "#FFCC")
            nk.button(ctx, nil, "#FFDD")
            nk.button(ctx, nil, "#FFEE")
            nk.button(ctx, nil, "#FFFF")
            nk.group_end(ctx)
         end 
         nk.layout_space_push(ctx, {320,0,150,150})
         if nk.group_begin(ctx, "Group_right_top", nk.WINDOW_BORDER)  then
            local sel = layout.selected_right_top
            nk.layout_row_static(ctx, 18, 100, 1)
            for i = 1, 4 do
               sel[i] = nk.selectable(ctx, nil, sel[i] and "Selected" or "Unselected", CENTERED, sel[i] or false)
            end
            nk.group_end(ctx)
         end
         nk.layout_space_push(ctx, {320,160,150,150})
         if nk.group_begin(ctx, "Group_right_center", nk.WINDOW_BORDER) then
            local sel = layout.selected_right_center
            nk.layout_row_static(ctx, 18, 100, 1)
            for i = 1, 4 do
               sel[i] = nk.selectable(ctx, nil, sel[i] and "Selected" or "Unselected", CENTERED, sel[i] or false)
            end
            nk.group_end(ctx)
         end
         nk.layout_space_push(ctx, {320,320,150,150})
         if nk.group_begin(ctx, "Group_right_bottom", nk.WINDOW_BORDER) then
            local sel = layout.selected_right_bottom
            nk.layout_row_static(ctx, 18, 100, 1)
            for i = 1, 4 do
               sel[i] = nk.selectable(ctx, nil, sel[i] and "Selected" or "Unselected", CENTERED, sel[i] or false)
            end
            nk.group_end(ctx)
         end
         nk.layout_space_end(ctx)
         nk.tree_pop(ctx)
      end
      -----------------------------------------------------
      if nk.tree_push(ctx, 'node', "Splitter", 'minimized', 'tree splitter') then
         nk.layout_row_static(ctx, 20, 320, 1)
         nk.label(ctx, "Use slider and spinner to change tile size", LEFT)
         nk.label(ctx, "Drag the space between tiles to change tile ratio", LEFT)
         if nk.tree_push(ctx, 'node', "Vertical", 'minimized', 'tree splitted vertical') then
            local vert = layout.vertical
            local row_layout = { vert.a, 8, vert.b, 8, vert.c }
            -- header 
            nk.layout_row_static(ctx, 30, 100, 2)
            nk.label(ctx, "left:", LEFT)
            vert.a = nk.slider(ctx, 10.0, vert.a, 200.0, 10.0)
            nk.label(ctx, "middle:", LEFT)
            vert.b = nk.slider(ctx, 10.0, vert.b, 200.0, 10.0)
            nk.label(ctx, "right:", LEFT)
            vert.c = nk.slider(ctx, 10.0, vert.c, 200.0, 10.0)
            -- tiles 
            nk.layout_row(ctx, 'static', 200, row_layout)
            -- left space 
            if nk.group_begin(ctx, "left", 
                     nk.WINDOW_NO_SCROLLBAR|nk.WINDOW_BORDER|nk.WINDOW_NO_SCROLLBAR) then
               nk.layout_row_dynamic(ctx, 25, 1)
               nk.button(ctx, nil, "#FFAA")
               nk.button(ctx, nil, "#FFBB")
               nk.button(ctx, nil, "#FFCC")
               nk.button(ctx, nil, "#FFDD")
               nk.button(ctx, nil, "#FFEE")
               nk.button(ctx, nil, "#FFFF")
               nk.group_end(ctx)
            end
            -- scaler 
            local bounds = nk.widget_bounds(ctx)
            nk.spacing(ctx, 1)
            if (ctx:is_mouse_hovering_rect(bounds) or ctx:is_mouse_prev_hovering_rect(bounds)) 
                  and ctx:is_mouse_down('left') then
               local dx = ctx:mouse_delta()
               vert.a = row_layout[1] + dx
               vert.b = row_layout[3] - dx
            end
            -- middle space 
            if nk.group_begin(ctx, "center", nk.WINDOW_BORDER|nk.WINDOW_NO_SCROLLBAR) then
               nk.layout_row_dynamic(ctx, 25, 1)
               nk.button(ctx, nil, "#FFAA")
               nk.button(ctx, nil, "#FFBB")
               nk.button(ctx, nil, "#FFCC")
               nk.button(ctx, nil, "#FFDD")
               nk.button(ctx, nil, "#FFEE")
               nk.button(ctx, nil, "#FFFF")
               nk.group_end(ctx)
            end
            -- scaler 
            local bounds = nk.widget_bounds(ctx)
            nk.spacing(ctx, 1)
            if (ctx:is_mouse_hovering_rect(bounds) or ctx:is_mouse_prev_hovering_rect(bounds)) 
                   and ctx:is_mouse_down('left') then
               local dx = ctx:mouse_delta()
               vert.b = row_layout[3] + dx
               vert.c = row_layout[5] - dx
            end
            -- right space 
            if nk.group_begin(ctx, "right", nk.WINDOW_BORDER|nk.WINDOW_NO_SCROLLBAR) then
               nk.layout_row_dynamic(ctx, 25, 1)
               nk.button(ctx, nil, "#FFAA")
               nk.button(ctx, nil, "#FFBB")
               nk.button(ctx, nil, "#FFCC")
               nk.button(ctx, nil, "#FFDD")
               nk.button(ctx, nil, "#FFEE")
               nk.button(ctx, nil, "#FFFF")
               nk.group_end(ctx)
            end
            nk.tree_pop(ctx)
         end
         if nk.tree_push(ctx, 'node', "Horizontal", 'minimized', 'widget tree horizontal') then
            local hor = layout.horizontal
            -- header 
            nk.layout_row_static(ctx, 30, 100, 2)
            nk.label(ctx, "top:", LEFT)
            hor.a = nk.slider(ctx, 10.0, hor.a, 200.0, 10.0)
            nk.label(ctx, "middle:", LEFT)
            hor.b = nk.slider(ctx, 10.0, hor.b, 200.0, 10.0)
            nk.label(ctx, "bottom:", LEFT)
            hor.c = nk.slider(ctx, 10.0, hor.c, 200.0, 10.0)
            -- top space 
            nk.layout_row_dynamic(ctx, hor.a, 1)
            if nk.group_begin(ctx, "top", nk.WINDOW_NO_SCROLLBAR|nk.WINDOW_BORDER) then
               nk.layout_row_dynamic(ctx, 25, 3)
               nk.button(ctx, nil, "#FFAA")
               nk.button(ctx, nil, "#FFBB")
               nk.button(ctx, nil, "#FFCC")
               nk.button(ctx, nil, "#FFDD")
               nk.button(ctx, nil, "#FFEE")
               nk.button(ctx, nil, "#FFFF")
               nk.group_end(ctx)
            end
            -- scaler 
            nk.layout_row_dynamic(ctx, 8, 1)
            local bounds = nk.widget_bounds(ctx)
            nk.spacing(ctx, 1)
            if (ctx:is_mouse_hovering_rect(bounds) or ctx:is_mouse_prev_hovering_rect(bounds))
                  and ctx:is_mouse_down('left') then
               local dx, dy = ctx:mouse_delta()
               hor.a = hor.a + dy
               hor.b = hor.b - dy
            end
            -- middle space 
            nk.layout_row_dynamic(ctx, hor.b, 1)
            if nk.group_begin(ctx, "middle", nk.WINDOW_NO_SCROLLBAR|nk.WINDOW_BORDER) then
               nk.layout_row_dynamic(ctx, 25, 3)
               nk.button(ctx, nil, "#FFAA")
               nk.button(ctx, nil, "#FFBB")
               nk.button(ctx, nil, "#FFCC")
               nk.button(ctx, nil, "#FFDD")
               nk.button(ctx, nil, "#FFEE")
               nk.button(ctx, nil, "#FFFF")
               nk.group_end(ctx)
            end
            -- scaler 
            nk.layout_row_dynamic(ctx, 8, 1)
            local bounds = nk.widget_bounds(ctx)
            if (ctx:is_mouse_hovering_rect(bounds) or ctx:is_mouse_prev_hovering_rect(bounds)) 
                  and ctx:is_mouse_down('left') then
               local dx, dy = ctx:mouse_delta()
               hor.b = hor.b + dy
               hor.c = hor.c - dy
            end
            -- bottom space 
            nk.layout_row_dynamic(ctx, hor.c, 1)
            if nk.group_begin(ctx, "bottom", nk.WINDOW_NO_SCROLLBAR|nk.WINDOW_BORDER) then
               nk.layout_row_dynamic(ctx, 25, 3)
               nk.button(ctx, nil, "#FFAA")
               nk.button(ctx, nil, "#FFBB")
               nk.button(ctx, nil, "#FFCC")
               nk.button(ctx, nil, "#FFDD")
               nk.button(ctx, nil, "#FFEE")
               nk.button(ctx, nil, "#FFFF")
               nk.group_end(ctx)
            end
            nk.tree_pop(ctx)
         end
         nk.tree_pop(ctx)
      end
   nk.tree_pop(ctx)
   end
end


-------------------------------------------------------------------------------

function ob_gui_frame(width, height)
   if OB_NK_CTX == nil then return "quit" end
   window_flags = 0
   nk.style_set_flags(OB_NK_CTX, "window.header.align", nk.HEADER_RIGHT)
   if border then window_flags = window_flags | nk.WINDOW_BORDER end
   if resize then window_flags = window_flags | nk.WINDOW_SCALABLE end
   if movable then window_flags = window_flags | nk.WINDOW_MOVABLE end
   if no_scrollbar then window_flags = window_flags | nk.WINDOW_NO_SCROLLBAR end
   if scale_left then window_flags = window_flags | nk.WINDOW_SCALE_LEFT end
   if minimizable then window_flags = window_flags | nk.WINDOW_MINIMIZABLE end

   nk.style_from_table(OB_NK_CTX, colortable["blue"])

   if nk.window_begin(OB_NK_CTX, OB_CONFIG.seed, {10, 10, width, height}, window_flags) then
      if show_menu then Menubar(OB_NK_CTX) end
      if show_app_about then About(OB_NK_CTX) end
      WindowFlagsCheckbox(OB_NK_CTX)
      if nk.tree_push(OB_NK_CTX,'tab', "Widgets", 'minimized', 'widgets tree') then
         Text(OB_NK_CTX)
         Buttons(OB_NK_CTX)
         Basic(OB_NK_CTX)
         Selectable(OB_NK_CTX)
         Combo(OB_NK_CTX)
         Input(OB_NK_CTX)
         nk.tree_pop(OB_NK_CTX)
      end
      Chart(OB_NK_CTX)
      Popup(OB_NK_CTX)
      Layout(OB_NK_CTX)
   end

   nk.window_end(OB_NK_CTX)
   return "ok"
end

-------------------------------------------------------------------------------


local ratio = {120, 150}

local current_tab = "arch"

local module_categories = 
{
   "arch", "combat", "pickup", "other", "experimental", "debug"
}

local module_category_labels = 
{
   ["arch"] = _("Architecture"),
   ["combat"] = _("Combat"),
   ["pickup"] = _("Pickups"),
   ["other"] = _("Miscellaneous"),
   ["debug"] = _("Debugging"),
   ["experimental"] = _("Experimental")   
}

function ob_gui_frame(width, height)
   if OB_NK_CTX == nil then return "quit" end

   nk.style_from_table(OB_NK_CTX, colortable["blue"])

   if nk.window_begin(OB_NK_CTX, "OBSIDIAN Level Maker", {0, 0, width, height}, 0) then
      if show_menu then Menubar(OB_NK_CTX) end
      if show_app_about then About(OB_NK_CTX) end
      nk.layout_row(OB_NK_CTX, 'static', 25, ratio)
      input.submit, input.flags = 
         nk.edit_string(OB_NK_CTX, nk.EDIT_FIELD|nk.EDIT_SIG_ENTER, input.submit, 64,  'decimal')
      if nk.button(OB_NK_CTX, nil, "Submit") or (input.flags & nk.EDIT_COMMITED ~= 0) then
         OB_CONFIG.seed = input.submit
         input.submit = ""
      end
      nk.label(OB_NK_CTX, OB_CONFIG.seed, nk.TEXT_LEFT)
      if nk.button(OB_NK_CTX, nil, "Build") then
         OB_NK_PICKED_FILE = nil
         gui.spawn_file_picker()
      end
      if OB_NK_PICKED_FILE ~= nil then
         nk.label(OB_NK_CTX, OB_NK_PICKED_FILE, nk.TEXT_LEFT)
      end
      -- Header 
      nk.style_push_vec2(OB_NK_CTX, "window.spacing", {0,0})
      nk.style_push_float(OB_NK_CTX, "button.rounding", 0)
      nk.layout_row_begin(OB_NK_CTX, 'static', 20, 6)
      for _, name in ipairs(module_categories) do
         local f = normal_font
         -- make sure button perfectly fits text 
         local text_width = f:width(f:height(), module_category_labels[name])
         local widget_width = text_width + 3 * nk.style_get_vec2(OB_NK_CTX, "button.padding")[1]
         nk.layout_row_push(OB_NK_CTX, widget_width)
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
      nk.style_pop_float(OB_NK_CTX)
      nk.style_pop_vec2(OB_NK_CTX)
      -- Body 
      nk.layout_row_dynamic(OB_NK_CTX, height - normal_font:height(), 1)
      if nk.group_begin(OB_NK_CTX, "Notebook", nk.WINDOW_BORDER) then
         for _,mod in pairs(OB_MODULES) do
            if mod.valid == true and mod.where == current_tab then
               for _,opt in pairs(mod.options) do
                  nk.layout_row_begin(OB_NK_CTX, 'static', 30, 2)
                  nk.layout_row_push(OB_NK_CTX, width)
                  nk.label(OB_NK_CTX, opt.label, nk.TEXT_LEFT)
                  nk.layout_row_end(OB_NK_CTX)
                  nk.layout_row_static(OB_NK_CTX, 25, 200, 1)
                  opt.choice_selection = nk.combo(OB_NK_CTX, opt.avail_labels, opt.choice_selection, 25, {200,200})
                  opt.value = opt.avail_choices[opt.choice_selection]
                  OB_CONFIG[opt.name] = opt.value
               end
            end
         end
         nk.group_end(OB_NK_CTX)
      end
   end

   nk.window_end(OB_NK_CTX)
   return "ok"
end