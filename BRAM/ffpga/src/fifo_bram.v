(*top*) module FIFO_BRAM #(
  parameter DEPTH = 3
)(
  (* iopad_external_pin *)input nReset, 
  (* iopad_external_pin, clkbuf_inhibit *)input clk,
 // (* iopad_external_pin, clkbuf_inhibit *) input rclk,
  (* iopad_external_pin *)output clk_en,
//  (* iopad_external_pin *) input wclk_in, 
 // (* iopad_external_pin *) input rclk_in, 
 // (* iopad_external_pin *) output wclk_out, 
 // (* iopad_external_pin *) output rclk_out, 
  (* iopad_external_pin *) input [3:0] DIN,
  (* iopad_external_pin *) input WE,
  (* iopad_external_pin *) input RE,
  (* iopad_external_pin *) output reg [3:0] DOUT,
  (* iopad_external_pin *) output DOUT0_oe,
  (* iopad_external_pin *) output DOUT1_oe,
  (* iopad_external_pin *) output DOUT2_oe,
  (* iopad_external_pin *) output DOUT3_oe,
  (* iopad_external_pin *) output reg FIFO_full,
  (* iopad_external_pin *) output reg FIFO_empty, 
  (* iopad_external_pin *) output FIFO_full_oe,
  (* iopad_external_pin *) output FIFO_empty_oe,
  (* iopad_external_pin *) output [1:0] BRAM0_RATIO,
  (* iopad_external_pin *) output reg [7:0] BRAM0_DATA_IN,
  (* iopad_external_pin *) output reg BRAM0_WEN,
  (* iopad_external_pin *) output reg BRAM0_WCLKEN,
  (* iopad_external_pin *) output reg [8:0] BRAM0_WRITE_ADDR,
  (* iopad_external_pin *) input [3:0] BRAM0_DATA_OUT,
  (* iopad_external_pin *) output reg BRAM0_REN,
  (* iopad_external_pin *) output reg BRAM0_RCLKEN,
  (* iopad_external_pin *) output reg [8:0] BRAM0_READ_ADDR
//  (* iopad_external_pin *) output ext_en0, // external clock 
//  (* iopad_external_pin *) output ext_en1	  // external clock
  );

  reg [DEPTH-1:0] wr_pointer, rd_pointer;
  reg [DEPTH-1:0] wr_pntr_gray, wr_pointer_gray_s;
  reg [DEPTH-1:0] rd_pntr_gray, rd_pointer_gray_s;
  wire [DEPTH-1:0] wr_pointer_next; 
  reg [DEPTH-1:0] rd_pointer_bin;
  wire [DEPTH-1:0]  wr_pointer_gray, rd_pointer_gray; 
  reg [3:0] WE_s,RE_s;
  reg [1:0] nRst_wr, nRst_rd;
  reg [3:0] DIN_s,DIN_pr,BRAM0_DATA_OUT_s;
  wire nReset_wr, nReset_rd;
  integer i;
  
//OE
  assign FIFO_full_oe = 1;
  assign FIFO_empty_oe = 1;
  assign DOUT0_oe = 1;
  assign DOUT1_oe = 1;  
  assign DOUT2_oe = 1;  
  assign DOUT3_oe = 1;
  assign clk_en =1;
//  assign ext_en0 = 1;
// assign ext_en1 = 1;


//clk 
 // assign wclk_out = wclk_in;
//  assign rclk_out = rclk_in;
	
  
  assign BRAM0_RATIO = 2'b01; // active bram0. Change BRAMx to activate other BRAMs
  
  always @(posedge clk) begin
    nRst_wr[0] <= nReset;
    nRst_wr[1] <= nRst_wr[0];
  end
  
  always @(posedge clk) begin
    nRst_rd[0] <= nReset;
    nRst_rd[1] <= nRst_rd[0];
  end
  
  assign nReset_wr = nRst_wr[1] && nReset;
  assign nReset_rd = nRst_rd[1] && nReset;

  always @(posedge clk) begin
    WE_s[0] <= WE;
    WE_s[1] <= WE_s[0];
    WE_s[2] <= WE_s[1];
    WE_s[3] <= WE_s[2];
  end
  
  wire WE_r;
  assign WE_r = WE_s[3] && WE_s[2];
  
  always @(posedge clk) begin
    RE_s[0] <= RE;
    RE_s[1] <= RE_s[0];
    RE_s[2] <= RE_s[1];
    RE_s[3] <= RE_s[2];
  end
  
  wire RE_r;
  assign RE_r = RE_s[3] && RE_s[2];
 
  always @(posedge clk or negedge nReset_wr) begin
    if (!nReset_wr) begin
      wr_pointer <= {DEPTH{1'b0}};
    end else if (WE_r) begin  
      wr_pointer <= wr_pointer + 1;
    end
  end

  assign wr_pointer_next = wr_pointer + 1;
  assign wr_pointer_gray = (wr_pointer >> 1) ^ wr_pointer;
 
  always@* begin
    for (i=0; i<DEPTH; i = i+1) begin
      rd_pointer_bin[i] = ^(rd_pointer_gray_s >> i);
    end
  end

  always @(posedge clk) begin
	rd_pntr_gray <= rd_pointer_gray;
	rd_pointer_gray_s <= rd_pntr_gray;
  end

  always @(posedge clk) begin
	wr_pntr_gray <= wr_pointer_gray;
	wr_pointer_gray_s <= wr_pntr_gray;
  end

  always @(posedge clk or negedge nReset_rd) begin
    if (!nReset_rd) begin
	  rd_pointer <= {DEPTH{1'b0}};
	end else if (RE_r) begin
	  rd_pointer <= rd_pointer + 1;
    end
  end

  assign rd_pointer_gray = (rd_pointer>>1) ^ rd_pointer;

  always @(posedge clk) begin
    BRAM0_DATA_OUT_s = BRAM0_DATA_OUT; 
    BRAM0_READ_ADDR <= rd_pointer;
    DOUT = BRAM0_DATA_OUT_s;
    BRAM0_RCLKEN <= !RE_r;
    BRAM0_REN <= !RE_r;
    FIFO_empty = (rd_pointer_gray == wr_pointer_gray_s);
  end

  always@(posedge clk) begin
    DIN_pr <= DIN;
    DIN_s <= DIN_pr;
    BRAM0_DATA_IN <= DIN_s;
    BRAM0_WRITE_ADDR <= {4'b0000,wr_pointer};
    BRAM0_WEN <= !WE_r;
    BRAM0_WCLKEN <= !WE_r;
    FIFO_full <= (wr_pointer_next == rd_pointer_bin);
  end

endmodule 


