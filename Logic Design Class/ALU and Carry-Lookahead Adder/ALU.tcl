
read_file -format verilog {./ALU.v}
Current design is 'ALU'
analyze -library WORK -format verilog {./ALU.v}
elaborate ALU -architecture verilog -library WORK
compile -exact_map
write -hierarchy -format verilog -output ./ALU_syn.v
write_sdf -version 1.0 -context verilog ALU.sdf
