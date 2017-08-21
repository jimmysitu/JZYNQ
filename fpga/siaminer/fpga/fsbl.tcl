#STEP1: DEFINE KEY PARAMETERS
source ./run_params.tcl

###########################################################
# DEFAULTS
###########################################################
if {![info exists design]} {
    set design system
    puts "INFO: Setting design name to '${design}'"
}

if {![info exists projdir]} {
    set projdir [pwd]
    puts "INFO: Setting project path to '$projdir'"
}

# STEP2: CREATE PROJECT
sdk set_workspace $projdir/${design}.sdk
sdk create_hw_project -name ${design}_wrapper_hw_platform_0 -hwspec $projdir/${design}.sdk/${design}_wrapper.hdf
sdk create_app_project -name fsbl -hwproject ${design}_wrapper_hw_platform_0 -os standalone -proc ps7_cortexa9_0 -lang C -app "Zynq FSBL" -bsp fsbl_bsp

# STEP3: BUILD
sdk build_project fsbl
