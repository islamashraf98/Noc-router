# Noc-router
Network on chip (NOC) router created using VHDL language.
The router was divided into 9 modules:
1) 8-bit register which is used as an input/output buffer
2) 8-bit multiplexer which is used as switch fabric between input buffer and the queue
3) Dual port RAM (reads and writes) which is used as the memory of the queue for the packets
4) Gray counter which is used in the FIFO controller to move in the memory
5) Gray to binary converter which is used also in the FIFO controller to convert the gray counter into binary so that can be dealt with
6) FIFO controller which manages the read/write requests using FIFO strategy
7) FIFO queue itself which is managed by the FIFO controller and is displayed as the dual port RAM
8) Round Robin schedular which is used between the FIFO queue and the output fabric as a strategy for outputs
9) The 4 port router which is collecting all 8 modules together to form the router and then doing a test strategy for it
