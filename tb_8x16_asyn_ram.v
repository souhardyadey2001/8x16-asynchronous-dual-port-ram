module tb_ram();
reg wr_clk,rd_clk,clr,we,re;
reg [2:0] wr_addr,rd_addr;
reg [15:0] data_in;
wire [15:0] data_out;
integer i,j;
asyn_ram DUT (wr_clk,rd_clk,clr,we,re,data_in,wr_addr,rd_addr,data_out);
task initialize();
begin
wr_clk = 1'b0;
rd_clk = 1'b0;
clr = 1'b0;
we = 1'b0;
re = 1'b0;
rd_addr = 1'b0;
wr_addr = 1'b0;
end
endtask

always #10 wr_clk = ~wr_clk;
always #20 rd_clk = ~rd_clk;
task clr_dut();
begin
clr = 1'b1;
#50;
clr = 1'b0;
end
endtask

task write_memory (input [2:0] wradd, input [15:0] data);
begin
@(negedge wr_clk)
we = 1'b1;
wr_addr = wradd;
data_in = data;
end
endtask

task read_memory (input [2:0] rdadd);
begin
@(negedge rd_clk)
re = 1'b1;
rd_addr = rdadd;
end
endtask

initial
begin
initialize;
#10;
clr_dut;
for (i=0;i<8;i=i+1)
begin
write_memory (i, {$random}%16);
end
for (j=0;j<8;j=j+1)
begin
read_memory (j);
end
end
endmodule

