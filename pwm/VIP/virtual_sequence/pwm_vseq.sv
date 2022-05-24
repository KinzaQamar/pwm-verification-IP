/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:        MICRO-ELECTRONICS RESEARCH LABORATORY                                               //
//                                                                                                     //
// Engineers:      Kinza Qamar Zaman - Verification                                                    //
//                                                                                                     //
// Additional contributions by:                                                                        //
//                                                                                                     //
// Create Date:    23-MAY-2022                                                                         //
// Design Name:    PWM Verification IP                                                                 //
// Module Name:    pwm_vseq.sv                                                                         //
// Project Name:   PWM Verification IP.                                                                //
// Language:       SystemVerilog - UVM                                                                 //
//                                                                                                     //
// Description:                                                                                        //
//          	 pwm_vseq is a sequence that creates and start other sequences.         								 //
// Revision Date:                                                                                      //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

class pwm_vseq extends uvm_sequence;

	uvm_sequencer #(pwm_item) pwm_sqr;

	div_sequence div_seq;
	period_sequence period_seq;
	dc_sequence dc_seq;
	ctrl_sequence ctrl_seq;

	task body();
		div_seq = div_sequence::type_id::create("div_seq");
		period_seq = period_sequence::type_id::create("period_seq");
		dc_seq = dc_sequence::type_id::create("dc_seq");
		ctrl_seq = ctrl_sequence::type_id::create("ctrl_seq");
		
		begin
			div_seq.start(pwm_sqr,this);
			period_seq.start(pwm_sqr,this);
			dc_seq.start(pwm_sqr,this);
			ctrl_seq.start(pwm_sqr,this);			
		end
		
	endtask

endclass