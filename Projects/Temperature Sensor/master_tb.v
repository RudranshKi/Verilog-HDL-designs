module master_tb();

reg  clk;
reg reset;

wire sio;
wire [9:0] temp;
wire sclk;
wire [15:0] op_reg;
wire [6:0] master_temp;
wire [3:0] display_1;
wire [3:0] display_2;
wire [6:0] display_MSB;
wire [6:0] display_LSB;
wire enable;
    
master_lm07 sen1(clk,reset,sclk,op_reg,sio,temp,master_temp,display_1,display_2,enable,display_MSB,display_LSB);
  
always  #10 clk = ~clk;

initial begin
       $monitor("time=%0b sio=%b temp=%b op_reg = %b temp= %b display2= %b display1= %b enable=%b %b %b",$time,sio,temp,op_reg,master_temp,display_2,display_1,enable,display_MSB,display_LSB);
       $dumpfile("dump.vcd");
       $dumpvars(1);
    
       reset       = 0;
       clk         = 1;
  #4   reset       = 1;
  #800 $finish;
       end
endmodule
