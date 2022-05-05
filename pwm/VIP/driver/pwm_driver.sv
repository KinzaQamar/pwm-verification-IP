/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:        MICRO-ELECTRONICS RESEARCH LABORATORY                                               //
//                                                                                                     //
// Engineers:      Kinza Qamar Zaman - Verification                                                    //
//                                                                                                     //
// Additional contributions by:                                                                        //
//                                                                                                     //
// Create Date:    20-APRIL-2022                                                                       //
// Design Name:    PWM Verification IP                                                                 //
// Module Name:    pwm_driver.sv                                                                       //
// Project Name:   PWM Verification IP.                                                                //
// Language:       SystemVerilog - UVM                                                                 //
//                                                                                                     //
// Description:                                                                                        //
//          	 pwm_driver drives the configurations to the DUT via virtual interface.                  //
// Revision Date:  5-MAY-2022                                                                          //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

class pwm_driver extends uvm_driver #(pwm_item);

	//Factory Registration
	`uvm_component_utils(pwm_driver)

	//constructor
	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction

	//virtual pwm_interface vif;
	//agent_congig agt_cfg;

	extern virtual function void build_phase (uvm_phase phase);
	extern virtual task run_phase(uvm_phase phase);
	extern virtual task transfer(pwm_item tr);

endclass 

	/*function void pwm_driver :: build_phase (uvm_phase phase);
		if(!uvm_config_db #(agent_cfg)::get(this,"","agt_cfg",agt_cfg))
			`uvm_fatal("DRIVER","driver failed to get the virtual interface");
		vif = agt_cfg.vif;
	endfunction //function void pwm_driver :: build_phase (uvm_phase phase); */

	task pwm_driver :: run_phase(uvm_phase phase);

		// 1- Declare the sequence item handle
		pwm_item tx;
		forever begin
			// 2- Request a new transaction
			seq_item_port.get_next_item(tx);  /*Driver call get_next_item which blocks the driver until sequence send transaction 
																					handle to the driver by calling finish item. This action unblocks the sequence. 
																					seq_item_port is a blocking tlm port declare and constructed inside the driver.*/
			// 3- Send transaction to the DUT
			//vif.transaction(tx); 						//transfer the item to the dut via virtual interface
			transfer(tx); 
			// 4- Driver is done with the transaction
			seq_item_port.item_done(); 			 	/*When the transaction completes, the driver calls item_done() to tell the seq it is
			 																		done with the item. This call unblocks the sequence. */
			// 5 - Send response
		end

	endtask //task pwm_driver :: run_phase(uvm_phase phase);

	task pwm_driver :: transfer(pwm_item tr);
		`uvm_info("PWM SEQUENCE ITEMS",$sformatf("tr.rst_ni  = %0d",tr.rst_ni ),UVM_LOW);
		`uvm_info("PWM SEQUENCE ITEMS",$sformatf("tr.write   = %0d",tr.write  ),UVM_LOW);
		`uvm_info("PWM SEQUENCE ITEMS",$sformatf("tr.addr_i  = %0d",tr.addr_i ),UVM_LOW);
		`uvm_info("PWM SEQUENCE ITEMS",$sformatf("tr.wdata_i = %0d",tr.wdata_i),UVM_LOW);
		`uvm_info("PWM SEQUENCE ITEMS",$sformatf("tr.rdata_o = %0d",tr.rdata_o),UVM_LOW);
		`uvm_info("PWM SEQUENCE ITEMS",$sformatf("tr.o_pwm   = %0d",tr.o_pwm  ),UVM_LOW);
		`uvm_info("PWM SEQUENCE ITEMS",$sformatf("tr.o_pwm_2 = %0d",tr.o_pwm_2),UVM_LOW);
		`uvm_info("PWM SEQUENCE ITEMS",$sformatf("tr.oe_pwm1 = %0d",tr.oe_pwm1),UVM_LOW);
		`uvm_info("PWM SEQUENCE ITEMS",$sformatf("tr.oe_pwm2 = %0d",tr.oe_pwm2),UVM_LOW);
	endtask //task pwm_driver :: transfer(pwm_item tr);

/*NOTE: This driver class is just a sample. 








