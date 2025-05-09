### TASK

You recently showcased your multiplier design to your supervisors at ToyStory (Pvt) Ltd., 
and they were highly impressed! However, today, the Chief Security Officer (CSO) was 
absent, meaning you couldn’t hand over your design for safekeeping. 
Since you don’t want your hard work to be misplaced or accessed by unauthorized people, 
you decide to design a Digital safe lock using an FPGA to protect your work. This lock will 
ensure that only those who know the 4-bit secret code can unlock your locker.  
How the Lock Works 

1. The system will take a 4-bit parallel input as the secret passcode. 
2. This passcode is then converted into a serial format using an AXI parallel to serial 
conversion method with a shift register. 
3. The serial data is sent to a finite state machine (FSM) that operates in states: 
○ This state machine will check bit by bit. 
○ If any input bit is wrong FSM should output an incorrect signal. 
○ Finally, code is correct then FSM should output a correct signal.  
4. If the correct code is entered, the safe unlocks. Otherwise, it remains locked. 

Your task is to design and implement this digital unlocking mechanism using SystemVerilog 
and test its functionality. You need to design for both Meely and Moore machines. 
Use 1011 as security code