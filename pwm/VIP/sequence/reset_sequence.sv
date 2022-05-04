/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:        MICRO-ELECTRONICS RESEARCH LABORATORY                                               //
//                                                                                                     //
// Engineers:      Kinza Qamar Zaman - Verification                                                    //
//                                                                                                     //
// Additional contributions by:                                                                        //
//                                                                                                     //
// Create Date:    19-APRIL-2022                                                                       //
// Design Name:    PWM Verification IP                                                                 //
// Module Name:    reset_sequence.sv                                                                   //
// Project Name:   PWM Verification IP.                                                                //
// Language:       SystemVerilog - UVM                                                                 //
//                                                                                                     //
// Description:                                                                                        //
//         reset_sequence generates rst_ni values to set or reset the DUT registers.  				  			 //
// Revision Date:  3rd-May-2022                                                                        //
/////////////////////////////////////////////////////////////////////////////////////////////////////////
class reset_sequence extends uvm_sequence # (tx_item);

    //Factory Registration
	`uvm_object_utils(reset_sequence)

	//Constructor
	function new(string name="reset_sequence");
		super.new(name);
	endfunction

//////////////////////////////////////////Running a sequence/////////////////////////////////////////////

  virtual task body();
		tx_item tx;
	//repeat(1) begin 			        								//generate transactions for n times
			tx = tx_item::type_id::create("tx"); 				//Body task creates transaction using factory creation
			start_item(tx);		                  				/*start item. sequence body() blocks waiting for driver 
																										to be ready.Driver ask about sending transaction in 
																										its run phase.*/				
																									//Wait for driver to be ready
			if (!tx.randomize())		           					//Randomize transaction
				`uvm_fatal("Fatal","Randomization Failed")
			tx.rst_ni  = 1'h0;
			finish_item(tx);		          					    /*Sends transaction and waits for response from driver 
		  																							to know when it is ready again to generate and send 
																									  transactions again.*/
	//end
	endtask //  virtual task body();

	//////////////////////////////////////////Running a sequence/////////////////////////////////////////////

	//After the body() methods returns , it passes the control back to the test.

endclass	