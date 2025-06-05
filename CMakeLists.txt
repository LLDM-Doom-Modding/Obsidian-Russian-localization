cmake_minimum_required(VERSION 3.25)

project(
  obsidian
  LANGUAGES C CXX
  VERSION 0.1.0
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

option(OBSIDIAN_GUI       "Build Sokol+Nuklear GUI" ON)
# These are only needed if wanting to force a specific Sokol backend,
# otherwise a platform-specific default will be selected
option(OBSIDIAN_SOKOL_D3D11 "Use Sokol D3D11" OFF)
option(OBSIDIAN_SOKOL_GL    "Use Sokol GL"    OFF)
option(OBSIDIAN_SOKOL_GLES3 "Use Sokol GLES3" OFF)

if(OBSIDIAN_GUI)
  if (NOT OBSIDIAN_SOKOL_GL AND NOT OBSIDIAN_SOKOL_D3D11 AND NOT OBSIDIAN_SOKOL_GLES3)
    if (WIN32 OR MINGW)
      set (OBSIDIAN_SOKOL_D3D11 ON)
    elseif (EMSCRIPTEN)
      set (OBSIDIAN_SOKOL_GLES3 ON)
    else ()
      set (OBSIDIAN_SOKOL_GL ON)
    endif ()
  endif ()
  add_compile_definitions(OBSIDIAN_ENABLE_GUI)
endif()

string(TIMESTAMP BUILD_TIMESTAMP "%Y.%m.%d" UTC)
add_compile_definitions(OBSIDIAN_TIMESTAMP="${BUILD_TIMESTAMP}")

if(MSVC)
  # These are needed for MSVC to play ball as much as possible
  # with the /EHs- flag
  add_definitions("-D_HAS_EXCEPTIONS=0 -D_STATIC_CPPLIB")

  # get the number of logical cores for parallel build
  cmake_host_system_information(RESULT LOGICAL_CORES QUERY NUMBER_OF_LOGICAL_CORES)
  math(EXPR COMPILE_CORES "${LOGICAL_CORES} - 1")
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /fp:fast /EHs- /GR- /MP${COMPILE_CORES}")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /fp:fast /EHs- /GR- /MP${COMPILE_CORES}")
  if (OBSIDIAN_GUI)
    set(CMAKE_EXE_LINKER_FLAGS "/SUBSYSTEM:WINDOWS")
  else ()
    set(CMAKE_EXE_LINKER_FLAGS "/SUBSYSTEM:CONSOLE")
  endif ()
else()
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fno-exceptions -fno-strict-aliasing")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-exceptions -fno-rtti -fno-strict-aliasing")
endif()
if(APPLE OR ${CMAKE_SYSTEM} MATCHES "BSD")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -I /usr/local/include")
endif()

if(OBSIDIAN_GUI)
  if (OBSIDIAN_SOKOL_GL)  
    find_package(OpenGL REQUIRED)
  elseif (OBSIDIAN_SOKOL_GLES3 AND NOT EMSCRIPTEN)
    find_package(OpenGL COMPONENTS GLES3 EGL REQUIRED)
  endif()
endif()

add_subdirectory(libraries)

set(OBSIDIAN_SOURCE_FILES
    source/bsp_level.cc
    source/bsp_misc.cc
    source/bsp_node.cc
    source/bsp_wad.cc
    source/bsp.cc
    source/csg_bsp.cc
    source/csg_doom.cc
    source/csg_main.cc
    source/csg_shade.cc
    source/csg_spots.cc
    source/dm_extra.cc
    source/dm_prefab.cc
    source/g_doom.cc
    source/lib_argv.cc
    source/lib_tga.cc
    source/lib_util.cc
    source/lib_wad.cc
    source/lib_parse.cc
    source/lib_zip.cc
    source/m_addons.cc
    source/m_cookie.cc
    source/m_lua.cc
    source/m_trans.cc
    source/main.cc
    source/poly_map.cc
    source/poly.cc
    source/poly_util.cc
    source/poly_wad.cc
    source/sys_assert.cc
    source/sys_debug.cc
    source/sys_twister.cc
    source/tx_forge.cc
    source/tx_skies.cc
)

if (WIN32)
  set(OBSIDIAN_SOURCE_FILES
    ${OBSIDIAN_SOURCE_FILES}
    source/obsidian.rc
  )
endif()

add_executable(
  obsidian
  ${OBSIDIAN_SOURCE_FILES}
)

# Copies executables to local install directory after build
set(COPY_FILES "")

set (DEST_DIR "${CMAKE_SOURCE_DIR}")
list(APPEND COPY_FILES "$<TARGET_FILE:obsidian>")

if (COPY_FILES)
  add_custom_command(TARGET obsidian POST_BUILD COMMAND_EXPAND_LISTS COMMAND ${CMAKE_COMMAND} -E copy_if_different ${COPY_FILES} ${DEST_DIR})
endif()

set(OBSIDIAN_LINK_LIBRARIES luaalloc minilua miniz physfs-static)

if (UNIX AND NOT APPLE AND NOT ${CMAKE_SYSTEM} MATCHES "BSD")
  set(OBSIDIAN_LINK_LIBRARIES ${OBSIDIAN_LINK_LIBRARIES} pthread)
endif()

if (OBSIDIAN_GUI)
  set(OBSIDIAN_LINK_LIBRARIES ${OBSIDIAN_LINK_LIBRARIES} moonnuklear nuklear sokol)
endif()

target_link_libraries(obsidian PRIVATE ${OBSIDIAN_LINK_LIBRARIES})