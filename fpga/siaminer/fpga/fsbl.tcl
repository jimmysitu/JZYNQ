###########################################################
# DEFAULTS
###########################################################
if {![info exists design]} {
    set design system
    puts "INFO: Setting design name to '${design}'"
}

# 
set hwdsgn [open_hw_design ${design}.hdf]
generate_app -hw $hwdsgn -os standalone -proc ps7_cortexa9_0 -app zynq_fsbl -compile -sw fsbl -dir fsbl

