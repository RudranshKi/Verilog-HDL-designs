module spi_prot_tb();
  reg miso;
  reg mosi;
  reg ss;
  reg enable;
  reg clk;
  reg [2:0] mode;
  wire sclk;
  wire miso_out;
  wire mosi_out;
  
  spi sp(miso,mosi,ss,enable,clk,mode,sclk,miso_out,mosi_out);
  
  always #5 clk = ~clk;
  
  initial begin 
    $monitor("sclk %d",sclk);
    $dumpfile("dump.vcd");
    $dumpvars(1,spi_prot_tb);
    mode = 3;
    ss = 0;
    enable =1;
    clk = 0;
    miso= 0;
    mosi =0;
    
    #15 miso =1;
    #20 mosi =1;
    
    #50 $finish;
  end
endmodule
