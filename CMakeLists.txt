cmake_minimum_required(VERSION 3.4)

#глобально запрещаем компилятору трактовать предупреждения как ошибки
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-error=maybe-uninitialized -Wno-maybe-uninitialized")

#подключаем HunterGate
include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com"
    SHA1 "11578e9b6a18d3632cf4308a0d24c0840b3c625a"
)

project(print)

set(PRINT_VERSION_MAJOR 0)
set(PRINT_VERSION_MINOR 1)
set(PRINT_VERSION_PATCH 0)
set(PRINT_VERSION "${PRINT_VERSION_MAJOR}.${PRINT_VERSION_MINOR}.${PRINT_VERSION_PATCH}")
set(PRINT_VERSION_STRING "v${PRINT_VERSION}")

#подключение зависимостей через Hunter
hunter_add_package(GTest)
find_package(GTest CONFIG REQUIRED)

add_library(print STATIC sources/print.cpp)

target_include_directories(print PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

#сборка тестов (BUILD_TESTS=ON)
option(BUILD_TESTS "Build tests" OFF)

if(BUILD_TESTS)
    enable_testing()
    add_executable(test1 tests/test1.cpp)
    #пофиксили: используем корректное имя таргета для GTest 1.12+
    target_link_libraries(test1 print GTest::gtest_main)
    add_test(NAME test1 COMMAND test1)
endif()

#сборка демонстрационного приложения (шаг №8)
add_executable(demo ${CMAKE_CURRENT_SOURCE_DIR}/demo/main.cpp)
target_link_libraries(demo print)

#правила инсталляции
install(TARGETS print demo
    EXPORT print-config
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
)
install(DIRECTORY include/ DESTINATION include)
install(EXPORT print-config DESTINATION cmake)
