# ARDUINO_GET_PREF
# Does read of arduino IDE preference by name
# and writes it to variable with name provided
# in OUT_VAR
#
# PREF_NAME - Name of preference to get.
# OUT_VAR   - Name of variable to store result in.
function(ARDUINO_GET_PREF PREF_NAME OUT_VAR)
    execute_process(
            COMMAND ${ARDUINO_CLI} --get-pref ${PREF_NAME}
            WORKING_DIRECTORY ${ARDUINO_HOME}
            OUTPUT_VARIABLE ${OUT_VAR}
            ERROR_VARIABLE err)

    if (err)
        message(ERROR ${err})
    endif()

    #remove line endings and set result in caller scope.
    string(REGEX REPLACE "[\n\r]" "" ${OUT_VAR} ${${OUT_VAR}})
    set(${OUT_VAR} ${${OUT_VAR}} PARENT_SCOPE)
endfunction()

# INCLUDE_LIBS
# Walk through 'libraries' directory and include each one  individually.
#
# PATH - Full path of folder containing libraries.
function(INCLUDE_LIBS PATH)
    if (NOT EXISTS ${PATH})
        message(WARNING ${PATH})
        return()
    endif()

    file(GLOB libraries ${PATH}/*)
    foreach(library ${libraries})
        if(NOT IS_DIRECTORY ${library})
            continue()
        endif()

        set(library_src ${library}/src)
        if (EXISTS ${library_src} AND IS_DIRECTORY ${library_src})
            include_directories(${library_src})
        else()
            include_directories(${library})
        endif()
    endforeach()
endfunction()