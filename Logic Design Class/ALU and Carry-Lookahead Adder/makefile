
head = header.v
nc = ncverilog

nc_option = +access+r

assignment_name = ALU

#The file name of testbench.
tb = $(assignment_name)_tb.v

#The file name of our modules.
others = $(assignment_name).v
others_syn = $(assignment_name)_syn.v -v /theda21_2/CBDK_IC_Contest/cur/Verilog/tsmc13.v

sdf = +define+SDF

#Combine them together.
srcs = $(tb) $(others)
srcs_syn = $(tb) $(others_syn)

#The log files.
log = *.log ncverilog.history novas_dump.log INCA_libs

#Defalut command is sim.
#If you type "make", makefile will execute "make sim" command.
make::sim

#Run the program.
sim:
	$(nc) $(srcs)

syn:
	$(nc) $(srcs_syn) $(sdf)

check:
	$(nc) -c $(others)

#Use vim to open the file happy_verilog.v.
oo:
	vim $(others)

#Use vim to open the testbench.
ot:
	vim $(tb)

#Clean the log file.
clean:
	rm -rf $(log)

cleaning:
	rm -rf *mr *.pvl *.syn *.X *.svf
