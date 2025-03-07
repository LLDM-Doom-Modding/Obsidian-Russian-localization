/*
 * Nuklear - 4.9.4 - public domain
 */
/*
 * ==============================================================
 *
 *                              API
 *
 * ===============================================================
 */
#ifndef NK_SDL_RENDERER_H_
#define NK_SDL_RENDERER_H_

#ifndef NK_SDL_RENDERER_SDL_H
#define NK_SDL_RENDERER_SDL_H <SDL.h>
#endif
#include NK_SDL_RENDERER_SDL_H
NK_API struct nk_context*   nk_sdl_init(SDL_Window *win, SDL_Renderer *renderer);
NK_API void                 nk_sdl_font_stash_begin(struct nk_font_atlas **atlas);
NK_API void                 nk_sdl_font_stash_end(void);
NK_API int                  nk_sdl_handle_event(SDL_Event *evt);
NK_API void                 nk_sdl_render(enum nk_anti_aliasing);
NK_API void                 nk_sdl_shutdown(void);
NK_API void                 nk_sdl_handle_grab(void);

#endif /* NK_SDL_RENDERER_H_ */

/*
 * ==============================================================
 *
 *                          IMPLEMENTATION
 *
 * ===============================================================
 */
#ifdef NK_SDL_RENDERER_IMPLEMENTATION
#include <string.h>
#include <stdlib.h>

struct nk_sdl_device {
    struct nk_buffer cmds;
    struct nk_draw_null_texture tex_null;
    SDL_Texture *font_tex;
};

struct nk_sdl_vertex {
    float position[2];
    float uv[2];
    float col[4];
};

static struct nk_sdl {
    SDL_Window *win;
    SDL_Renderer *renderer;
    struct nk_sdl_device ogl;
    struct nk_context ctx;
    struct nk_font_atlas atlas;
    Uint64 time_of_last_frame;
} sdl;

NK_INTERN void
nk_sdl_device_upload_atlas(const void *image, int width, int height)
{
    struct nk_sdl_device *dev = &sdl.ogl;

    SDL_Texture *g_SDLFontTexture = SDL_CreateTexture(sdl.renderer, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STATIC, width, height);
    if (g_SDLFontTexture == NULL) {
        SDL_Log("error creating texture");
        return;
    }
    SDL_UpdateTexture(g_SDLFontTexture, NULL, image, 4 * width);
    SDL_SetTextureBlendMode(g_SDLFontTexture, SDL_BLENDMODE_BLEND);
    dev->font_tex = g_SDLFontTexture;
}

NK_API void
nk_sdl_render(enum nk_anti_aliasing AA)
{
    /* setup global state */
    struct nk_sdl_device *dev = &sdl.ogl;

    {
        SDL_Rect saved_clip;
        bool clipping_enabled;
        int vs = sizeof(struct nk_sdl_vertex);
        size_t vp = offsetof(struct nk_sdl_vertex, position);
        size_t vt = offsetof(struct nk_sdl_vertex, uv);
        size_t vc = offsetof(struct nk_sdl_vertex, col);

        /* convert from command queue into draw list and draw to screen */
        const struct nk_draw_command *cmd;
        const nk_draw_index *offset = NULL;
        struct nk_buffer vbuf, ebuf;

        /* fill converting configuration */
        struct nk_convert_config config;
        static const struct nk_draw_vertex_layout_element vertex_layout[] = {
            {NK_VERTEX_POSITION, NK_FORMAT_FLOAT, NK_OFFSETOF(struct nk_sdl_vertex, position)},
            {NK_VERTEX_TEXCOORD, NK_FORMAT_FLOAT, NK_OFFSETOF(struct nk_sdl_vertex, uv)},
            {NK_VERTEX_COLOR, NK_FORMAT_R32G32B32A32_FLOAT, NK_OFFSETOF(struct nk_sdl_vertex, col)},
            {NK_VERTEX_LAYOUT_END}
        };

        Uint64 now = SDL_GetTicks();
        sdl.ctx.delta_time_seconds = (float)(now - sdl.time_of_last_frame) / 1000;
        sdl.time_of_last_frame = now;

        NK_MEMSET(&config, 0, sizeof(config));
        config.vertex_layout = vertex_layout;
        config.vertex_size = sizeof(struct nk_sdl_vertex);
        config.vertex_alignment = NK_ALIGNOF(struct nk_sdl_vertex);
        config.tex_null = dev->tex_null;
        config.circle_segment_count = 22;
        config.curve_segment_count = 22;
        config.arc_segment_count = 22;
        config.global_alpha = 1.0f;
        config.shape_AA = AA;
        config.line_AA = AA;

        /* convert shapes into vertexes */
        nk_buffer_init_default(&vbuf);
        nk_buffer_init_default(&ebuf);
        nk_convert(&sdl.ctx, &dev->cmds, &vbuf, &ebuf, &config);

        /* iterate over and execute each draw command */
        offset = (const nk_draw_index*)nk_buffer_memory_const(&ebuf);

        clipping_enabled = SDL_RenderClipEnabled(sdl.renderer);
        SDL_GetRenderClipRect(sdl.renderer, &saved_clip);

        nk_draw_foreach(cmd, &sdl.ctx, &dev->cmds)
        {
            if (!cmd->elem_count) continue;

            {
                SDL_Rect r;
                r.x = cmd->clip_rect.x;
                r.y = cmd->clip_rect.y;
                r.w = cmd->clip_rect.w;
                r.h = cmd->clip_rect.h;
                SDL_SetRenderClipRect(sdl.renderer, &r);
            }

            {
                const void *vertices = nk_buffer_memory_const(&vbuf);

                SDL_RenderGeometryRaw(sdl.renderer,
                        (SDL_Texture *)cmd->texture.ptr,
                        (const float*)((const nk_byte*)vertices + vp), vs,
                        (const SDL_FColor*)((const nk_byte*)vertices + vc), vs,
                        (const float*)((const nk_byte*)vertices + vt), vs,
                        (vbuf.needed / vs),
                        (void *) offset, cmd->elem_count, 2);

                offset += cmd->elem_count;
            }
        }

        SDL_SetRenderClipRect(sdl.renderer, &saved_clip);
        if (!clipping_enabled) {
            SDL_SetRenderClipRect(sdl.renderer, NULL);
        }

        nk_clear(&sdl.ctx);
        nk_buffer_clear(&dev->cmds);
        nk_buffer_free(&vbuf);
        nk_buffer_free(&ebuf);
    }
}

static void
nk_sdl_clipboard_paste(nk_handle usr, struct nk_text_edit *edit)
{
    const char *text = SDL_GetClipboardText();
    if (text) nk_textedit_paste(edit, text, nk_strlen(text));
    (void)usr;
}

static void
nk_sdl_clipboard_copy(nk_handle usr, const char *text, int len)
{
    char *str = 0;
    (void)usr;
    if (!len) return;
    str = (char*)malloc((size_t)len+1);
    if (!str) return;
    memcpy(str, text, (size_t)len);
    str[len] = '\0';
    SDL_SetClipboardText(str);
    free(str);
}

NK_API struct nk_context*
nk_sdl_init(SDL_Window *win, SDL_Renderer *renderer)
{
    sdl.win = win;
    sdl.renderer = renderer;
    sdl.time_of_last_frame = SDL_GetTicks();
    nk_init_default(&sdl.ctx, 0);
    sdl.ctx.clip.copy = nk_sdl_clipboard_copy;
    sdl.ctx.clip.paste = nk_sdl_clipboard_paste;
    sdl.ctx.clip.userdata = nk_handle_ptr(0);
    nk_buffer_init_default(&sdl.ogl.cmds);
    return &sdl.ctx;
}

NK_API void
nk_sdl_font_stash_begin(struct nk_font_atlas **atlas)
{
    nk_font_atlas_init_default(&sdl.atlas);
    nk_font_atlas_begin(&sdl.atlas);
    *atlas = &sdl.atlas;
}

NK_API void
nk_sdl_font_stash_end(void)
{
    const void *image; int w, h;
    image = nk_font_atlas_bake(&sdl.atlas, &w, &h, NK_FONT_ATLAS_RGBA32);
    nk_sdl_device_upload_atlas(image, w, h);
    nk_font_atlas_end(&sdl.atlas, nk_handle_ptr(sdl.ogl.font_tex), &sdl.ogl.tex_null);
    if (sdl.atlas.default_font)
        nk_style_set_font(&sdl.ctx, &sdl.atlas.default_font->handle);
}

NK_API void
nk_sdl_handle_grab(void)
{
    struct nk_context *ctx = &sdl.ctx;
    if (ctx->input.mouse.grab) {
        SDL_SetWindowRelativeMouseMode(sdl.win, true);
    } else if (ctx->input.mouse.ungrab) {
        /* better support for older SDL by setting mode first; causes an extra mouse motion event */
        SDL_SetWindowRelativeMouseMode(sdl.win, false);
        SDL_WarpMouseInWindow(sdl.win, (int)ctx->input.mouse.prev.x, (int)ctx->input.mouse.prev.y);
    } else if (ctx->input.mouse.grabbed) {
        ctx->input.mouse.pos.x = ctx->input.mouse.prev.x;
        ctx->input.mouse.pos.y = ctx->input.mouse.prev.y;
    }
}

NK_API int
nk_sdl_handle_event(SDL_Event *evt)
{
    struct nk_context *ctx = &sdl.ctx;

    switch(evt->type)
    {
        case SDL_EVENT_KEY_UP: /* KEYUP & KEYDOWN share same routine */
        case SDL_EVENT_KEY_DOWN:
            {
                int down = evt->type == SDL_EVENT_KEY_DOWN;
                const bool *state = SDL_GetKeyboardState(NULL);
                switch (evt->key.scancode) 
                {
                    case SDL_SCANCODE_LSHIFT:                                   
                    case SDL_SCANCODE_RSHIFT:
                        nk_input_key(ctx, NK_KEY_SHIFT, down);
                        return 1; 
                        break;
                    case SDL_SCANCODE_DELETE:
                        nk_input_key(ctx, NK_KEY_DEL, down);
                        return 1; 
                        break;
                    case SDL_SCANCODE_RETURN:
                    case SDL_SCANCODE_KP_ENTER:
                        nk_input_key(ctx, NK_KEY_ENTER, down);
                        return 1; 
                        break;
                    case SDL_SCANCODE_TAB:                                
                    case SDL_SCANCODE_KP_TAB:
                        nk_input_key(ctx, NK_KEY_TAB, down);
                        return 1;  
                        break;
                    case SDL_SCANCODE_BACKSPACE:                        
                    case SDL_SCANCODE_KP_BACKSPACE:
                        nk_input_key(ctx, NK_KEY_BACKSPACE, down); 
                        return 1; 
                        break;
                    case SDL_SCANCODE_HOME:
                        nk_input_key(ctx, NK_KEY_TEXT_START, down);
                        nk_input_key(ctx, NK_KEY_SCROLL_START, down);
                        return 1;  
                        break;
                    case SDL_SCANCODE_END:
                        nk_input_key(ctx, NK_KEY_TEXT_END, down);
                        nk_input_key(ctx, NK_KEY_SCROLL_END, down); 
                        return 1; 
                        break;
                    case SDL_SCANCODE_PAGEDOWN:
                        nk_input_key(ctx, NK_KEY_SCROLL_DOWN, down);
                        return 1;  
                        break;  
                    case SDL_SCANCODE_PAGEUP:
                        nk_input_key(ctx, NK_KEY_SCROLL_UP, down); 
                        return 1; 
                        break;
                    case SDL_SCANCODE_UP:
                        nk_input_key(ctx, NK_KEY_UP, down); 
                        return 1; 
                        break;
                    case SDL_SCANCODE_DOWN:
                        nk_input_key(ctx, NK_KEY_DOWN, down); 
                        return 1; 
                        break;
                    case SDL_SCANCODE_LEFT:
                    {
                        if (state[SDL_SCANCODE_LCTRL])
                            nk_input_key(ctx, NK_KEY_TEXT_WORD_LEFT, down);
                        else 
                            nk_input_key(ctx, NK_KEY_LEFT, down);
                        return 1; 
                        break;
                    }
                    case SDL_SCANCODE_RIGHT:
                    {
                        if (state[SDL_SCANCODE_LCTRL])
                            nk_input_key(ctx, NK_KEY_TEXT_WORD_RIGHT, down);
                        else 
                            nk_input_key(ctx, NK_KEY_RIGHT, down);
                        return 1; 
                        break;
                    }         
                    case SDL_SCANCODE_CAPSLOCK:
                    case SDL_SCANCODE_F1:
                    case SDL_SCANCODE_F2:
                    case SDL_SCANCODE_F3:
                    case SDL_SCANCODE_F4:
                    case SDL_SCANCODE_F5:
                    case SDL_SCANCODE_F6:
                    case SDL_SCANCODE_F7:
                    case SDL_SCANCODE_F8:
                    case SDL_SCANCODE_F9:
                    case SDL_SCANCODE_F10:
                    case SDL_SCANCODE_F11:
                    case SDL_SCANCODE_F12:
                    case SDL_SCANCODE_PRINTSCREEN:
                    case SDL_SCANCODE_SCROLLLOCK:
                    case SDL_SCANCODE_PAUSE:
                    case SDL_SCANCODE_INSERT:
                    case SDL_SCANCODE_NUMLOCKCLEAR:
                    case SDL_SCANCODE_KP_DIVIDE:
                    case SDL_SCANCODE_KP_MULTIPLY:
                    case SDL_SCANCODE_KP_MINUS:
                    case SDL_SCANCODE_KP_PLUS:
                    case SDL_SCANCODE_KP_1:
                    case SDL_SCANCODE_KP_2:
                    case SDL_SCANCODE_KP_3:
                    case SDL_SCANCODE_KP_4:
                    case SDL_SCANCODE_KP_5:
                    case SDL_SCANCODE_KP_6:
                    case SDL_SCANCODE_KP_7:
                    case SDL_SCANCODE_KP_8:
                    case SDL_SCANCODE_KP_9:
                    case SDL_SCANCODE_KP_0:
                    case SDL_SCANCODE_KP_PERIOD:
                    case SDL_SCANCODE_APPLICATION:
                    case SDL_SCANCODE_POWER:
                    case SDL_SCANCODE_KP_EQUALS:
                    case SDL_SCANCODE_F13:
                    case SDL_SCANCODE_F14:
                    case SDL_SCANCODE_F15:
                    case SDL_SCANCODE_F16:
                    case SDL_SCANCODE_F17:
                    case SDL_SCANCODE_F18:
                    case SDL_SCANCODE_F19:
                    case SDL_SCANCODE_F20:
                    case SDL_SCANCODE_F21:
                    case SDL_SCANCODE_F22:
                    case SDL_SCANCODE_F23:
                    case SDL_SCANCODE_F24:
                    case SDL_SCANCODE_EXECUTE:
                    case SDL_SCANCODE_HELP:
                    case SDL_SCANCODE_MENU:
                    case SDL_SCANCODE_SELECT:
                    case SDL_SCANCODE_STOP:
                    case SDL_SCANCODE_AGAIN:
                    case SDL_SCANCODE_UNDO:
                    case SDL_SCANCODE_CUT:
                    case SDL_SCANCODE_COPY:
                    case SDL_SCANCODE_PASTE:
                    case SDL_SCANCODE_FIND:
                    case SDL_SCANCODE_MUTE:
                    case SDL_SCANCODE_VOLUMEUP:
                    case SDL_SCANCODE_VOLUMEDOWN:
                    case SDL_SCANCODE_KP_COMMA:
                    case SDL_SCANCODE_KP_EQUALSAS400:
                    case SDL_SCANCODE_ALTERASE:
                    case SDL_SCANCODE_SYSREQ:
                    case SDL_SCANCODE_CANCEL:
                    case SDL_SCANCODE_CLEAR:
                    case SDL_SCANCODE_PRIOR:
                    case SDL_SCANCODE_RETURN2:
                    case SDL_SCANCODE_SEPARATOR:
                    case SDL_SCANCODE_OUT:
                    case SDL_SCANCODE_OPER:
                    case SDL_SCANCODE_CLEARAGAIN:
                    case SDL_SCANCODE_CRSEL:
                    case SDL_SCANCODE_EXSEL:
                    case SDL_SCANCODE_KP_00:                              
                    case SDL_SCANCODE_KP_000:
                    case SDL_SCANCODE_THOUSANDSSEPARATOR:                               
                    case SDL_SCANCODE_DECIMALSEPARATOR:                                
                    case SDL_SCANCODE_CURRENCYUNIT:                                
                    case SDL_SCANCODE_CURRENCYSUBUNIT:                                
                    case SDL_SCANCODE_KP_LEFTPAREN:                                
                    case SDL_SCANCODE_KP_RIGHTPAREN:                                
                    case SDL_SCANCODE_KP_LEFTBRACE:                                
                    case SDL_SCANCODE_KP_RIGHTBRACE:                             
                    case SDL_SCANCODE_KP_A:                                
                    case SDL_SCANCODE_KP_B:                                
                    case SDL_SCANCODE_KP_C:                                
                    case SDL_SCANCODE_KP_D:                                
                    case SDL_SCANCODE_KP_E:                                
                    case SDL_SCANCODE_KP_F:                                
                    case SDL_SCANCODE_KP_XOR:                                
                    case SDL_SCANCODE_KP_POWER:                                
                    case SDL_SCANCODE_KP_PERCENT:                                
                    case SDL_SCANCODE_KP_LESS:                                
                    case SDL_SCANCODE_KP_GREATER:                                
                    case SDL_SCANCODE_KP_AMPERSAND:                                
                    case SDL_SCANCODE_KP_DBLAMPERSAND:                                
                    case SDL_SCANCODE_KP_VERTICALBAR:                                
                    case SDL_SCANCODE_KP_DBLVERTICALBAR:                                
                    case SDL_SCANCODE_KP_COLON:                                
                    case SDL_SCANCODE_KP_HASH:                                
                    case SDL_SCANCODE_KP_SPACE:                                
                    case SDL_SCANCODE_KP_AT:                                
                    case SDL_SCANCODE_KP_EXCLAM:                                
                    case SDL_SCANCODE_KP_MEMSTORE:                                
                    case SDL_SCANCODE_KP_MEMRECALL:                                
                    case SDL_SCANCODE_KP_MEMCLEAR:                                
                    case SDL_SCANCODE_KP_MEMADD:                                
                    case SDL_SCANCODE_KP_MEMSUBTRACT:                                
                    case SDL_SCANCODE_KP_MEMMULTIPLY:                                
                    case SDL_SCANCODE_KP_MEMDIVIDE:                                
                    case SDL_SCANCODE_KP_PLUSMINUS:                                
                    case SDL_SCANCODE_KP_CLEAR:                                
                    case SDL_SCANCODE_KP_CLEARENTRY:                                
                    case SDL_SCANCODE_KP_BINARY:                                
                    case SDL_SCANCODE_KP_OCTAL:                                
                    case SDL_SCANCODE_KP_DECIMAL:                                
                    case SDL_SCANCODE_KP_HEXADECIMAL:                                
                    case SDL_SCANCODE_LCTRL:                                                            
                    case SDL_SCANCODE_LALT:                                
                    case SDL_SCANCODE_LGUI:                                
                    case SDL_SCANCODE_RCTRL:                       
                    case SDL_SCANCODE_RALT:                                
                    case SDL_SCANCODE_RGUI:                                
                    case SDL_SCANCODE_MODE:                                
                    case SDL_SCANCODE_SLEEP:                                
                    case SDL_SCANCODE_WAKE:                                
                    case SDL_SCANCODE_CHANNEL_INCREMENT:                                
                    case SDL_SCANCODE_CHANNEL_DECREMENT:                                
                    case SDL_SCANCODE_MEDIA_PLAY:                                
                    case SDL_SCANCODE_MEDIA_PAUSE:                                
                    case SDL_SCANCODE_MEDIA_RECORD:                                
                    case SDL_SCANCODE_MEDIA_FAST_FORWARD:                                
                    case SDL_SCANCODE_MEDIA_REWIND:                                
                    case SDL_SCANCODE_MEDIA_NEXT_TRACK:                                
                    case SDL_SCANCODE_MEDIA_PREVIOUS_TRACK:                                
                    case SDL_SCANCODE_MEDIA_STOP:                                
                    case SDL_SCANCODE_MEDIA_EJECT:                                
                    case SDL_SCANCODE_MEDIA_PLAY_PAUSE:                                
                    case SDL_SCANCODE_MEDIA_SELECT:                                
                    case SDL_SCANCODE_AC_NEW:                                
                    case SDL_SCANCODE_AC_OPEN:                                
                    case SDL_SCANCODE_AC_CLOSE:                                
                    case SDL_SCANCODE_AC_EXIT:                                
                    case SDL_SCANCODE_AC_SAVE:                                
                    case SDL_SCANCODE_AC_PRINT:                                
                    case SDL_SCANCODE_AC_PROPERTIES:                                
                    case SDL_SCANCODE_AC_SEARCH:                                
                    case SDL_SCANCODE_AC_HOME:                                
                    case SDL_SCANCODE_AC_BACK:                                
                    case SDL_SCANCODE_AC_FORWARD:                                
                    case SDL_SCANCODE_AC_STOP:                                
                    case SDL_SCANCODE_AC_REFRESH:                                
                    case SDL_SCANCODE_AC_BOOKMARKS:                                
                    case SDL_SCANCODE_SOFTLEFT:                                
                    case SDL_SCANCODE_SOFTRIGHT:                                
                    case SDL_SCANCODE_CALL:                                
                    case SDL_SCANCODE_ENDCALL:                            
                    case SDL_SCANCODE_UNKNOWN:
                        return 1;
                        break;
                }
                if (down)
                {
                    nk_glyph glyph;
                    memcpy(glyph, &evt->key.key, NK_UTF_SIZE);
                    nk_input_glyph(ctx, glyph);
                }
            }
            return 1;

        case SDL_EVENT_MOUSE_BUTTON_UP: /* MOUSEBUTTONUP & MOUSEBUTTONDOWN share same routine */
        case SDL_EVENT_MOUSE_BUTTON_DOWN:
            {
                int down = evt->type == SDL_EVENT_MOUSE_BUTTON_DOWN;
                const int x = evt->button.x, y = evt->button.y;
                switch(evt->button.button)
                {
                    case SDL_BUTTON_LEFT:
                        if (evt->button.clicks > 1)
                            nk_input_button(ctx, NK_BUTTON_DOUBLE, x, y, down);
                        nk_input_button(ctx, NK_BUTTON_LEFT, x, y, down); break;
                    case SDL_BUTTON_MIDDLE: nk_input_button(ctx, NK_BUTTON_MIDDLE, x, y, down); break;
                    case SDL_BUTTON_RIGHT:  nk_input_button(ctx, NK_BUTTON_RIGHT, x, y, down); break;
                }
            }
            return 1;

        case SDL_EVENT_MOUSE_MOTION:
            if (ctx->input.mouse.grabbed) {
                int x = (int)ctx->input.mouse.prev.x, y = (int)ctx->input.mouse.prev.y;
                nk_input_motion(ctx, x + evt->motion.xrel, y + evt->motion.yrel);
            }
            else nk_input_motion(ctx, evt->motion.x, evt->motion.y);
            return 1;

        case SDL_EVENT_TEXT_INPUT:
            {
                nk_glyph glyph;
                memcpy(glyph, evt->text.text, NK_UTF_SIZE);
                nk_input_glyph(ctx, glyph);
            }
            return 1;

        case SDL_EVENT_MOUSE_WHEEL:
            nk_input_scroll(ctx,nk_vec2((float)evt->wheel.x,(float)evt->wheel.y));
            return 1;
    }
    return 0;
}

NK_API
void nk_sdl_shutdown(void)
{
    struct nk_sdl_device *dev = &sdl.ogl;
    nk_font_atlas_clear(&sdl.atlas);
    nk_free(&sdl.ctx);
    SDL_DestroyTexture(dev->font_tex);
    /* glDeleteTextures(1, &dev->font_tex); */
    nk_buffer_free(&dev->cmds);
    memset(&sdl, 0, sizeof(sdl));
}

#endif /* NK_SDL_RENDERER_IMPLEMENTATION */
