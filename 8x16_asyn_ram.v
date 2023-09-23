module asyn_ram ( wr_clk,rd_clk,clr,we,re,data_in,wr_addr,rd_addr,data_out);
input wr_clk,rd_clk,clr,we,re;
input [15:0] data_in;
input [2:0] wr_addr, rd_addr;
output reg [15:0] data_out;
reg [15:0] memory [7:0];
integer i;

always @(posedge wr_clk or posedge clr)
begin
if(clr)
begin
for (i=0;i<8;i=i+1)
memory[i] <= 0;
end
else
begin
if (we)
memory[wr_addr] <= data_in;
end
end

always @(posedge rd_clk or posedge clr)
begin
if(clr)
begin
data_out <= 0;
end
else
begin
if (re)
data_out <= memory[rd_addr];
end
end
endmodule

