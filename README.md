# Digital Design 1: Project 2: Sequential 8-bit Signed Multiplier

## A fully functional Verilog Code and Logisim Evolution simulation files in addition to PDFs of the project plan and schematics.

This project was implemented and tested on the Basys 3 Artix 7 board (Xilinx part number XC7A35T-1CPG236C).

Authors:
- Andrew Antoine
- Mostafa Elfaggal
- Kirolous Fouty
- Youssef Elhagg

### Usage: What the project does when implemented on a Basys 3 board

- takes in input of:
  - two 8-bits signed binary numbers A and B, where digit A is inputted through the leftmost eight switches (R2 till V2), and B is inputted through the rightmost eight switches (W13 till V17), where in both cases, the leftmost switch represents the most significant bit while the rightmost switch represents the least significant bit.
  - start signal is inputted through the downward pushbutton (U17).
  - scroll left is inputted through the leftward pushbutton (W19).
  - scroll right is inputted throguh the rightward pushbutton (T17).
  - clk is connected internally to the board built-in clock (W5).

- shows the output as:
  - the leftmost LED is on when the multiplication is finished (L1).
  - four 7-segment display units, where the leftmost 7-segment unit is used to display the sign (empty when +ve; '-' when -ve), while the rightmost three 7-segment display units are used to represent the product. By default, they represent the rightmost three digits of the product.


### Simulation and Implementation

Verilog File: Project_tb.v

Constraint File: project_const.xdc

Demo 3 Video: (https://drive.google.com/file/d/1uljTUnwgsDP7TtkrhU7ftT0M9LzmvWRW/view?usp=sharing)

For validation, we used a testbench for simulation testing, which was done using iVerilog compiler (but can also be run on Vivado), and a constraint file to implement the Verilog code onto the FPGA board. You can see the final outcome on the board using the video linked above. You can also find a screenshot of the simulation wave at “/sources/Design Sources and Simulations/Simulation/Simulation Wave.png”

To display the simulation pre-created:
```
1- Run “/sources/Design Sources and Simulations/Simulation/simulation_gtkwave.gtkw”
2- This should open up gtkwave with the pre-defined configuration and pre-computed simulation that appears in the screenshot provided
```
To run your own simulation using iVerilog:
```
1- Head to “/sources/Design Sources and Simulations”
2- Ensure that you have iVerilog and gtkwave installed
3- In the terminal type “iverilog -o simulation.out *.v”
4- Type “vvp simulation.out”
5- Head to “Simulation”
6- From which in the terminal type “gtkwave simulation.vcd”
7- Gtkwave should open up showing the wave
```
To create and add source files into a new vivado project:
```
1- Open up vivado and start a new project by click “Create Project”
2- Press Next
3- You may rename or relocate the project folder if needed, otherwise press Next
4- Continue Pressing Next, until prompted about the Default Part (board)
5- Select Boards at the top left
6- Search and select basys 3, then press Next
7- Finally press Finish
8- Once the project is created, click on “Add Sources” under the flow navigator on the left
9- Choose “Add or create design sources”
10- In the window that follows, choose “Add Files”
11- Head to “/sources/Design Sources and Simulations”
12- Excluding the testbench (Project_tb.v), select all .v files (
	- Binary_to_BCD.v
	- clock_divider.v
	- debouncer.v
	- DigitShifter.v
	- mod_n_counter.v
	- multiplier_CU.v
	- multiplier_DP.v
	- Project.v
	- push_button.v
	- rising_edge_detector.v
	- signed_sequential_multiplier.v
	- SSD_render.v
	- synchronize.v
)
13- After selecting the files, click Finish
```
To simulate the testbench using vivado:
```
1- Make sure to have created a vivado project using the steps mentioned above
2- Choose “Add sources”
3- Choose Add or create simulation sources”
4- Choose “Add Files”
5- Head to “/sources/Design Sources and Simulations”
6- Choose “Project_tb.v”
7- Click “Finish”
8- Under “Simulation Sources/sim_1”, Select “Project_tb” as top (if it is already top, ignore this step)
9- Choose “Run Simulation” in the “Flow Navigator” on the left, and “Run Behavioral Simulation” from the popup menu
10- The simulation should run and produce the same results as that of iverilog and gtkwave
```
To implement the verilog code onto an FPGA (Basys 3):
```
1- Make sure to have created a vivado project with the Basys 3 board selected
2- Add the constraint file to the project by clicking “Add sources”
3- Choose “Add or create constraints”
4- Choose “Add Files”
5- Head to “/sources/Constraints”
6- Select “project_const.xdc”
7- Click Finish
8- Finally, to run the project choose “Generate Bitsteam”
9- Choose “Yes” on the popup that follows about running systhesis
10- And Choose “Ok” on the popup to launch runs
11- Wait until, you get “Bitstream Generation Completed”, and then click “Cancel”
12- Make sure your board is properly connected to the PC
13- From the “Flow Navigator” on the left, under “PROGRAM AND DEBUG”, under “Open Hardware Manager”, click on “Open Target”, and choose “Auto Connect”
14- Once connected, click on “Program Device” and choose the first item from the popup menu
15- In the dialog which appears accept the dialog, and the board will be programmed
16- You may begin using the board
```
To flash the FPGA board (Basys 3):
Follow the following tutorial (https://sites.google.com/a/umn.edu/mxp-fpga/home/vivado-notes/programming-the-basys3-boards-non-volatile-flash-memory-through-vivado?pli=1)
