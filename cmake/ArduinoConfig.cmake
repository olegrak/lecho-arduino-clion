set(CMAKE_SYSTEM_NAME Arduino) #Name of the system CMake is building for.
#define CPU
add_definitions(-D${ARDUINO_CPU})
#set compilers. They're not used from Clion, but help include right libraries.
set(CMAKE_C_COMPILER ${ARDUINO_HOME}/hardware/tools/avr/bin/avr-gcc) #C AVR compiler
set(CMAKE_CXX_COMPILER ${ARDUINO_HOME}/hardware/tools/avr/bin/avr-g++) #C++ AVR compiler

#arduino cli tool
if (WIN32)
    set(ARDUINO_CLI ${ARDUINO_HOME}/arduino_debug.exe)
else ()
    set(ARDUINO_CLI ${ARDUINO_HOME}/arduino)
endif ()
if (NOT EXISTS ${ARDUINO_CLI} OR IS_DIRECTORY ${ARDUINO_CLI})
    return()
endif()

#set arduino sketch file assuming that the project was created from the Arduino IDE
#so the sketch name == %folder name%.ino
get_filename_component(ARDUINO_SKETCH ${CMAKE_SOURCE_DIR} NAME)
set(ARDUINO_SKETCH ${ARDUINO_SKETCH}.ino)
get_filename_component(ARDUINO_SKETCH_FULL_PATH ${ARDUINO_SKETCH} REALPATH)

#build dir
set(ARDUINO_BUILD_DIRECTORY ${CMAKE_SOURCE_DIR}/build)

#read preferences
arduino_get_pref(sketchbook.path ARDUINO_SKETCHBOOK)

#arduino-core
include_directories(${ARDUINO_HOME}/hardware/arduino/avr/cores/arduino/)
include_directories(${ARDUINO_HOME}/hardware/arduino/avr/variants/standard/)#TODO: include board specific pins map.

#built-in libraries
include_libs(${ARDUINO_HOME}/libraries)
include_libs(${ARDUINO_HOME}/hardware/arduino/avr/libraries/)

#libraries
include_libs(${ARDUINO_SKETCHBOOK}/libraries)

#indicate all went well
set(ARDUINO_CONFIG_SUCCEEDED TRUE)