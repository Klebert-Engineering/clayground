cmake_minimum_required (VERSION 3.12.0 FATAL_ERROR)
project (sbx_plugin)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTORCC ON)
find_package(Qt5 5.14 COMPONENTS Core Quick REQUIRED)

add_executable (${PROJECT_NAME} main.cpp res.qrc)
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_17)
target_link_libraries(${PROJECT_NAME}
PRIVATE
  Qt5::Core
  Qt5::Quick
)
