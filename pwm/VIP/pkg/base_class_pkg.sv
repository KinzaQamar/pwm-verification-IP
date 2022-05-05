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

package pkg;

    `include "uvm_macros.svh"
	import uvm_pkg::*;

    typedef class pwm_item;
    typedef class ctrl_sequence #(pwm_item);
    typedef class div_sequence #(pwm_item);
    typedef class dc_sequence #(pwm_item);
    typedef class reset_sequence #(pwm_item);
    typedef class period_sequence #(pwm_item);
    typedef class pwm_driver #(pwm_item);

    `include "../sequence_item/tx_item.sv"
    //`include "../interface/pwm_interface.sv"
    //`include "../config_obj/pwm_config.sv"
    //`include "../config_obj/env_config.sv"
    `include "../sequence/ctrl_sequence.sv"
    `include "../sequence/dc_sequence.sv"
    `include "../sequence/div_sequence.sv"
    `include "../sequence/period_sequence.sv"
    `include "../sequence/reset_sequence.sv"
    //`include "../virtual_sequence/pwm_vseq.sv"
    `include "../driver/pwm_driver.sv"
    `include "../test/test.sv"
    `include "../top/hdl_top.sv"

endpackage