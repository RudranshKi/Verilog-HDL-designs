module sensor_lm07(sio,cs,sclk,reset,temp);

output sio;

input cs;
input sclk;
input reset;
  
wire gated_clk;
  
reg [9:0] temperature = 10'b1101011011;
output reg [9:0] temp;
  
assign gated_clk = ~cs & sclk;
assign sio = temp[9];
  
always@(posedge gated_clk) begin
    if (~cs) begin
      if (~reset) begin
      temp <= temperature;
    end
    else begin
      temp <= {temp[8:0],1'b0};
    end
    end
 end

endmodule

