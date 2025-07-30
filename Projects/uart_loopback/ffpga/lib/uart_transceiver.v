// ---------------------------------------------------------------------------
// © 2024 Renesas Electronics
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
// OR OTHER DEALINGS IN THE SOFTWARE.
// ---------------------------------------------------------------------------
// Base Module Name: uart_transceiver
// Target Devices: SLG47910
// Tools version:
//   Software: ForgeFPGA Workshop v6.31
//   Hardware: FPGAPAK Development Board Rev.1.0
// Revision:
//   05.11.2021 r001 - New design
//   09.19.2022 r002 - Code style review
//   04.02.2024 r003 - Limits added in the parameters comments
// ---------------------------------------------------------------------------
// Description :
// The UART module (Universal Asynchronous receiver-transmitter) used for asynchronous serial communication, 
// the module function is to convert outgoing data into serial binary stream and vice versa.
// _______      _______________________________________________________
//        \____/_____X_____X_____X_____X_____X_____X_____X_____X_____X   
//       [START][LSB........... DATA FRAME ................MSB][STOP]
// ---------------------------------------------------------------------------

`timescale 1ns/1ps

module uart_transceiver #(
  parameter IN_CLK_HZ         = 50_000_000, // input operating frequency Hz (Type - Decimal, Default value = 50_000_000, Min value = 1_000_000, Max value = 60_000_000)
  parameter DATA_FRAME        = 8,          // number of data bits (5 ~ 9 bits long) (Type - Decimal, Default value = 8, Min value = 5, Max value = 9)
  parameter BAUD_RATE         = 115_200,    // transmitting speed 4_800 - 115_200 (Type - Decimal, Default value = 115_200, Value = [4_800, 9_600, 19_200, 38_400, 57_600, 115_200])
  parameter OVERSAMPLING_MODE = 16,         // bit offset or overlap (Type - Decimal, Default value = 16, Min value = 2, Max value = 32)
  parameter STOP_BIT          = 1,          // length of stop bit (Type - Decimal, Default value = 1, Min value = 1, Max value = 2)
  parameter LSB               = 1'b0        // determine serial data transfer format. "0" = LSB to MSB, "1" = MSB to LSB (Type - Boolean, Default value = 1'b0, Min value = 1'b0, Max value = 1'b1)
) (
  input                       i_clk,        // input clock signal
  input                       i_rst,        // input reset signal
  // tx
  input      [DATA_FRAME-1:0] i_tx_data,    // transmit data inputs
  input                       i_tx_start,   // input (rising edge detect) which enable transmit data
  output                      o_tx,         // tx output carries the output serial data
  output                      o_tx_done,    // done transmit signal
  // rx
  input                       i_rx,         // rx input carries the input serial data
  output     [DATA_FRAME-1:0] o_rx_data,    // receive data outputs
  output                      o_rx_done     // done signal
);

  wire w_tick;

// FSM module transmit data to UART
  uart_transceiver_fsm_uart_tx #(
    .DATA_FRAME        (DATA_FRAME),
    .BAUD_RATE         (BAUD_RATE),
    .OVERSAMPLING_MODE (OVERSAMPLING_MODE),
    .STOP_BIT          (STOP_BIT),
    .LSB               (LSB)
  ) fsm_uart_tx_wrapper (
    .i_clk             (i_clk),
    .i_rst             (i_rst),
    .i_tx_data         (i_tx_data),
    .i_tx_start        (i_tx_start),
    .i_tick            (w_tick),
    .o_tx              (o_tx),
    .o_tx_done         (o_tx_done)
  );

// FSM module receive data to UART
  uart_transceiver_fsm_uart_rx #(
    .DATA_FRAME        (DATA_FRAME),
    .BAUD_RATE         (BAUD_RATE),
    .OVERSAMPLING_MODE (OVERSAMPLING_MODE),
    .STOP_BIT          (STOP_BIT),
    .LSB               (LSB)  
  ) fsm_uart_rx_wrapper (
    .i_clk             (i_clk),
    .i_rst             (i_rst),
    .i_rx              (i_rx),
    .i_tick            (w_tick),
    .o_rx_data         (o_rx_data),
    .o_rx_done         (o_rx_done)
  );

// Module generate one bit period
  uart_transceiver_baud_rate_generator_trx #(
    .BAUD_RATE         (BAUD_RATE),
    .OVERSAMPLING_MODE (OVERSAMPLING_MODE),
    .IN_CLK_HZ         (IN_CLK_HZ)
  ) baud_rate_gen_trx_wrapper (
    .i_clk             (i_clk),
    .i_rst             (i_rst),
    .o_tick            (w_tick)
  );

endmodule

// FSM module transmit data to UART
module uart_transceiver_fsm_uart_tx #(
  parameter DATA_FRAME        = 8,           // number of data bits (5 ~ 9 bits long) (Type - Decimal, Default value = 8, Min value = 5, Max value = 9)
  parameter BAUD_RATE         = 115_200,     // transmitting speed 9_600 - 115_200 (Type - Decimal, Default value = 8, Value = [4_800, 9_600, 19_200, 38_400, 57_600, 115_200])
  parameter OVERSAMPLING_MODE = 16,          // bit offset or overlap (Type - Decimal, Default value = 16, Min value = 2, Max value = 32)
  parameter STOP_BIT          = 1,           // length of stop bit (Type - Decimal, Default value = 1, Min value = 1, Max value = 2)
  parameter LSB               = 1'b0         // determine serial data transfer format. "0" = LSB to MSB, "1" = MSB to LSB (Type - Boolean, Default value = 1'b0, Min value = 1'b0, Max value = 1'b1)
) (
  input                       i_clk,        // input clock signal
  input                       i_rst,        // input reset signal
  input      [DATA_FRAME-1:0] i_tx_data,    // transmit data inputs
  input                       i_tx_start,   // input (rising edge detect) which enable transmit data
  input                       i_tick,       // input signal next bit
  output reg                  o_tx,         // tx output carries the output serial data
  output reg                  o_tx_done     // done signal
);

  localparam IDLE  = 4'b0001;
  localparam START = 4'b0010;
  localparam DATA  = 4'b0100;
  localparam STOP  = 4'b1000;

  localparam STOP_BIT_P1 = (STOP_BIT == 1.5) ? (OVERSAMPLING_MODE / 2) - 1 : 0;
  localparam STOP_BIT_P2 = (STOP_BIT == 1.5) ? 1 : STOP_BIT - 1;

  //FSM variables
  reg [3:0] r_state, r_next;
  reg r_send_data;
  reg r_index_cnt_en;
  reg r_load;
  reg r_cnt_en;
  //wire
  reg w_send_data;
  reg w_index_cnt_en;
  reg w_load;
  reg w_tx;
  reg w_tx_done;
  reg w_cnt_en;

  reg  r_tx_regA; 
  reg  r_tx_regB;
  wire w_tx_r_edge;

  // TX rising edge detector
  always @(posedge i_clk) begin
    r_tx_regA <= i_tx_start;
    r_tx_regB <= r_tx_regA;
  end
  assign w_tx_r_edge = r_tx_regA & ~r_tx_regB;

  // Counter variables
  reg                    [3:0] r_cnt   = 'b0;
  reg [$clog2(DATA_FRAME)-1:0] r_index = 'b0;

  // P2S variables
  reg [DATA_FRAME-1:0] r_tx_buffer;

  // FSM state register
  always @(posedge i_clk) begin
    if (i_rst)
      r_state <= IDLE;
    else
      r_state <= r_next;
  end

  // FSM next assignment state
  always @* begin
    r_next = r_state;
    case (r_state)
      IDLE: begin
        if (w_tx_r_edge) begin
          r_next = START;
        end
      end
      START: begin
        if (r_cnt == 0 && i_tick) begin
          r_next = DATA;
        end
      end
      DATA: begin
        if (r_cnt == 0 && i_tick) begin
          if(r_index == DATA_FRAME-1) begin
            r_next = STOP;
          end
        end
      end
      STOP: begin
        if (i_tick && r_cnt == STOP_BIT_P1 && r_index == STOP_BIT_P2) begin
          r_next = IDLE;
        end
      end
      default: begin
        r_next = IDLE;
      end
    endcase
  end

  // UART control signals
  always @* begin
    w_index_cnt_en = 1'b0;
    w_tx_done      = 1'b0;
    w_send_data    = 1'b0;
    w_cnt_en       = 1'b0;
    w_load         = 1'b0;
    w_tx           = 1'b1;
    case (r_state)
      START: begin
        w_cnt_en = 1'b1;
        w_load   = 1'b1;
        w_tx     = 1'b0;
      end
      DATA: begin
        w_load         = 1'b0;
        w_cnt_en       = 1'b1;
        w_send_data    = 1'b1;
        w_index_cnt_en = 1'b1;
        case (LSB)
          1'b0:    w_tx = r_tx_buffer[0];
          1'b1:    w_tx = r_tx_buffer[DATA_FRAME-1];
          default: w_tx = r_tx_buffer[0];
        endcase
      end
      STOP: begin
        w_load         = 1'b0;
        w_cnt_en       = 1'b1;
        w_send_data    = 1'b0;
        w_tx_done      = 1'b1;
        w_index_cnt_en = 1'b1;
      end
    endcase
  end

  // UART control registers
  always @(posedge i_clk) begin
    if (i_rst) begin
      r_send_data    <= 1'b0;
      r_cnt_en       <= 1'b0;
      r_index_cnt_en <= 1'b0;
      r_load         <= 1'b0;
      o_tx_done      <= 1'b0;
      o_tx           <= 1'b1;
    end else begin
      if (i_tick) begin
        r_send_data <= w_send_data;
      end
      r_cnt_en      <= w_cnt_en;
      r_load        <= w_load;
      o_tx_done     <= w_tx_done;
      o_tx          <= w_tx;
      if (i_tick) begin
        r_index_cnt_en <= w_index_cnt_en;
      end
    end
  end

  // TX shift register
  always @(posedge i_clk) begin
    if (i_rst) begin
      r_tx_buffer <= 'h0;
    end else begin
      if (r_load) begin
        r_tx_buffer <= i_tx_data;
      end else if (i_tick && r_cnt == 'b0) begin
        case (LSB)
          1'b0:    r_tx_buffer <= r_tx_buffer >> 1;
          1'b1:    r_tx_buffer <= r_tx_buffer << 1;
          default: r_tx_buffer <= r_tx_buffer >> 1;
        endcase
      end
    end
  end

  //Counter
  always @(posedge i_clk) begin
    if (i_rst) begin
      r_cnt <= (OVERSAMPLING_MODE) - 1;
    end else if (r_cnt_en) begin
      if (i_tick) begin
        r_cnt <= r_cnt - 1;
      end
    end else begin
      r_cnt <= (OVERSAMPLING_MODE) - 1;
    end
  end

  //Data frame bit counter
  always @(posedge i_clk) begin
    if (i_rst) begin
      r_index <= 'b0;
    end else if (r_index_cnt_en) begin
      if (i_tick && r_cnt == 'b0)
        r_index <= r_index + 1;
    end else begin
        r_index <= 'b0;
    end
  end

endmodule

// FSM module receive data to UART
`timescale 1ns/1ps

module uart_transceiver_fsm_uart_rx #(
  parameter DATA_FRAME        = 8,       // number of data bits (5 ~ 9 bits long) (Type - Decimal, Default value = 8, Min value = 5, Max value = 9)
  parameter BAUD_RATE         = 115_200, // transmitting speed 9_600 - 115_200 (Type - Decimal, Default value = 8, Value = [4_800, 9_600, 19_200, 38_400, 57_600, 115_200])
  parameter OVERSAMPLING_MODE = 16,      // bit offset or overlap (Type - Decimal, Default value = 16, Min value = 2, Max value = 32)
  parameter STOP_BIT          = 1,       // length of stop bit (Type - Decimal, Default value = 1, Min value = 1, Max value = 2)
  parameter LSB               = 1'b0     // determine serial data transfer format. "0" = LSB to MSB, "1" = MSB to LSB (Type - Boolean, Default value = 1'b0, Min value = 1'b0, Max value = 1'b1)
) (
  input                       i_clk,     // input clock signal
  input                       i_rst,     // input reset signal
  input                       i_rx,      // rx input carries the input serial data
  input                       i_tick,    // input baud rate
  output reg [DATA_FRAME-1:0] o_rx_data, // receive data outputs
  output reg                  o_rx_done  // done signal
);

  localparam IDLE  = 4'b0001;
  localparam START = 4'b0010;
  localparam DATA  = 4'b0100;
  localparam STOP  = 4'b1000;

  localparam STOP_BIT_P1 = (STOP_BIT == 1.5) ? (OVERSAMPLING_MODE / 2) - 1 : 0;
  localparam STOP_BIT_P2 = (STOP_BIT == 1.5) ? 1 : STOP_BIT - 1;

//FSM variables
  reg [3:0] r_state, r_next;
  reg  r_read_data;
  reg  r_index_cnt_en;
  reg  r_cnt_en;
//wire
  reg  w_read_data;
  reg  w_index_cnt_en;
  reg  w_rx_done;
  reg  w_cnt_en;

//Counter variables
  reg                    [3:0] r_cnt   = 'h0;
  reg [$clog2(DATA_FRAME)-1:0] r_index = 'h0;
  
  // FSM state register
  always @(posedge i_clk) begin
    if (i_rst) begin
      r_state <= IDLE;
    end else begin
      r_state <= r_next;
    end
  end

  // FSM next assignment state
  always @* begin
    r_next = r_state;
    case(r_state)
      IDLE: begin
        if (!i_rx) begin
          r_next = START;
        end
      end

      START: begin
        if (r_cnt == 0) begin
          if (!i_rx) begin
            r_next = DATA;
          end else begin
            r_next = IDLE;
          end
        end
      end

      DATA: begin
        if (i_tick && r_cnt == 0) begin
          if(r_index == DATA_FRAME - 1) begin
            r_next = STOP;
          end
        end
      end

      STOP: begin
        if (i_tick && r_cnt == STOP_BIT_P1 && r_index == STOP_BIT_P2) begin 
          r_next = IDLE;
        end
      end

      default: begin
        r_next = IDLE;
      end
    endcase
  end

  // UART control signals
  always @* begin
    w_index_cnt_en = 'b0;
    w_rx_done      = 'b0;
    w_read_data    = 'b0;
    w_cnt_en       = 'b0;
    case (r_state)
      START: begin
        w_cnt_en   = 'b1;
      end
      DATA: begin
        w_cnt_en       = 'b1;
        w_read_data    = 'b1;
        w_index_cnt_en = 'b1;
      end
      STOP: begin
        w_cnt_en       = 'b1;
        w_read_data    = 'b0;
        w_rx_done      = 'b1;
        w_index_cnt_en = 'b1;
      end
    endcase
  end

  // UART control registers
  always @(posedge i_clk) begin
    if (i_rst) begin
      r_read_data    <= 'b0;
      r_cnt_en       <= 'b0;
      r_index_cnt_en <= 'b0;
      o_rx_done      <= 'b0;
    end else begin
      if (i_tick) begin
        r_read_data    <= w_read_data;
        r_index_cnt_en <= w_index_cnt_en;
      end
      r_cnt_en      <= w_cnt_en;
      o_rx_done     <= w_rx_done;
    end
  end

  // RX shift register
  always @(posedge i_clk) begin
    if (i_rst) begin
      o_rx_data <= 'b0;
    end else if (r_read_data && i_tick && r_cnt == 'b0) begin
      case (LSB)
        1'b0:    o_rx_data <= {i_rx, o_rx_data[DATA_FRAME-1:1]};
        1'b1:    o_rx_data <= {o_rx_data[DATA_FRAME-2:0], i_rx};
        default: o_rx_data <= {i_rx, o_rx_data[DATA_FRAME-1:1]};
      endcase
    end
  end

  //Counter
  always @(posedge i_clk) begin
    if (i_rst) begin
      r_cnt <= (OVERSAMPLING_MODE / 2) - 1;
    end else if (r_cnt_en) begin
      if (i_tick) begin
        r_cnt <= r_cnt - 1;
      end
    end else begin
      r_cnt <= (OVERSAMPLING_MODE / 2) - 1;
    end
  end

  //Data frame bit counter
  always @(posedge i_clk) begin
    if (i_rst) begin
      r_index <= 'b0;
    end else if (r_index_cnt_en) begin
      if (i_tick && r_cnt == 'b0) begin
        r_index <= r_index + 1;
      end
    end else begin
      r_index <= 'b0;
    end
  end

endmodule

// Module generate one bit period
module uart_transceiver_baud_rate_generator_trx #(
  parameter IN_CLK_HZ         = 50_000_000,
  parameter BAUD_RATE         = 115_200,
  parameter OVERSAMPLING_MODE = 16
) (
  input      i_clk,
  input      i_rst,
  output reg o_tick
);

  // Counter parameters depends from UART speed and oscillator period
  localparam DIV_CNT_VAL   = (IN_CLK_HZ / (BAUD_RATE * OVERSAMPLING_MODE)) - 1;
  localparam DIV_CNT_WIDTH = $clog2(DIV_CNT_VAL);

  reg [DIV_CNT_WIDTH-1:0] r_count = 0;

  // Counter UART speed (bit period)
  always @(posedge i_clk) begin
    if (i_rst) begin
      r_count <= 'b0;
      o_tick  <= 'b0;
    end else begin
      r_count <= r_count + 1;
      o_tick  <= 'b0;
      if (r_count == DIV_CNT_VAL) begin
        r_count <= 'b0;
        o_tick  <= 'b1;
      end
    end
  end

endmodule
