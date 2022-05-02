/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:        MICRO-ELECTRONICS RESEARCH LABORATORY                                               //
//                                                                                                     //
// Engineers:      Kinza Qamar Zaman - Verification                                                    //
//                                                                                                     //
// Additional contributions by:                                                                        //
//                                                                                                     //
// Create Date:    13-APRIL-2022                                                                       //
// Design Name:    PWM Verification IP                                                                 //
// Module Name:    pwm_item.sv                                                                         //
// Project Name:   PWM Verification IP.                                                                //
// Language:       SystemVerilog - UVM                                                                 //
//                                                                                                     //
// Description:                                                                                        //
//         The pwm_item class extends from uvm_sequence_item is used to generate random transaction    //
//         items for PWM portlist.                                                                     //
// Revision Date:  02-MAY-2022                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

class pwm_item extends uvm_sequence_item;

	//Factory Registration
	`uvm_object_utils(pwm_item) 
	/*Sequencer or transactions are object classes so use object utility macros to register it into the 
	  factory */

	//Constructor
	function new (string name="pwm_item");
		super.new(name);
	endfunction

	//PWM items	
	rand 	 bit 								rst_ni ;		
	rand 	 bit        				write  ;	
	rand 	 bit 			[7:0]			addr_i ;	
	rand 	 bit 			[31:0]		wdata_i;
			 logic      [31:0]		rdata_o;
			 logic    	 					o_pwm  ;
			 logic 		   			  	o_pwm_2;
			 logic    	  				oe_pwm1;
			 logic    	  				oe_pwm2;
	
	//virtual method to operate on transactions:
	extern virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
	extern virtual function void do_copy(uvm_object rhs);
	extern virtual function string convert2string();
	extern virtual function void do_print(uvm_printer printer);
	extern virtual function void do_pack();
	extern virtual function void do_unpack();
	extern virtual function void do_record();
	
endclass

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------do_copy Method----------------------------------------------//
	
	//Virtual Copy method 
	/*Copies the object pointing to source handle into the object pointing to destination 
	  handle ---> (dst.copy(src)) */
	//There are 3 steps to do this:
	//1: Create the do_copy method
	function void pwm_item :: do_copy(uvm_object rhs);

	//2nd: Declare new handle and cast the argument to this handle
	/*As pwm_item properties are not visible from just the uvm_object handle, declare new handle 
	  that points to pwm_item object. */
			pwm_item tx_rhs;
	//cast the argument rhs to tx_rhs
			if (!$cast(tx_rhs,rhs))   //At run time SV checks the object type of both the handles through $cast
				`uvm_fatal(get_type_name(),"Illegal rhs arguments:"); 
			super.do_copy(rhs);		   /*There may be properties in uvm_seq_item class that need to be copied so 
																 call super.docopy() passing in the rhs handle.*/

	//3rd(a): Copy object properties
			this.rst_ni	 = tx_rhs.rst_ni	;
			this.write   = tx_rhs.write   ;	
			this.addr_i  = tx_rhs.addr_i  ;
			this.wdata_i = tx_rhs.wdata_i ;
			this.rdata_o = tx_rhs.rdata_o ;
			this.o_pwm   = tx_rhs.o_pwm   ;
			this.o_pwm_2 = tx_rhs.o_pwm_2 ;
			this.oe_pwm1 = tx_rhs.oe_pwm1 ;
			this.oe_pwm2 = tx_rhs.oe_pwm2 ;

	//3(b) Above method is shallow. Deep copy any contained objects. 
	/* Example: 
			if((aggregated_class_handle != null) && (tx_rhs.aggregated_class_handle != null))
				aggregated_class_handle.do_copy(tx_rhs.aggregated_class_handle)
	*/
	//In this example, we do not have any aggregated class so we skip the 3b step 
	endfunction  //function void pwm_item :: do_copy(uvm_object rhs);

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------do_copy Method----------------------------------------------//

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------do_compare Method-------------------------------------------//
	
	//Virtual compare method
	//Compare method returns match ---> if(actual.compare(expect))
	//There are 3 steps to do this
	//do_compare is used by scoreboards
	//The second argument is used for advance comparison (uvm_comparer comparer)
	/*The uvm_comparer policy object has to be passed to the do_compare() method for compatibility with the 
	  virtual method template, but it is not necessary to use it in the comparison function and performance 
		can be improved by not using it.*/ 
	function bit pwm_item :: do_compare(uvm_object rhs, uvm_comparer comparer);
	//1st: cast uvm_object handle into pwm_item handle so you can access pwm_item properties
	/*As pwm_item properties are not visible from just the uvm_object handle, declare new handle that points 
		to pwm_item object */
		pwm_item tx_rhs;
	// cast the argument rhs to tx_rhs
		if (!$cast(tx_rhs,rhs)) //At run time SV checks the object type of both the handles through $cast
			`uvm_fatal(get_type_name(),"Illegal rhs arguments:"); 

	//Since compare tells us about match or mismatch, we'll include return statement here
	//2nd: Call super.docompare()
	//3rd(a): Compare all properties with the 4-state operator ===

		return  (super.do_compare(rhs, comparer) 		&&	
					  (rst_ni  === tx_rhs.rst_ni)         &&
					  (write   === tx_rhs.write)          &&
					  (addr_i  === tx_rhs.addr_i)         &&
					  (wdata_i === tx_rhs.wdata_i)				&&
						(rdata_o === tx_rhs.rdata_o) 				&&		
						(o_pwm   === tx_rhs.o_pwm)					&&
						(o_pwm_2 === tx_rhs.o_pwm_2)				&&
						(oe_pwm1 === tx_rhs.oe_pwm1)				&&
						(oe_pwm2 === tx_rhs.oe_pwm2))       ;

	//3rd(b)deep compare other contained objects
	/* Example: 
			return  (super.do_compare(rhs, comparer) 			&&	
						  (rst_ni  === tx_rhs.rst_ni)         	&&
						  (write   === tx_rhs.write)          	&&
						  (addr_i  === tx_rhs.addr_i)         	&&
						  (wdata_i === tx_rhs.wdata_i)					&&
							(rdata_o === tx_rhs.rdata_o) 					&&		
							(o_pwm   === tx_rhs.o_pwm)						&&
							(o_pwm_2 === tx_rhs.o_pwm_2)					&&
							(oe_pwm1 === tx_rhs.oe_pwm1)					&&
							(oe_pwm2 === tx_rhs.oe_pwm2))       	&&
						  ((aggregated_class_handle == null)  ? 1 : //Avoid Null handles
							 ((aggregated_class_handle.do_compare(tx_rhs.aggregated_class_handle,comparer)));
	*/
	//In this example, we do not have any aggregated class so we skip the 3b step 
	endfunction //function bit pwm_item :: do_compare(uvm_object rhs, uvm_comparer comparer);

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------do_compare Method-------------------------------------------//

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------convert2string Method---------------------------------------//
	
	//Virtual Convert2string 
	//Convert2string method is used to print transaction objects
	function string pwm_item :: convert2string();
		string s = super.convert2string(); //Get the string with base object properties
		$sformat(s, ":%s\n PWM pwm_item values are : ",s); 
		$sformat(s, ":%s\n rst_ni  = 0x%0x" ,s,rst_ni); 
		$sformat(s, ":%s\n write   = 0x%0x" ,s,write); 
		$sformat(s, ":%s\n addr_i  = 0x%0x" ,s,addr_i); 
		$sformat(s, ":%s\n wdata_i = 0x%0x" ,s,wdata_i); 
		$sformat(s, ":%s\n rdata_o = 0x%0x" ,s,rdata_o); 
		$sformat(s, ":%s\n o_pwm   = 0x%0x" ,s,o_pwm); 
		$sformat(s, ":%s\n o_pwm_2 = 0x%0x" ,s,o_pwm_2); 
		$sformat(s, ":%s\n oe_pwm1 = 0x%0x" ,s,oe_pwm1); 
		$sformat(s, ":%s\n oe_pwm2 = 0x%0x" ,s,oe_pwm2); 
		$sformat(s, ":%s\n result  = 0x%0x" ,s,rdata_o); 

		/* For aggregated class properties,
			 $sformat(s, "%s\n aggregated class  = %s", s,
			 				 (aggregated_class_handle == null) ? "null" : aggregated_class_handle.convert2string()); 
		*/
		return s;
	endfunction  //function string pwm_item :: convert2string();

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------convert2string Method---------------------------------------//

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------do_print Method---------------------------------------------//
	
	/* The do_print() method is called by the uvm_object print() method. Its purpose is to print out a string 
		 representation of an uvm data object using one of the uvm_printer policy classes. The simplest way to 
		 implement the method is to set the printer string to the value returned by the convert2string() method.
	*/

	function void pwm_item :: do_print(uvm_printer printer);
		printer.m_string = convert2string();
	endfunction // 	function void pwm_item :: do_print(uvm_printer printer);

	//uvm_printer is a class called by field macros to format values.

	/*
		An alternative, higher performance version of this would use $display() to print the value returned by
		convert2string(), but this would not allow use of the various features of the various uvm_printer policy 
		classes for	formatting the data.
	*/

	/*function void pwm_item :: do_print(uvm_printer printer);
		$display(convert2string());
	endfunction // 	function void pwm_item :: do_print(uvm_printer printer); */

	/*To achieve full optimization, avoid using the print() and sprint() methods all together and call the 
		convert2string() method directly.*/

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------do_print Method---------------------------------------------//

//*********************************************************************************************************//
/*Some protocols reformats the data and uvm lets you do that. In UVM, pack() and unpack() methods transforms
	sequence_items into arrays of bits, bytes and integers. UVM testbench can record a transaction, by packing
	it into an array and writing it to a file. In later simulations another testbench read the file, unpack 
	the data into transaction and replay the transaction. Writing pack() and unpack() methods depends on the 
	protocol. For now, we left the methods empty.*/

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------do_pack Method----------------------------------------------//

	function void pwm_item :: do_pack (uvm_packer packer);
		return;
	endfunction // function void pwm_item :: do_pack (uvm_packer packer);

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------do_pack Method----------------------------------------------//

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------do_unpack Method--------------------------------------------//

	function void pwm_item :: do_unpack (uvm_packer packer);
		return;
	endfunction // function void pwm_item :: do_unpack (uvm_packer packer);

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------do_unpack Method--------------------------------------------//

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------do_record Method--------------------------------------------//

	function void pwm_item :: do_record (uvm_recorder recorder);
		return;
	endfunction // 	function void pwm_item :: do_record (uvm_recorder recorder);

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//----------------------------------------do_record Method--------------------------------------------//

//*********************************************************************************************************//

/* Note that the rhs argument is of type uvm_object since it is a virtual method, and that it therefore 
	 needs to be cast to the actual transaction type before its fields can be copied.
*/
// Few lines are taken from Universal Verification Methodology cookbook