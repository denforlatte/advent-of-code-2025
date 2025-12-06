cmake_minimum_required(VERSION 4.0)
project(Part02 C)

set(CMAKE_C_STANDARD 23)

add_executable(Part02 main.c)

configure_file(input.txt input.txt COPYONLY)
