cmake_minimum_required(VERSION 3.5)
project(thing)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_BUILD_TYPE RelWithDebInfo)
# Right now we want the asserts to help catch bugs
string( REPLACE "-DNDEBUG" "" CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fuse-ld=gold")

add_executable(thing
  src/main.cpp
  src/lib.cpp
)

target_link_libraries(thing
  PRIVATE
)

target_include_directories(thing
  PRIVATE
    # Drop the "src/" prefix for local dependencies.
    src)

target_compile_definitions(thing PRIVATE USE_ASIO)
target_compile_options(thing
  PRIVATE
    -Wall
    -Wextra
    -Werror
    -Wno-unused-parameter)
