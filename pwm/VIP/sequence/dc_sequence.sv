/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:        MICRO-ELECTRONICS RESEARCH LABORATORY                                               //
//                                                                                                     //
// Engineers:      Kinza Qamar Zaman - Verification                                                    //
//                                                                                                     //
// Additional contributions by:                                                                        //
//                                                                                                     //
// Create Date:    19-APRIL-2022                                                                       //
// Design Name:    PWM Verification IP                                                                 //
// Module Name:    dc_sequence.sv                                                                      //
// Project Name:   PWM Verification IP.                                                                //
// Language:       SystemVerilog - UVM                                                                 //
//                                                                                                     //
// Description:                                                                                        //
//         dc_sequence generates transactions at a duty cycle register address.   										 //
// Revision Date:                                                                                      //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

class dc_sequence extends uvm_sequence # (tx_item);

    //Factory Registration
	`uvm_object_utils(dc_sequence)

	//Constructor
	function new(string name="dc_sequence");
		super.new(name);
	endfunction

  virtual task body();
			tx_item tx;
			repeat(1) begin 			        											//generate transactions for block size times
			tx = tx_item::type_id::create("tx"); 								//Body task creates transaction using factory creation
			start_item(tx);		                  								//Wait for driver to be ready
			if (!tx.randomize())		           									//Randomize transaction
				`uvm_fatal("Fatal","Randomization Failed")
			tx.addr_i  = 8'hc;																	//Address to set Duty cycle for channel 1
			tx.rst_ni  = 1'h1;
			tx.write   = 1'h1;
			finish_item(tx);		          					    				/*Sends transaction and waits for response from driver 
																														to know when it is ready again to generate and send 
																											  		transactions again.*/
			end
	endtask
	
endclass