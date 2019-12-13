############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
############################################################
open_project CS_550_Image_Search_HLS
add_files CS_550_Image_Search_HLS/src/ap_bmp.cpp
add_files CS_550_Image_Search_HLS/src/ap_bmp.h
add_files CS_550_Image_Search_HLS/solution1/resize.cpp
add_files -tb CS_550_Image_Search_HLS/tb/main_tb.cpp
open_solution "solution1"
set_part {xc7z020clg484-1} -tool vivado
create_clock -period 10 -name default
#source "./CS_550_Image_Search_HLS/solution1/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -format ip_catalog
