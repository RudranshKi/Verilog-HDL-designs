module seven_segment(input A,B,C,D ,output reg g,f,e,d,c,b,a,input cs);
  
  always@(A,B,C,D)
    begin
      if (~cs) begin
      case ({A,B,C,D})
        4'b0000 : {g,f,e,d,c,b,a} = 7'h3f;
        4'b0001 : {g,f,e,d,c,b,a} = 7'h06;
        4'b0010 : {g,f,e,d,c,b,a} = 7'h5b;
        4'b0011 : {g,f,e,d,c,b,a} = 7'h4f;
        4'b0100 : {g,f,e,d,c,b,a} = 7'h66;
        4'b0101 : {g,f,e,d,c,b,a} = 7'h6d;
        4'b0110 : {g,f,e,d,c,b,a} = 7'h7d;
        4'b0111 : {g,f,e,d,c,b,a} = 7'h07;
        4'b1000 : {g,f,e,d,c,b,a} = 7'h7f;
        4'b1001 : {g,f,e,d,c,b,a} = 7'h6f;
      endcase
      end
    end
endmodule
