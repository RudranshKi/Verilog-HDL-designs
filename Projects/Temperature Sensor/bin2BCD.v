module bin2BCD(enable,bin,BCD1,BCD2,reset,clk);
  input  [6:0] bin;
  input enable;
  output [3:0] BCD1;
  output [3:0] BCD2;
  input clk;
  input reset;
  reg [3:0] bcd_2 = 4'b0;
  reg [3:0] bcd_1 = 4'b0; 
  reg [4:0] binary;
  integer i;
  
  parameter start   = 0;
  parameter shift_1 = 1;
  parameter check_1 = 2;
  parameter add_1   = 3;
  parameter shift_2 = 4;
  parameter check_2 = 5;
  parameter add_2   = 6;
  parameter shift_3 = 7;
  parameter check_3 = 8;
  parameter add_3   = 9; 
  parameter shift_4 = 10;
  parameter check_4 = 11;
  parameter add_4   = 12;
  parameter shift_5 = 13;
  
  reg [3:0] state;
  reg [3:0] next_state;
  


  always@(posedge clk, ~reset) begin
  if (enable) begin
    if (~reset) begin
      state <= start;
      binary <= bin[4:0];
    end
    else begin 
      state <= next_state;
    end
    end
  end
  
  always@(state) begin
  if (enable) begin
    case (state) 
      start   : begin 
                bcd_1 <= {1'b0,1'b0,bin[6:5]};
                bcd_2 <= 4'b0;
                next_state <= shift_1;
                end
      shift_1 : begin
                bcd_2 <= {bcd_2[2:0],bcd_1[3]};
                bcd_1 <= {bcd_1[2:0],binary[4]};
                binary <= {binary[3:0],1'b0};
                next_state <= check_1;
                end
      check_1 : begin
                if (bcd_1 > 4'b0100) begin
                  next_state <= add_1;
                end
                else next_state <= shift_2;
                end
      add_1   : begin
                bcd_1 <= bcd_1 + 4'b0011;
                next_state <= shift_2;
                end
      shift_2 : begin
                bcd_2 <= {bcd_2[2:0],bcd_1[3]};
                bcd_1 <= {bcd_1[2:0],binary[4]};
                binary <= {binary[3:0],1'b0};
                next_state <= check_2;
                end
      check_2 : begin
                if (bcd_1 > 4'b0100) begin
                  next_state <= add_2;
                end
                else next_state <= shift_3;
                end
      add_2   : begin
                bcd_1 <= bcd_1 + 4'b0011;
                next_state <= shift_3;
                end
      shift_3 : begin
                bcd_2 <= {bcd_2[2:0],bcd_1[3]};
                bcd_1 <= {bcd_1[2:0],binary[4]};
                binary <= {binary[3:0],1'b0};
                next_state <= check_3;
                end
      check_3 : begin
                if (bcd_1 > 4'b0100) begin
                  next_state <= add_3;
                end
                else next_state <= shift_4;
                end
      add_3   : begin
                bcd_1 <= bcd_1 + 4'b0011;
                next_state <= shift_4;
                end
      shift_4 : begin
                bcd_2 <= {bcd_2[2:0],bcd_1[3]};
                bcd_1 <= {bcd_1[2:0],binary[4]};
                binary <= {binary[3:0],1'b0};
                next_state <= check_4;
                end
      check_4 : begin
                if (bcd_1 > 4'b0100) begin
                  next_state <= add_4;
                end
                else next_state <= shift_5;
                end
      add_4   : begin
                bcd_1 <= bcd_1 + 4'b0011;
                next_state <= shift_5;
                end
      shift_5 : begin
                bcd_2 <= {bcd_2[2:0],bcd_1[3]};
                bcd_1 <= {bcd_1[2:0],binary[4]};
                binary <= {binary[3:0],1'b0};
                end
    endcase
  end  
  end
  assign BCD1 = bcd_1;
  assign BCD2 = bcd_2;
endmodule
  
