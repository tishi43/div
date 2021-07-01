  
`timescale 1ns/1ns

module div_by_shift_sum_tb;

reg  [19:0] a;
reg  [15:0] b;
wire [19:0] result;
reg clk;

initial begin
    clk = 0;
    forever
        #1 clk = ~clk;
end

reg rst;
initial
begin
    rst = 0;
    #10 rst = 1;
    #10 rst = 0;
    #1 a = 80000;
end

always @ (posedge clk) begin
    if (rst)
        b    <= 1;
    else if (b<80000)
        b    <= b+1;
end


div_by_shift_sum #(
    .WidthD0(20),
    .WidthD1(16)
) div_by_shift_sum_inst_ge0(
    .clk(clk),
    .a(a),
    .b(b),
    .result(result)
);

endmodule  
