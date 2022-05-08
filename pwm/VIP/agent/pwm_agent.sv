/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:        MICRO-ELECTRONICS RESEARCH LABORATORY                                               //
//                                                                                                     //
// Engineers:      Kinza Qamar Zaman - Verification                                                    //
//                                                                                                     //
// Additional contributions by:                                                                        //
//                                                                                                     //
// Create Date:    20-MARCH-2022                                                                       //
// Design Name:    PWM Verification IP                                                                 //
// Module Name:    pwm_agent.sv                                                                        //
// Project Name:   PWM Verification IP.                                                                //
// Language:       SystemVerilog - UVM                                                                 //
//                                                                                                     //
// Description:                                                                                        //
//            pwm_agent builds and connects driver and sequencer.                                      //
// Revision Date:                                                                                      //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

class pwm_agent extends uvm_agent;

	//Factory registration
	`uvm_component_utils(pwm_agent)

	//constructor
	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction

//////////////////////////////////////////DATA MEMBERS///////////////////////////////////////////////////

	//agent_config agt_cfg; 												 //handle to configuration object

//////////////////////////////////////////COMPONENTS MEMBERS//////////////////////////////////////////////

	pwm_driver drv;
	pwm_monitor mon;
	uvm_sequencer #(pwm_item) sqr; 								   //Never extended
	uvm_analysis_port #(pwm_item) dut_in_tx_port; 	 //Port for sending input transactions
	uvm_analysis_port #(pwm_item) dut_out_tx_port;	 //Port for sending output transactions

//////////////////////////////////////////METHODS////////////////////////////////////////////////////////

	//Standard UVM methods:
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);	

endclass

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------build_phase Method------------------------------------------//

	//building the components inside the hierarchy of agent class
	function void pwm_agent :: build_phase(uvm_phase phase);
	//get configuration information. Will be covered in later examples
	//	agt_cfg = new();	
		mon = pwm_monitor::type_id::create("mon",this);
		dut_in_tx_port  = new("dut_in_tx_port",this);
		dut_out_tx_port = new("dut_out_tx_port",this);
	//	if (agt_cfg.active == UVM_ACTIVE) begin
				drv = pwm_driver::type_id::create("drv",this);
				sqr = new("sqr",this);
	//	end
	endfunction //	function void pwm_agent :: build_phase(uvm_phase phase);

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------build_phase Method------------------------------------------//

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------connect_phase Method----------------------------------------//

	//connecting the components inside the hierarchy of agent class
	/*The TLM connection between the components would follow the pattern as:
		intiator.port.connect(target.port)
	*/
	function void pwm_agent :: connect_phase(uvm_phase phase);
		//connect monitor input and output analysis port to the agent's port.
		//Note that /*this*/ handle is optional.	
		mon.dut_in_tx_port.connect(this.dut_in_tx_port);
		mon.dut_out_tx_port.connect(this.dut_out_tx_port);
		// Only connect the driver and the sequencer if active
		//if (agt_cfg.active == UVM_ACTIVE) begin
				// The agent is actively driving stimulus
				// Driver-Sequencer TLM connection
				drv.seq_item_port.connect(sqr.seq_item_export); //Can't connect in build phase
				// Virtual interface assignment
						//...
			//end
	endfunction //	function void pwm_agent :: connect_phase(uvm_phase phase);	

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------connect_phase Method----------------------------------------//