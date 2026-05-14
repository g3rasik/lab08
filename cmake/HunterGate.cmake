macro(HunterGate)
  # Заглушка
endmacro()

macro(hunter_add_package)
  # Заглушка
endmacro()

macro(hunter_client)
  # Заглушка
endmacro()

# Принудительное создание таргетов GTest, которые ищет ваш CMakeLists.txt
if(NOT TARGET GTest::main)
  add_library(GTest::GTest UNKNOWN IMPORTED)
  set_target_properties(GTest::GTest PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "/usr/src/gtest/include"
    IMPORTED_LOCATION "/usr/lib/libgtest.a"
  )
  
  add_library(GTest::main UNKNOWN IMPORTED)
  set_target_properties(GTest::main PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "/usr/src/gtest/include"
    IMPORTED_LOCATION "/usr/lib/libgtest_main.a"
  )
  
  # Обманываем find_package(GTest), объявляя переменные успешного поиска
  set(GTest_FOUND TRUE)
  set(GTEST_FOUND TRUE)
endif()
