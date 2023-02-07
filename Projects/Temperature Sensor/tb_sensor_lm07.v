module tb_sensor_lm07();

reg  clk;
reg  cs;
wire sio;
reg reset;
  
sensor_lm07 sen(sio,cs,clk,reset);

always  #10 clk = ~clk;

initial begin
       $monitor("time=%0b sio=%b",$time,sio);
       $dumpfile("dump.vcd");
       $dumpvars(1);
       cs          = 1;
       clk         = 1;
       reset       = 0;
  #4   cs          = 0;
       reset       = 1;
  #390 cs          = 0;
  #400 $finish;
       end
endmodule
