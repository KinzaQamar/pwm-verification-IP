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
// Revision Date:  15-MAY-2022                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

interface pwm_interface;

	import uvm_pkg::*;        	 //Import uvm base classes
	import base_class_pkg ::*;	 //Import component classes
  `include "uvm_macros.svh"    //Includes uvm macros utility

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
    $display("//////////////////////////////////////////INTERFACE transaction METHODS//////////////////////");
    $display(" rst_ni  = 0x%0h",rst_ni );    
    $display(" write   = 0x%0h",write  );
    $display(" addr_i  = 0x%0h",addr_i );
    $display(" wdata_i = 0x%0h",wdata_i);
    $display(" rdata_o = 0x%0h",rdata_o);
    $display(" o_pwm   = 0x%0h",o_pwm  );
    $display(" o_pwm_2 = 0x%0h",o_pwm_2);
    $display(" oe_pwm1 = 0x%0h",oe_pwm1);
    $display(" oe_pwm2 = 0x%0h",oe_pwm2);    
    //$display("rst_ni = 0x%0h \nwrite = %0d \naddr_i = %0d \nwdata_i = %0h \nrdata_o = %0d \no_pwm = %0d \no_pwm_2 = %0d \noe_pwm1 = %0d \noe_pwm2 = %0d" , rst_ni, write, addr_i, wdata_i, rdata_o, o_pwm, o_pwm_2, oe_pwm1, oe_pwm2);
    $display("//////////////////////////////////////////INTERFACE transaction METHODS//////////////////////");
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
    $display("//////////////////////////////////////////INTERFACE print_interface_transaction METHOD//////////////////////");
    $display(" tx.rst_ni  = 0x%0h",tx.rst_ni );    
    $display(" tx.write   = 0x%0h",tx.write  );
    $display(" tx.addr_i  = 0x%0h",tx.addr_i );
    $display(" tx.wdata_i = 0x%0h",tx.wdata_i);
    $display(" tx.rdata_o = 0x%0h",tx.rdata_o);
    $display(" tx.o_pwm   = 0x%0h",tx.o_pwm  );
    $display(" tx.o_pwm_2 = 0x%0h",tx.o_pwm_2);
    $display(" tx.oe_pwm1 = 0x%0h",tx.oe_pwm1);
    $display(" tx.oe_pwm2 = 0x%0h",tx.oe_pwm2);
    //$display("tx.rst_ni = %0d \ntx.write = %0d \ntx.addr_i = %0d \ntx.wdata_i = %0h \ntx.rdata_o = %0d \ntx.o_pwm = %0d \ntx.o_pwm_2 = %0d \ntx.oe_pwm1 = %0d \ntx.oe_pwm2 = %0d" , tx.rst_ni, tx.write, tx.addr_i, tx.wdata_i, tx.rdata_o, tx.o_pwm, tx.o_pwm_2, tx.oe_pwm1, tx.oe_pwm2);
    $display("//////////////////////////////////////////INTERFACE print_interface_transaction METHOD//////////////////////");
	endtask // task automatic print_interface_transaction (pwm_item tx);

endinterface