// Code your design here
module  fibonaci ((* iopad_external_pin *) input start_flag,
							(* iopad_external_pin, clkbuf_inhibit *)input clk,
							(* iopad_external_pin *)input rst,
							(* iopad_external_pin *)output clk_en,
 							(* iopad_external_pin *)output out_flag,
 							(* iopad_external_pin *)output out_flag_en,
 							(* iopad_external_pin *)output reg fib_flag,
 							(* iopad_external_pin *)output fib_flag_en);
 							
 	localparam WAIT = 2'b00,
 		       CAL   = 2'b01,
 		       DONE  = 2'b11;
 		       
 		       
 	// output enables 
 	
 	assign clk_en = 1'b1;
 	assign fib_flag_en = 1'b1;
 	assign out_flag_en =1'b1;
 		       
 	
 	reg [1:0] STATE;
    reg [68:0] temp_a = 1'b1;
    reg [68:0] temp_b = 1'b0;
 	reg [9:0] fib_num = 0;
 	reg [7:0] count = 0;
 	reg out_flag_reg = 0;
 	reg [68:0] out_num = 0;
 	
 	always @ (posedge clk ) begin
 		if (rst) begin 
 		temp_a <= 1;
 		temp_b <=0;
 		count <= 0;
 		fib_flag <=0;
 		out_flag_reg<=0;
 		
 		STATE <= WAIT;
 		end
 
 		
 		else begin 
 			case (STATE)  
 			WAIT : begin 
 				if (start_flag) begin 
 					STATE<= CAL;
 				end
 				else begin
 					STATE <= WAIT;
 				end 
 			end 
 			CAL : begin 
 				if ( start_flag && count < 7'd100) begin
 				
 					temp_a <= temp_a + temp_b;
 					temp_b <= temp_a ;
 					count  <= count + 1;
 					STATE <= CAL;
 					
 				end
 				else if ( count == 7'd100) begin 
 					fib_num <= temp_a[9:0];
 					out_num <= temp_a;
 					STATE <= DONE;
 					
 				end 
 			end
 			DONE : begin 
 			    out_flag_reg <= 1'b1;
 				STATE <= WAIT;
 				
 				end 
 			
 			endcase 
 		end
 		if ( fib_num == 10'b0011000101 ) begin 
 			fib_flag <= 1'b1; 
 		end 
 		
 	end 
 	
 	assign out_flag = out_flag_reg;
 	
 /*	always @ (posedge clk ) begin 
 		if ( fib_num == 69'b100110011001111011011011101101010011111000101100101001011111111000011 ) begin 
 			fib_flag <= 1'b1; 
 			end 
 		else begin 
 			fib_flag <= 1'b0;
 		end
 	end*/ 
 	
 endmodule