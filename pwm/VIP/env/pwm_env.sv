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

//////////////////////////////////////////DATA MEMBERS///////////////////////////////////////////////////

	pwm_config pwm_cfg;				  //handle to configuration object
	env_config env_cfg;				  //handle to configuration object


//////////////////////////////////////////COMPONENTS MEMBERS//////////////////////////////////////////////

	pwm_agent agt;

//////////////////////////////////////////METHODS///////////////////////////////////////////////////////

	// Standard UVM Methods:	
	extern virtual function void build_phase(uvm_phase phase);

endclass

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------Env build phase---------------------------------------------//

	//building the components inside the hierarchy of environment class
	function void pwm_env :: build_phase(uvm_phase phase);
		`uvm_info($sformatf("BUILD PHASE : %s",get_type_name()),
							$sformatf("BUILD PHASE OF %s HAS STARTED !!!",get_type_name()),UVM_LOW);

		//create the config objects and low level components						
		agt = pwm_agent::type_id::create("agt",this);
		pwm_cfg = pwm_config::type_id::create("pwm_cfg",this);
		env_cfg = env_config::type_id::create("env_cfg",this);

		//get the environment configuration object from the DB
		if (!uvm_config_db # (env_config) :: get (this,"","env_cfg",env_cfg))
			`uvm_fatal(get_type_name(),"NO ENVIRONMENT CONFIGURATION OBJECT FOUND !!");	

		//set the PWM configuration object into the DB.
		uvm_config_db # (pwm_config) :: set (this,"agt*","env_cfg",env_cfg.pwm_cfg); 	

		if (env_cfg.enable_coverage) begin
			`uvm_info($sformatf("COVERAGE ENABLED AT : %s",get_type_name()),
								"CREATING COVERAGE COLLECTOR !!!",UVM_LOW);		
		//	cov = cov_collector::typeid::create("cov",this);
		end

		if (env_cfg.enable_scoreboard) begin
			`uvm_info($sformatf("SCOREBOARD ENABLED AT : %s",get_type_name()),
								"CREATING SCOREBOARD !!!",UVM_LOW);			
		//	scb = pwm_scoreboard::typeid::create("scb",this);
		end
		
		endfunction // 	function void pwm_env :: build_phase(uvm_phase phase);

	/*Connect phase not required as we have no other component except of 
	  an agent class, exist inside the environment hierarchy. */

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------Env build phase---------------------------------------------//