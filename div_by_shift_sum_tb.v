  
`timescale 1ns/1ns

module div_by_shift_sum_tb;

reg  [19:0] a;
reg  [15:0] b;
wire [19:0] result;
reg clk;
reg rst;
reg rst_div;

initial begin
    clk = 0;
    forever
        #1 clk = ~clk;
end


initial
begin
    rst = 0;
    #1 a = 80000;
    #10 rst = 1;
    #10 rst = 0;

end

always @ (posedge clk) begin
    if (rst) begin
        b       <= 1;
        rst_div <= 1;
    end
    else if (b<65535) begin
        b       <= b+1;
        rst_div <= 0;
        if (b>21&& a/(b-21)!=result)
            $display("%t a=%d b=%d right %d wrong %d",$time,a,b,a/(b-21),result);
    end
end


div_by_shift_sum_pipeline #(
    .WidthD0(20),
    .WidthD1(16)
) div_by_shift_sum_inst_ge0(
    .clk(clk),
    .a(a),
    .b(b),
    .result(result)
);

wire [7:0] c;
wire [3:0] d;
wire [7:0] result1;
wire       div_valid;
assign c=8'b10001110;
assign d=4'b1111;


div_by_shift_sum #(
    .WidthD0(8),
    .WidthD1(4)
) div_by_shift_sum_inst1(
    .clk(clk),
    .a(c),
    .b(d),
    .rst(rst_div),
    .result(result1),
    .valid(div_valid)
);



endmodule  
