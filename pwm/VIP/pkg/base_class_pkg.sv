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

	import uvm_pkg::*;
  `include "uvm_macros.svh"

  typedef class pwm_item;
  typedef class ctrl_sequence;
  typedef class div_sequence;
  typedef class dc_sequence;
  typedef class reset_sequence;
  typedef class period_sequence;
  typedef class pwm_driver;
  typedef class pwm_agent;
  typedef class pwm_test;

  `include "../test/pwm_test.sv"
  `include "../agent/pwm_agent.sv"
  `include "../driver/pwm_driver.sv"
  `include "../sequence/ctrl_sequence.sv"
  `include "../sequence/dc_sequence.sv"
  `include "../sequence/div_sequence.sv"
  `include "../sequence/period_sequence.sv"
  `include "../sequence/reset_sequence.sv"
  `include "../sequence_item/pwm_item.sv"

endpackage