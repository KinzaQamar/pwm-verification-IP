/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:        MICRO-ELECTRONICS RESEARCH LABORATORY                                               //
//                                                                                                     //
// Engineers:      Kinza Qamar Zaman - Verification                                                    //
//                                                                                                     //
// Additional contributions by:                                                                        //
//                                                                                                     //
// Create Date:    20-MARCH-2022                                                                       //
// Design Name:    PWM Verification IP                                                                 //
// Module Name:    pwm_test.sv                                                                         //
// Project Name:   PWM Verification IP.                                                                //
// Language:       SystemVerilog - UVM                                                                 //
//                                                                                                     //
// Description:                                                                                        //
//            The pwm_test class extends from uvm_test is used to start the sequence.                  //
// Revision Date:                                                                                      //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

class pwm_test extends uvm_test;

	//Factory registration
	`uvm_component_utils(pwm_test)
	
	//constructor
	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction

//////////////////////////////////////////COMPONENTS MEMBERS//////////////////////////////////////////////

	/*
		pwm_env env;
		pwm_agent agt;
 */

//////////////////////////////////////////METHODS///////////////////////////////////////////////////////

	//Standard UVM methods
	extern virtual function void build_phase (uvm_phase phase); 
	extern virtual task run_phase (uvm_phase phase);
	extern function void end_of_elaboration_phase (uvm_phase phase);

endclass

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------test build phase--------------------------------------------//

	//building the components inside the hierarchy of environment class
	function void pwm_test :: build_phase(uvm_phase phase);
		agt = pwm_agent::type_id::create("agt",this);
		env = pwm_env::type_id::create("env",this);
	endfunction //	function void pwm_test :: build_phase(uvm_phase phase);

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------test build phase--------------------------------------------//

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------test run_phase----------------------------------------------//

	/*Connect phase not required as we have no other component except of 
		an agent class, exist inside the environment hierarchy. */
	task pwm_test :: run_phase (uvm_phase phase);
		div_sequence seq;
	 	seq = div_sequence::type_id::create("seq");
		phase.raise_objection(this,"Start tx_sequence"); 
		seq.start(agt.sqr);
		/*test raises an object and calls the start method in the sequence passing 
			in a handle to the seqr. The sequence start method call body(). */
		phase.drop_objection(this,"End tx_sequence"); /*when the seq body() task return, it drops the objection 
																										telling UVM that the stimulus is done and run_phase() is over. */
	endtask //	task pwm_test :: run_phase (uvm_phase phase);

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------test run_phase----------------------------------------------//

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------test end_of_elaboration_phase-------------------------------//

	//Print topology report
	function void pwm_test :: end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction // 	function void pwm_test :: end_of_elaboration_phase(uvm_phase phase);

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------test end_of_elaboration_phase-------------------------------//