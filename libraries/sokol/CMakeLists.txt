##########################################
# sokol
##########################################

add_library(sokol sokol.c)

set (SOKOL_LINK_LIBRARIES nuklear OpenGL::GL)

if (CMAKE_HOST_LINUX AND NOT MINGW)
  set (SOKOL_LINK_LIBRARIES ${SOKOL_LINK_LIBRARIES} X11 Xi Xcursor dl pthread m)
endif()

target_link_libraries(sokol PRIVATE ${SOKOL_LINK_LIBRARIES})

target_include_directories(sokol PUBLIC ./)