/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:        MICRO-ELECTRONICS RESEARCH LABORATORY                                               //
//                                                                                                     //
// Engineers:      Kinza Qamar Zaman - Verification                                                    //
//                                                                                                     //
// Additional contributions by:                                                                        //
//                                                                                                     //
// Create Date:    7-MAY-2022                                                                          //
// Design Name:    PWM Verification IP                                                                 //
// Module Name:    pwm_env.sv                                                                          //
// Project Name:   PWM Verification IP.                                                                //
// Language:       SystemVerilog - UVM                                                                 //
//                                                                                                     //
// Description:                                                                                        //
//            pwm_env instantiate the agent in the build phase.                                        //
// Revision Date:                                                                                      //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

class pwm_env extends uvm_env;

	//Factory registration
	`uvm_component_utils(pwm_env)

	//constructor
	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction 

//////////////////////////////////////////COMPONENTS MEMBERS//////////////////////////////////////////////

	pwm_agent agt;

//////////////////////////////////////////METHODS///////////////////////////////////////////////////////

	extern virtual function void build_phase(uvm_phase phase);

endclass

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------env build phase---------------------------------------------//

	//building the components inside the hierarchy of environment class
	function void pwm_env :: build_phase(uvm_phase phase);
		agt = pwm_agent::type_id::create("agt",this);
	endfunction // 	function void pwm_env :: build_phase(uvm_phase phase);

	/*Connect phase not required as we have no other component except of 
	  an agent class, exist inside the environment hierarchy. */