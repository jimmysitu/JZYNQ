
M_DEPS := run.tcl

M_FLIST := *.cache
M_FLIST += *.data
M_FLIST += *.xpr
M_FLIST += *.log
M_FLIST += *.jou
M_FLIST +=  xgui
M_FLIST += *.runs
M_FLIST += *.srcs
M_FLIST += *.sdk
M_FLIST += *.hw
M_FLIST += *.sim
M_FLIST += .Xil
M_FLIST += parallella.bit.bin
M_FLIST += system_wrapper.bit.bin

BIN  = ${PWD}/../bin
HDL  = ${PWD}/../hdl
TV2V = ${BIN}/tv2v.py

.PHONY: all hdl clean


all: $(M_DEPS) hdl
	source /cad/Xilinx/Vivado/2015.2/settings64.sh; \
		export PATH=$$PATH:/cad/Xilinx/Vivado/2015.2/bin;\
		./build.sh


hdl:
	-mkdir build
	${TV2V} -i ${HDL}/load.tv -o ./build/load.v
	${TV2V} -i ${HDL}/siacore.tv -o ./build/siacore.v
	cp ${HDL}/*.v ./build/.
	cd build;emacs --batch -l ${BIN}/verilog-mode.el *.v -f verilog-batch-auto

clean:
	rm -rf build
	rm -rf $(M_FLIST)
