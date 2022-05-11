/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:        MICRO-ELECTRONICS RESEARCH LABORATORY                                               //
//                                                                                                     //
// Engineers:      Kinza Qamar Zaman - Verification                                                    //
//                                                                                                     //
// Additional contributions by:                                                                        //
//                                                                                                     //
// Create Date:    25-APRIL-2022                                                                       //
// Design Name:    PWM Verification IP                                                                 //
// Module Name:    pkg.sv                                                                              //
// Project Name:   PWM Verification IP.                                                                //
// Language:       SystemVerilog - UVM                                                                 //
//                                                                                                     //
// Description:                                                                                        //
//             The package includes all the base and derived classes related to VIP.                   //
// Revision Date:                                                                                      //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

package base_class_pkg;

  // Standard UVM import & include:
	import uvm_pkg::*;         //Import uvm base classes
  `include "uvm_macros.svh"  //Includes uvm macros utility

////////////////////////////////Any further package imports////////////////////////////////////////////////

////////////////////////////////Any further package imports////////////////////////////////////////////////

////////////////////////////////Forward class declaration////////////////////////////////////////////////

  typedef class pwm_item;
  typedef class ctrl_sequence;
  typedef class div_sequence;
  typedef class dc_sequence;
  typedef class reset_sequence;
  typedef class period_sequence;
  typedef class pwm_driver;
  typedef class pwm_agent;
  typedef class pwm_test;
  typedef class pwm_env;
  typedef class pwm_monitor;
  
////////////////////////////////Forward class declaration////////////////////////////////////////////////

//////////////////////////////////////Include files//////////////////////////////////////////////////////

  `include "../test/pwm_test.sv"
  `include "../agent/pwm_agent.sv"
  `include "../driver/pwm_driver.sv"
  `include "../sequence/ctrl_sequence.sv"
  `include "../sequence/dc_sequence.sv"
  `include "../sequence/div_sequence.sv"
  `include "../sequence/period_sequence.sv"
  `include "../sequence/reset_sequence.sv"
  `include "../sequence_item/pwm_item.sv"
  `include "../monitor/pwm_monitor.sv"
  `include "../env/pwm_env.sv"

//////////////////////////////////////Include files//////////////////////////////////////////////////////

endpackage