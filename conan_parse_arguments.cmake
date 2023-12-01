cmake_minimum_required(VERSION 3.0)

find_program(CONAN_COMMAND "conan" REQUIRED)
set(_conan_command install)
execute_process(COMMAND ${CONAN_COMMAND} ${_conan_command} --help
    RESULT_VARIABLE _conan_result
    OUTPUT_VARIABLE _conan_stdout
    ERROR_VARIABLE conan_stderr
    ECHO_ERROR_VARIABLE    # show the text output regardless
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

string(REGEX REPLACE ";" "\\\\;" _conan_stdout "${_conan_stdout}")
string(REGEX REPLACE "\n" ";" _conan_stdout "${_conan_stdout}")

unset(_pos_args)
unset(_opt_args)
# _states:
#   0 - none
#   1 - append positional
#   2 - append optional

set(_state 0)
foreach (_line IN LISTS _conan_stdout)
    if (_state EQUAL 0)
        if ("${_line}" STREQUAL "positional arguments:")
            set(_state 1)
        elseif ("${_line}" STREQUAL "optional arguments:")
            set(_state 2)
        endif()
    elseif ("${_line}" STREQUAL "") 
        set(_state 0)
    else()
        string(FIND "${_line}" "   " _pos)
        if (NOT _pos EQUAL 0) 
            if (_state EQUAL 1)
                list(APPEND _pos_args "${_line}")
            elseif (_state EQUAL 2)
                list(APPEND _opt_args "${_line}")
            endif()
        endif()
    endif()
#    message(STATUS "${_state}: '${_line}'")
endforeach()

# regex to match positional 
foreach(_line IN LISTS _pos_args)
    string(REGEX MATCH [[^  [a-z\-_]+]] _pos_match "${_line}")
    string(STRIP "${_pos_match}" _pos_match)
    if (NOT "${_pos_match}" STREQUAL "")
        message(STATUS "POS: '${_pos_match}'")
    endif()

    string(REGEX MATCH [[^  {[a-z\-_]+(,[a-z_]+(-[a-z_]+)*)*}]] _pos_match "${_line}")
    if (NOT "${_pos_match}" STREQUAL "")
        message(STATUS "POS: '${_pos_match}'")
    else ()
        message(STATUS "POS_not: '${_line}'")
    endif()
    
endforeach()

# regex to match begining 
foreach(_line IN LISTS _opt_args)
    string(REGEX MATCH [[^  --?[a-z:]+((-[a-z]+)*)?( [A-Z_:]+)?(, --?[a-z:]+((-[a-z]+)*)?( [A-Z_:]+)?)?]] _opt_match "${_line}")
    if (NOT "${_opt_match}" STREQUAL "")
        message(STATUS "OPT: '${_opt_match}'")
    else()
        message(STATUS "Not OPT: ${_line}")
    endif()
endforeach()

#[=======================================================================[.rst:
it uses argparse form python 
it will ouotput it by 
```bash
> python prog.py --help
usage: prog.py [-h] echo

positional arguments:
  echo

options:
  -h, --help  show this help message and exit
```

find `positional arguments' 

#]=======================================================================]