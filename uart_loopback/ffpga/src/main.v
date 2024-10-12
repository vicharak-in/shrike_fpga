(* top *) module uart_loopback ((* iopad_external_pin , clkbuf_inhibit *)input clk,
                     (* iopad_external_pin *) output clk_en,
                    (* iopad_external_pin *)  input rst,
                     (* iopad_external_pin *) input rx,
                     (* iopad_external_pin *) output tx,
                     (* iopad_external_pin *) output tx_en,
                     (* iopad_external_pin *) output o_tx_done,
                     (* iopad_external_pin *) output o_tx_done_en,
                    (* iopad_external_pin *)  output o_rx_done,
                    (* iopad_external_pin *)  output o_rx_done_en
                          );


	
	reg i_tx_start;
	wire o_rx_done;
	reg [7:0] i_tx_data;
	reg [7:0] o_rx_data;
	
	// enables outputs
	
	assign clk_en = 1'b1;
	assign o_tx_done_en = 1'b1;
	assign o_rx_done_en = 1'b1;
	assign tx_en = 1'b1;
	
	
 uart_transceiver dut (
    .i_clk             (clk), //
    .i_rst             (rst), //
    .i_tx_start        (i_tx_start), //
    .i_tx_data         (i_tx_data), //
    .o_tx              (tx),  //
    .o_tx_done         (o_tx_done), //
    .i_rx              (rx), //
    .o_rx_data         (o_rx_data), //
    .o_rx_done         (o_rx_done)  //
  );
  
  
  always @ (posedge clk) begin 
  	if (o_rx_done) begin 
  		i_tx_data <= o_rx_data;
  		i_tx_start <= 1'b1;
  	end 
  	else begin 
  		i_tx_start <= 1'b0;
  	end
  
  end 
  
  endmodule 