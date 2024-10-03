
(* top *) module counter(
(* iopad_external_pin, clkbuf_inhibit *) input clk,
	(* iopad_external_pin *) input nreset,
	(* iopad_external_pin *) input up_down,
	(* iopad_external_pin *) output [3:0]out_oe,
	(* iopad_external_pin *) output osc_en,
	(* iopad_external_pin *) output[3:0] counter
);
 
     reg [3:0] counter_up_down;
     //Output enable need to be specified only for outputs
     assign out_oe = 4'b1111;
  
 	 //OSC
  	 assign osc_en = 1'b1;
  	 

   always @(posedge clk or negedge nreset) begin
        if (!nreset)
            counter_up_down <= 4'h0;
        else if (up_down)
            counter_up_down <= counter_up_down + 4'd1; // if up_down = 1
        else
            counter_up_down <= counter_up_down - 4'd1; // if up_down = 0
    end

   assign counter = counter_up_down;

endmodule
