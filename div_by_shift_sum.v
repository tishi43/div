

// ԭ�����Сѧʱ���ĳ�����ʽԭ��
// 1284����15��1284һλһλ����
// step 1: �ȸ�1����15�ȣ���15С���������λ�Ľ����0��1����15��������1����������
// step 2: �ٸ�1λ���Ǿ���12��12��15�ȣ����Ǳ�15С����λ�Ľ��Ҳ��0��12����15��������12����������
// step 3: �ٸ�1λ���Ǿ���128����15���ˣ���15��8���࣬��λ�����8��������8��
// step 4: �ٸ�1λ������4������ǰ�������8Ϊ84��84��15��5���࣬��λ�����5,����9Ϊ��������
// Done, �������Ǽ�λ������Ҫ����step

//step 1:
//          0 
//        /--------
//  15  \/  1 2 8 4
//          0
//         --------
//          1

//step 2:
//          0 0
//        /--------
//  15  \/  1 2 8 4
//            0
//         --------
//          1 2
//            0
//         --------
//          1 2

//step 3:
//          0 0 8
//        /--------
//  15  \/  1 2 8 4
//            0
//         --------
//          1 2
//            0
//         --------
//          1 2 8
//          1 2 0
//         -------
//              8

//step 4:
//          0 0 8 5
//        /--------
//  15  \/  1 2 8 4
//            0
//         --------
//          1 2
//            0
//         --------
//          1 2 8
//          1 2 0
//         -------
//              8 4
//              7 5
//             -----
//                9


//����������ǰ�10���Ƶ�1λ1λ�����ƹ㵽������,��142/10Ϊ��
//step 1~4ʡ�ԣ�����������4λ��Ҳ����1000,���Ǳ�1010С����4λ�Ľ����0000

//step 5,����������5λ��10001�ȳ���1010���ˣ����step�Ľ����1��
//��10������ȣ����ֻ��0��1֮�֣����ڵ��ڣ��������1��С�ڣ��������0
//            00001
//          /---------
//  1010  \/  10001110
//             1010
//            ------ 
//              111

//step 6��ǰһ��������111���ټ������������µ�1λ1������1111����1010�󣬽����1
//            000011
//          /---------
//  1010  \/  10001110
//             1010
//            ------ 
//              1111
//              1010
//              ----
//               101

//step 7��ǰһ��������101���ټ������������µ�1λ1������1011����1010�󣬽����1
//            0000111
//          /---------
//  1010  \/  10001110
//             1010
//            ------ 
//              1111
//              1010
//              -----
//               1011
//               1010
//               -----
//                  1

//step 8��ǰһ��������1���ټ����������µ�1λ0������10����1010С�������0
//            00001110
//          /---------
//  1010  \/  10001110
//             1010
//            ------ 
//              1111
//              1010
//              -----
//               1011
//               1010
//               -----
//                  10

//Done�������1110������10

//rst    : div_result= 0000_1 0001110
//                     ------ ��5bit��1010�ȣ��൱�ڱ������ȸ���ǰ��1,��1010С��Ȼ��div_result<<1
//cycle 1: div_result= 00010 001110 0
//...
//cycle 4: div_result= 10001 110 0000
//                     ----- ��5bit��1010�ȣ�������,��һ��Ϊ({10001-1010����,111 0000}<<1)|1��({00111,111000}<<1)|1,
//                          ��0bit���������ˣ���1���Ǵ���1����div_result<<1,�൱�ڴ���0
//cycle 5: div_result= 01111 1000001
//                     ----- ��5bit��1010��
//cycle 6: div_result= 01011 0000011
//                     ----- ��5bit��1010��
//cycle 7: div_result= 00010 0000111
//                     ----- ��5bit��1010С
//cycle 8: div_result= 0010           00001110
//                     ----4bit����   --------8bit���

module div_by_shift_sum #(
    parameter WidthD0=64,
    parameter WidthD1=32,
    parameter WidthQ=WidthD0+WidthD1)
(
    input wire                  clk,
    input wire                  rst,
    input wire  [WidthD0-1:0]   a,
    input wire  [WidthD1-1:0]   b,

    output wire [WidthD0-1:0]   result,
    output reg                  valid
);

localparam CountBits = $clog2(WidthD0-1)+1;

reg  [WidthQ-1:0]    div_result;
reg  [WidthD1 :0]    div_sub_val; //ÿ��������
reg  [CountBits-1:0] counter;

always @ (posedge clk) begin
    if (rst) begin
        div_result      <= {{WidthD1{1'b0}}, a};
        counter         <= 0;
        valid           <= 0;
    end
    else if (~valid)begin
        if (div_result[WidthQ-1:WidthD0-1]>=b)
            div_result  <= ({div_sub_val,div_result[WidthD0-2:0]} << 1) | 1;
        else
            div_result  <= div_result << 1;

        counter         <= counter+1;
        if (counter==WidthD0-1)
            valid       <= 1;
    end
end

integer ii;

always @(*) begin
    div_sub_val = div_result[WidthQ-1:WidthD0-1]-b;
end

assign result = div_result[WidthD0-1:0];

endmodule



module div_by_shift_sum_pipeline #(
    parameter WidthD0=64,
    parameter WidthD1=32,
    parameter WidthQ=WidthD0+WidthD1)
(
    input wire                  clk,
    input wire  [WidthD0-1:0]   a,
    input wire  [WidthD1-1:0]   b,

    output wire [WidthD0-1:0]   result
);


reg  [WidthD1-1:0]   b_d[0:WidthD0];
reg  [WidthQ-1:0]    div_result_d[0:WidthD0];
reg  [WidthD1  :0]   div_sub_val[0:WidthD0];

always @ (posedge clk) begin
    b_d[0]           <= b;
    div_result_d[0]  <= {{WidthD1{1'b0}}, a};
end

integer ii;

always @(*) begin
    for (ii = 0; ii <= WidthD0; ii = ii + 1) begin
        div_sub_val[ii] = div_result_d[ii][WidthQ-1:WidthD0-1]-b_d[ii];
    end
end

always @(posedge clk) begin
    for (ii = 1; ii <= WidthD0; ii = ii + 1) begin
        if (div_result_d[ii-1][WidthQ-1:WidthD0-1]>=b_d[ii-1])
            div_result_d[ii]  <= ({div_sub_val[ii-1],div_result_d[ii-1][WidthD0-2:0]} << 1) | 1;
        else
            div_result_d[ii]  <= div_result_d[ii-1] << 1;

        b_d[ii]               <= b_d[ii-1];

    end
end

assign result = div_result_d[WidthD0][WidthD0-1:0];

endmodule






