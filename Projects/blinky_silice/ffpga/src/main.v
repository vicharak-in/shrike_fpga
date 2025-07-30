
module M_main (
out_leds,
out_done,
reset,
clock
);
output  [0:0] out_leds;
output out_done;
input reset;
input clock;


reg  [25:0] _d_cnt;
reg  [25:0] _q_cnt;
reg  [0:0] _d_leds;
reg  [0:0] _q_leds;
reg  [1:0] _d__idx_fsm0,_q__idx_fsm0;
reg  _autorun = 0;
assign out_leds = _q_leds;
assign out_done = (_q__idx_fsm0 == 0) && _autorun
;



`ifdef FORMAL
initial begin
assume(reset);
end
assume property($initstate || (out_done));
`endif
always @* begin
_d_cnt = _q_cnt;
_d_leds = _q_leds;
_d__idx_fsm0 = _q__idx_fsm0;
// _always_pre
_d_leds = _q_cnt[24+:1];

(* full_case *)
case (_q__idx_fsm0)
1: begin
// _top
_d__idx_fsm0 = 2;
end
2: begin
// __while__block_1
if (1) begin
// __block_2
// __block_4
_d_cnt = _q_cnt+1;

// __block_5
_d__idx_fsm0 = 2;
end else begin
// __block_3
_d__idx_fsm0 = 0;
end
end
0: begin 
end
default: begin 
_d__idx_fsm0 = {2{1'bx}};
`ifdef FORMAL
assume(0);
`endif
 end
endcase
// _always_post
// pipeline stage triggers
end

always @(posedge clock) begin
_q_cnt <= (reset) ? 0 : _d_cnt;
_q_leds <= _d_leds;
_q__idx_fsm0 <= reset ? 0 : ( ~_autorun ? 1 : _d__idx_fsm0);
_autorun <= reset ? 0 : 1;
end

endmodule

