(* top *) module mult_100 ( (* iopad_ecternal_pin *) input [3:0] in,
							(* iopad_ecternal_pin *) input       rst,
							(* iopad_ecternal_pin *) input       start_flag,
							(* iopad_external_pin, clkbuf_inhibit *)input 		clk,
							(* iopad_external_pin *) output        clk_en,
							(* iopad_ecternal_pin *) output  [7:0] out_value,
							(* iopad_ecternal_pin *) output  [7:0] out_value_en,
							(* iopad_ecternal_pin *) output  reg   out_flag,
							(* iopad_ecternal_pin *) output        out_flag_en
                            );
                            
    localparam START = 2'b00,
    		   CAL   = 2'b01,
    		   DONE  = 2'b11;
   
   reg [1:0] STATE = 2'b00;
   reg [3:0] in_hold = 4'b0; 
   reg [7:0] temp_out = 8'b0;
   reg [7:0] count   = 8'b0;
   reg [7:0] final_value = 8'b0;
   
   
   // Output enables 
   
   assign clk_en       = 1'b1;
   assign out_value_en = 8'b1;
   assign out_flag_en  = 1'b1;
   
   always @( posedge clk) begin
  	if (rst) begin 
  		temp_out <= 8'b0;
  		STATE <= START;
  		count<= 8'b0;
  		final_value = 8'b0;
  	end
  	else begin 
  		case (STATE) 
  			START: begin
  				if(start_flag)begin
  					temp_out <= {in,in} ;
  					STATE <= CAL;
  				end
  				else begin 
  					STATE <= START;
  				end
  			end
  			
  			CAL : begin 
  				if ( start_flag && count <= 7'b100) begin
  					temp_out <= temp_out[3:0] * temp_out[7:4];
  					count<= count+1;
  				end 
  				else if ( count == 7'b100) begin 
  					final_value <= temp_out ;
  					out_flag <= 1'b1;
  				end
  			end 
  		endcase
   end 
   end
   assign out_value = final_value;
endmodule
   
   
   
   
    		   