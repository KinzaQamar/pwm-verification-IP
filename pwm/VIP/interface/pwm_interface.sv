/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:        MICRO-ELECTRONICS RESEARCH LABORATORY                                               //
//                                                                                                     //
// Engineers:      Kinza Qamar Zaman - Verification                                                    //
//                                                                                                     //
// Additional contributions by:                                                                        //
//                                                                                                     //
// Create Date:    20th-APRIL-2022                                                                     //
// Design Name:    PWM Verification IP                                                                 //
// Module Name:    pwm_interface.sv                                                                    //
// Project Name:   PWM Verification IP.                                                                //
// Language:       SystemVerilog - UVM                                                                 //
//                                                                                                     //
// Description:                                                                                        //
//             PWM interface has methods and signals to drive pwm_items to DUT.                        //
// Revision Date:  9-MAY-2022                                                                          //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

interface pwm_interface;

  logic						clk_i;												
	logic						rst_ni;												
	logic						write;										
	logic  [7:0]    addr_i;											
	logic  [31:0]   wdata_i;											
	logic  [31:0]   rdata_o;																								
  logic           o_pwm;
	logic           o_pwm_2;
	logic     	    oe_pwm1;
	logic     	    oe_pwm2;

  modport dut (input  clk_i,
                      rst_ni,	
                      write,		
                      addr_i,	
                      wdata_i,
               output rdata_o,
                      o_pwm,
                      o_pwm_2,
                      oe_pwm1,
                      oe_pwm2 );
	
  modport tb  (output clk_i,
                      rst_ni,
                      write,		
                      addr_i,	
                      wdata_i,
               input  rdata_o,
                      o_pwm,
                      o_pwm_2,
                      oe_pwm1,
                      oe_pwm2 );
    
  task automatic transaction (pwm_item tx);
    rst_ni  = tx.rst_ni;
    write   = tx.write;
    addr_i  = tx.addr_i;
    wdata_i = tx.wdata_i;
    rdata_o = tx.rdata_o;
    o_pwm   = tx.o_pwm;
    o_pwm_2 = tx.o_pwm_2;
    oe_pwm1 = tx.oe_pwm1;
    oe_pwm2 = tx.oe_pwm2;
  endtask // task automatic transaction (pwm_item tx);

  task automatic clk_gen (input bit clk);
    repeat(100) #1ns clk_i = clk;
  endtask // task automatic clk_gen (input bit clk);

	task automatic get_an_input (pwm_item tx);
    tx.rst_ni  = rst_ni  ; 
    tx.write	 = write	 ;	
    tx.addr_i  = addr_i  ;
    tx.wdata_i = wdata_i ;
	endtask // task automatic get_an_input (pwm_item tx);

	task automatic get_an_output (pwm_item tx);
    tx.rdata_o = rdata_o ;
    tx.o_pwm   = o_pwm   ;
    tx.o_pwm_2 = o_pwm_2 ;
    tx.oe_pwm1 = oe_pwm1 ;
    tx.oe_pwm2 = oe_pwm2 ;
	endtask // task automatic get_an_output (pwm_item tx);

  task automatic print_interface_transaction (pwm_item tx);
		get_an_input  (tx);
		get_an_output (tx);
		`uvm_info("INTERFACE SIGNALS",tx.convert2string,UVM_DEBUG);
	endtask // task automatic print_interface_transaction (pwm_item tx);

endinterface