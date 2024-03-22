# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]	
	
#7 segment display
#set_property PACKAGE_PIN W7 [get_ports {display[0]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {display[0]}]
#set_property PACKAGE_PIN W6 [get_ports {display[1]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {display[1]}]
#set_property PACKAGE_PIN U8 [get_ports {display[2]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {display[2]}]
#set_property PACKAGE_PIN V8 [get_ports {display[3]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {display[3]}]
#set_property PACKAGE_PIN U5 [get_ports {display[4]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {display[4]}]
#set_property PACKAGE_PIN V5 [get_ports {display[5]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {display[5]}]
#set_property PACKAGE_PIN U7 [get_ports {display[6]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {display[6]}]

#set_property PACKAGE_PIN V7 [get_ports dp]							
	#set_property IOSTANDARD LVCMOS33 [get_ports dp]

#set_property PACKAGE_PIN U2 [get_ports {digit[0]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {digit[0]}]
#set_property PACKAGE_PIN U4 [get_ports {digit[1]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {digit[1]}]
#set_property PACKAGE_PIN V4 [get_ports {digit[2]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {digit[2]}]
#set_property PACKAGE_PIN W4 [get_ports {digit[3]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {digit[3]}]


##Buttons
#set_property PACKAGE_PIN U18 [get_ports rst]						
#	set_property IOSTANDARD LVCMOS33 [get_ports rst]
 
 
#led
set_property PACKAGE_PIN L1 [get_ports {a}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {a}]
set_property PACKAGE_PIN P1 [get_ports {s}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {s}]
set_property PACKAGE_PIN N3 [get_ports {d}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {d}]
set_property PACKAGE_PIN P3 [get_ports {f}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {f}]
set_property PACKAGE_PIN U3 [get_ports {g}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {g}]
set_property PACKAGE_PIN W3 [get_ports {h}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {h}]
set_property PACKAGE_PIN V3 [get_ports {j}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {j}]
set_property PACKAGE_PIN V13 [get_ports {k}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {k}]
set_property PACKAGE_PIN V14 [get_ports {w}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {w}]
set_property PACKAGE_PIN U14 [get_ports {e}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {e}]
set_property PACKAGE_PIN U15 [get_ports {t}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {t}]
set_property PACKAGE_PIN W18 [get_ports {y}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {y}]
set_property PACKAGE_PIN V19 [get_ports {u}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {u}]

#USB HID (PS/2)
set_property PACKAGE_PIN C17 [get_ports PS2_CLK]						
	set_property IOSTANDARD LVCMOS33 [get_ports PS2_CLK]
	set_property PULLUP true [get_ports PS2_CLK]
set_property PACKAGE_PIN B17 [get_ports PS2_DATA]					
	set_property IOSTANDARD LVCMOS33 [get_ports PS2_DATA]	
	set_property PULLUP true [get_ports PS2_DATA]

##audio stuff
##Pmod Header JB
set_property PACKAGE_PIN A14 [get_ports {pmod_1}]
set_property IOSTANDARD LVCMOS33 [get_ports {pmod_1}]
set_property PACKAGE_PIN A16 [get_ports {pmod_2}]
set_property IOSTANDARD LVCMOS33 [get_ports {pmod_2}]
set_property PACKAGE_PIN B16 [get_ports {pmod_4}]
set_property IOSTANDARD LVCMOS33 [get_ports {pmod_4}]


set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]