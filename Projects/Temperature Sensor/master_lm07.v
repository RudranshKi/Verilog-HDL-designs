`include "sensor_lm07.v"
`include "bin2BCD.v"
`include "seven_segment.v"

module master_lm07(clk,reset,sclk,op_reg,sio,temp,master_temp,display_1,display_2,enable,display_out_MSB,display_out_LSB);
input clk;                 // clock from testbench
input reset;               // resetting lm07, master lm07
  
output reg sclk;           // for internal clock
output reg [15:0] op_reg; 
output [9:0] temp;
output sio;                // for serial communication 
output [3:0] display_1;    //to 7 segment_display_1 (LSB)
output [3:0] display_2;    //to 7 segment_display_1 (MSB)
output [6:0] display_out_MSB; // 7 segment display output (MSB)
output [6:0] display_out_LSB; // 7 segment display output (LSB)

output reg [6:0] master_temp;    // for storing only viable data
reg cs_1;                  // lm07 chipselect 
reg cs_2;                  // 7 segment_display_1 chipselect (for MSB display)
reg cs_3;                  // 7 segment_display_2 chipselect (for LSB display)
output reg enable;
reg reset_BCD;

integer i = 16;

sensor_lm07 sen1(sio,cs_1,sclk,reset,temp);
bin2BCD  sen2(enable,master_temp,display_1,display_2,reset_BCD,sclk);
seven_segment sen_LSB(display_1[3],display_1[2],display_1[1],display_1[0],display_out_LSB[6],display_out_LSB[5],display_out_LSB[4],display_out_LSB[3],display_out_LSB[2],display_out_LSB[1],display_out_LSB[0],cs_2);
seven_segment sen_MSB(display_2[3],display_2[2],display_2[1],display_2[0],display_out_MSB[6],display_out_MSB[5],display_out_MSB[4],display_out_MSB[3],display_out_MSB[2],display_out_MSB[1],display_out_MSB[0],cs_2);

always@(posedge clk, negedge clk, reset) begin
	if (~reset) begin
		sclk   <= 1;
		op_reg <= 16'b0000000000000000;
		cs_1   <= 1'b0;
		cs_2   <= 1'b1;
		cs_3   <= 1'b1;
	end
	else begin
		sclk <= ~sclk;
	end
end


always@(posedge sclk) begin
        op_reg[i] <= sio;
        i=i-1;

        if (i==4'd5) begin
        	cs_1     <= 1'b1;
        end

	if (i==4'd4) begin
		enable <= 1'b1;
	end

	if (i==4'd3) begin
		reset_BCD <= 1'b1;
		
	end

	if (i==4'd1) begin
		cs_2 <= 1'b0;
		cs_3 <= 1'b0;
	end
end

always@(cs_1) begin
	if (cs_1 == 1'b1) begin
		master_temp <=  op_reg[13:7];
		enable      <=  1'b0;
		reset_BCD   <=  1'b0;
	end
end


endmodule







