/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:        MICRO-ELECTRONICS RESEARCH LABORATORY                                               //
//                                                                                                     //
// Engineers:      Kinza Qamar Zaman - Verification                                                    //
//                                                                                                     //
// Additional contributions by:                                                                        //
//                                                                                                     //
// Create Date:    20-MARCH-2022                                                                       //
// Design Name:    Analysis port example                                                               //
// Module Name:    top.sv                                                                              //
// Project Name:   Monitor and Agent analysis port example   		                                       //
// Language:       SystemVerilog - UVM                                                                 //
//                                                                                                     //
// Description:                                                                                        //
//             Top module is responsible to run tx_Test. We pass tx_test as a UVM_TESTNAME on          //
// 			   		 the commmand line. run_test() gets the name of the test from the commandline            //
//             and execute uvm_phases.		                                                             //
// Revision Date:                                                                                      //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

module top;

	import uvm_pkg::*;        	 //Import uvm base classes
	import base_class_pkg ::*;	// Import component classes
  `include "uvm_macros.svh"  //  Includes uvm macros utility

	initial begin
		run_test();    				 //run_test start execution of uvm phases
	end 
	
endmodule 
