module spi(miso_in,mosi_in,ss,enable,clk,mode, sclk,miso_out,mosi_out); 
  input miso_in; // miso - master in slave out (input)
  input mosi_in; // mosi - master out slave in (input)
  input ss;   // ss - slave select
  input enable;
  input clk;
  input [2:0] mode;
  
  output reg miso_out;  // miso - master in slave out (output)
  output reg mosi_out;  // mosi - master out slave in (output)
  output reg sclk;
  
  reg cpol=0; // clock polarity
  reg cphl=0; // clock phase
  
  always@(posedge clk, mode) begin
    case ({mode})
      0 :
         begin
           cpol <= 0;
           cphl <= 0;
         end
      1 :
         begin
           cpol <= 0;
           cphl <= 1;
         end
      2 :
         begin
           cpol <= 1;
           cphl <= 0;
         end
      3 :
         begin
           cpol <= 1;
           cphl <= 1;
         end
    endcase
  end
  
  always@(posedge clk) begin
    if (enable) begin
      if   (~ss &&  ~cpol) begin
          sclk <= 0;  
      end
      else if (~ss && cpol) begin 
          sclk <= 1;
        end
      forever #5 sclk <= ~sclk;
    end
  end
  
  always@(posedge sclk) begin
    if (~ss && ~cphl) begin
      miso_out <= miso_in;
      mosi_out <= mosi_in;
    end
  end
  always@(negedge sclk) begin
    if (~ss && cphl) begin
      miso_out <= miso_in;
      mosi_out <= mosi_in;
    end
  end
endmodule
