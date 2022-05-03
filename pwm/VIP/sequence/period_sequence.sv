/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:        MICRO-ELECTRONICS RESEARCH LABORATORY                                               //
//                                                                                                     //
// Engineers:      Kinza Qamar Zaman - Verification                                                    //
//                                                                                                     //
// Additional contributions by:                                                                        //
//                                                                                                     //
// Create Date:    19-APRIL-2022                                                                       //
// Design Name:    PWM Verification IP                                                                 //
// Module Name:    period_sequence.sv                                                                  //
// Project Name:   PWM Verification IP.                                                                //
// Language:       SystemVerilog - UVM                                                                 //
//                                                                                                     //
// Description:                                                                                        //
//         period_sequence generates transactions at a period register address.  											 //
// Revision Date:                                                                                      //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

class period_sequence extends uvm_sequence # (tx_item);

   //Factory Registration
	`uvm_object_utils(period_sequence)

	//Constructor
	function new(string name="period_sequence");
		super.new(name);
	endfunction

  virtual task body();
			tx_item tx;
			repeat(1) begin 			        											/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:        MICRO-ELECTRONICS RESEARCH LABORATORY                                               //
//                                                                                                     //
// Engineers:      Kinza Qamar Zaman - Verification                                                    //
//                                                                                                     //
// Additional contributions by:                                                                        //
//                                                                                                     //
// Create Date:    19-APRIL-2022                                                                       //
// Design Name:    PWM Verification IP                                                                 //
// Module Name:    period_sequence.sv                                                                  //
// Project Name:   PWM Verification IP.                                                                //
// Language:       SystemVerilog - UVM                                                                 //
//                                                                                                     //
// Description:                                                                                        //
//         period_sequence generates transactions at a period register address.  											 //
// Revision Date:  3rd-May-2022                                                                                      //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

class period_sequence extends uvm_sequence # (tx_item);

   //Factory Registration
	`uvm_object_utils(period_sequence)

	//Constructor
	function new(string name="period_sequence");
		super.new(name);
	endfunction

  virtual task body();
			tx_item tx;
			repeat(1) begin 			        							      //generate transactions for block size times
			tx = tx_item::type_id::create("tx"); 							//Body task creates transaction using factory creation
			start_item(tx);		                  							/*start item. sequence body() blocks waiting for driver to 
			                                       							be ready.Driver ask about sending transaction in its run phase.*/				
																												//Wait for driver to be ready
			if (!tx.randomize())		           								//Randomize transaction
				`uvm_fatal("Fatal","Randomization Failed")
			tx.addr_i = 8'h4;																	//Address to set period for channel 1
			tx.rst_ni = 1'h1;
			finish_item(tx);		          					    			/*Sends transaction and waits for response from driver 
																													to know when it is ready again to generate and send 
																			                	  transactions again. */
			end
	endtask

	//After the body() methods returns , it passes the control back to the test.

endclass