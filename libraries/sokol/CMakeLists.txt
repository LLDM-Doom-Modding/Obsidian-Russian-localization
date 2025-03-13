##########################################
# sokol
##########################################

add_library(sokol sokol.c)

set (SOKOL_LINK_LIBRARIES nuklear)

if (OBSIDIAN_SOKOL_GL)
    set (SOKOL_LINK_LIBRARIES ${SOKOL_LINK_LIBRARIES} OpenGL::GL)
elseif (OBSIDIAN_SOKOL_GLES3 AND NOT EMSCRIPTEN)
    set (SOKOL_LINK_LIBRARIES ${SOKOL_LINK_LIBRARIES} OpenGL::GLES3 OpenGL::EGL)
endif()

if (CMAKE_HOST_LINUX AND NOT MINGW)
  set (SOKOL_LINK_LIBRARIES ${SOKOL_LINK_LIBRARIES} X11 Xi Xcursor dl pthread m)
endif()

target_link_libraries(sokol PRIVATE ${SOKOL_LINK_LIBRARIES})

target_include_directories(sokol PUBLIC ./)

if(OBSIDIAN_SOKOL_GL)
    target_compile_definitions (sokol PUBLIC SOKOL_GLCORE)
elseif(OBSIDIAN_SOKOL_GLES3)
    target_compile_definitions (sokol PUBLIC SOKOL_GLES3)
else()
    target_compile_definitions (sokol PUBLIC SOKOL_D3D11)
endif()