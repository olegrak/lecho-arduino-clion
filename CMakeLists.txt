cmake_minimum_required(VERSION 3.2.3)
project(ClionArduino)

set(ARDUINO_HOME "C:/Program Files (x86)/Arduino") # This should be set to folder containing 'arduino' executable.
set(ARDUINO_CPU __AVR_ATmega328P__) # CPU definition. Look at WIKI on GitHub

include(${CMAKE_SOURCE_DIR}/cmake/Utils.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/ArduinoConfig.cmake)

if (ARDUINO_CONFIG_SUCCEEDED)
    add_custom_target(
            VERIFY_PROJECT
            COMMAND ${ARDUINO_CLI} --verify ${ARDUINO_SKETCH_FULL_PATH} --pref build.path=${ARDUINO_BUILD_DIRECTORY}
            WORKING_DIRECTORY ${ARDUINO_HOME})

    add_custom_target(
            UPLOAD_TO_BOARD
            COMMAND ${ARDUINO_CLI} --upload --verbose-upload ${ARDUINO_SKETCH_FULL_PATH} --pref build.path=${ARDUINO_BUILD_DIRECTORY}
            WORKING_DIRECTORY ${ARDUINO_HOME})

    SET_SOURCE_FILES_PROPERTIES(${ARDUINO_SKETCH} PROPERTIES LANGUAGE CXX)
    add_library(DUMMY ${ARDUINO_SKETCH})
endif()