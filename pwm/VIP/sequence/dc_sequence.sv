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
// Revision Date:  3rd-May-2022                                                                                      //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

class dc_sequence extends uvm_sequence # (tx_item);

    //Factory Registration
	`uvm_object_utils(dc_sequence)

	//Constructor
	function new(string name="dc_sequence");
		super.new(name);
	endfunction

/////////////////////////////////////////////////////////////////////////////////////////////////////////
/*The two most important properties of a sequence are the body method and the sequencer handle. 
	
	The body Method:
	An uvm_sequence contains a task method called body. It is the content of the body method that determines 
	what the sequence does.
	
	The sequencer Handle:
	When a sequence is started it is associated with a sequencer. The sequencer handle contains the 
	reference to the sequencer on which the sequence is running. The sequencer handle can be used to access 
	configuration information and other resources in the UVM component hierarchy.
*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////

  virtual task body();
			tx_item tx;
			repeat(1) begin 			        											//generate transactions for block size times
			tx = tx_item::type_id::create("tx"); 								//Body task creates transaction using factory creation
			start_item(tx);		                  								/*start item. sequence body() blocks waiting for driver to 
			                                       								be ready.Driver ask about sending transaction in its run phase.*/				
																													//Wait for driver to be ready
			if (!tx.randomize())		           									//Randomize transaction
				`uvm_fatal("Fatal","Randomization Failed")
			tx.addr_i  = 8'hc;																	//Address to set Duty cycle for channel 1
			tx.rst_ni  = 1'h1;
			tx.write   = 1'h1;
			finish_item(tx);		          					    				/*Sends transaction and waits for response from driver 
																														to know when it is ready again to generate and send 
																											  		transactions again.*/
			end
	endtask //  virtual task body();

	//After the body() methods returns , it passes the control back to the test.

endclass