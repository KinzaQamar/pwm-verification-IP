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

//////////////////////////////////////////DATA MEMBERS///////////////////////////////////////////////////

	pwm_config pwm_cfg;				  //handle to configuration object
	env_config env_cfg;				  //handle to configuration object

//////////////////////////////////////////COMPONENTS MEMBERS//////////////////////////////////////////////

	pwm_env env; 

//////////////////////////////////////////VIRTUAL INTERFACE//////////////////////////////////////////////

	virtual pwm_interface vif;  /*If using config_object and setting vif through that than no need to 
																separately describe vif as the test never uses it. */

//////////////////////////////////////////METHODS///////////////////////////////////////////////////////

	//Standard UVM methods
	extern virtual function void build_phase (uvm_phase phase); 
	extern virtual task run_phase (uvm_phase phase);
	extern function void end_of_elaboration_phase (uvm_phase phase);

	//Print method for printing transaction items
//	extern virtual task print_transaction(pwm_item tr);

endclass

//////////////////////////////////////////uvm_config_db get()/////////////////////////////////////////////
/*
	Note the following:
	a-The uvm_config_db::get() method is a function that returns a bit value to indicate whether the object
		retrieval was been successful or not; this is tested to ensure that the testbench does not proceed if 
		the lookup fails.
	b-The uvm_config_db::get() method is parameterised with the virtual interface type so that the right type 
		of object is retrieved from the database.
	c-The first argument of the get() method, context, is passed the handle for the UVM component in which the
		call is being made ... this
	d-The second argument, instance_name, is passed an empty string, "" , this means that only the path string 
		for the component is applied based on the component path string derived from the component handle passed 
		in context (i.e. "uvm_test_top").
	e-The third argument is the uvm_config_db lookup string, this should match the lookup string assigned in 
		the HDL module, in this case "pwm_if".
	d-The fourth argument is the virtual interface handle. In this case the handle is inside a 
		uvm_config_object that will be passed to an agent.
*/
//////////////////////////////////////////uvm_config_db get()/////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------test build phase--------------------------------------------//

	//building the components inside the hierarchy of environment class
	function void pwm_test :: build_phase(uvm_phase phase);
		`uvm_info($sformatf("BUILD PHASE : %s",get_type_name()),
							$sformatf("BUILD PHASE OF %s HAS STARTED !!!",get_type_name()),UVM_LOW);

		//create the config objects and low level components						
		pwm_cfg = pwm_config::type_id::create("pwm_cfg",this);
		env_cfg = env_config::type_id::create("env_cfg",this);
		env     = pwm_env::type_id::create("env",this);

		//Link the two objects together
		env_cfg.pwm_cfg = pwm_cfg;

		//Set the configurations for this test - only values other than default
		env_cfg.enable_coverage = 0;

		/*
		Format to get the configuration settings into the config_db:
		uvm_config_db # (data type) :: get (scope{context(handle to the actual component that is calling the DB),
																				instance}, name of the entry,variable written by the get call) 
		Name of the scope would be : uvm_test_top set by the top module    
		*/ 
		//get the virtual interface handle from the top_hdl 
		if (!uvm_config_db # (virtual pwm_interface) :: get (this,"","pwm_if",pwm_cfg.vif))
			`uvm_fatal(get_type_name(),"NO PWM VIF IN DB");

		//set the environment configuration object into the DB.
		uvm_config_db # (env_config) :: set(this,"env","env_cfg",env_cfg); 	
		 
	endfunction //	function void pwm_test :: build_phase(uvm_phase phase);

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------test build phase--------------------------------------------//

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------test run_phase----------------------------------------------//

	/*Connect phase not required as we have no other component except of 
		an agent class, exist inside the environment hierarchy. */
	task pwm_test :: run_phase (uvm_phase phase);
		pwm_item tx;
		div_sequence seq;
	 	seq = div_sequence::type_id::create("seq");
		phase.raise_objection(this,"Start tx_sequence"); 
		seq.start(env.agt.sqr);
		/*test raises an object and calls the start method in the sequence passing 
			in a handle to the seqr. The sequence start method call body(). */
		phase.drop_objection(this,"End tx_sequence"); /*when the seq body() task return, it drops the objection 
																										telling UVM that the stimulus is done and run_phase() 
																										is over. */
//		print_transaction(tx);																									
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//-----------------------------------print_transaction Method-----------------------------------------//

	/*task pwm_test :: print_transaction(pwm_item tr);
		`uvm_info(get_type_name(),tr.convert2string,UVM_LOW);
		vif.transaction(tr);
		vif.print_interface_transaction(tr);
	endtask // task pwm_driver :: print_transaction(pwm_item tr);*/

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//-----------------------------------print_transaction Method-----------------------------------------//