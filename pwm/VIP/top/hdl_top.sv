/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:        MICRO-ELECTRONICS RESEARCH LABORATORY                                               //
//                                                                                                     //
// Engineers:      Kinza Qamar Zaman - Verification                                                    //
//                                                                                                     //
// Additional contributions by:                                                                        //
//                                                                                                     //
// Create Date:    20-MARCH-2022                                                                       //
// Design Name:    PWM Verification IP                                                                 //
// Module Name:    top.sv                                                                              //
// Project Name:   PWM Verification IP.                                                                //
// Language:       SystemVerilog - UVM                                                                 //
//                                                                                                     //
// Description:                                                                                        //
//             Top module is responsible to run tx_Test. We pass tx_test as a UVM_TESTNAME on          //
// 			   		 the commmand line. run_test() gets the name of the test from the commandline            //
//             and execute uvm_phases.		                                                             //
// Revision Date:                                                                                      //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

module hdl_top;

	import uvm_pkg::*;        	 //Import uvm base classes
	import base_class_pkg ::*;	 //Import component classes
  `include "uvm_macros.svh"    //Includes uvm macros utility

	pwm_interface pwm_if();

	initial begin
		/*
		Format to set the configuration settings into the config_db:
		uvm_config_db */                                                          
		uvm_config_db # (virtual pwm_interface) :: set(null,"uvm_test_top","pwm_if",pwm_if);
		run_test();    				     //run_test start execution of uvm phases
	end 
	
endmodule 