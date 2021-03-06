cmake_minimum_required (VERSION 3.12.0 FATAL_ERROR)
project (Clayground VERSION 2020.1)

enable_testing()
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CLAY_PLUGIN_BASE_DIR ${CMAKE_BINARY_DIR}/bin/plugins/Clayground)
set(QML_IMPORT_PATH ${CMAKE_BINARY_DIR}/bin/plugins CACHE STRING "" FORCE)

add_subdirectory (qml_live_loader)
add_subdirectory (plugins)
add_subdirectory (thirdparty/qml-box2d)
add_subdirectory (thirdparty/simple-svg-writer)

add_subdirectory (sandboxes/gui)
add_subdirectory (sandboxes/visualfx)
add_subdirectory (sandboxes/platformer)
add_subdirectory (sandboxes/pluginlive)
add_subdirectory (sandboxes/topdown)
add_subdirectory (sandboxes/void)
