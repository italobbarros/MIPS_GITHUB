module registerFile #(
	parameter DATA_WIDTH=31 
)
(
	input clk,
	input rst,
	input[DATA_WIDTH:0] data_In,
	input[3:0] data_InReg,
	input enable,
	input[3:0] data_OutRegA,
	input[3:0] data_OutRegB,
	output reg[15:0] regA,
	output reg[15:0] regB
);

	integer i;

	//16 registros do Register file
	reg[31:0] s[0:7]; //0 - 7
	reg[31:0] t[0:7]; //8 - 15

	initial begin
	 //inicializacao dos 16 registros
	 //for com a inicializacao dos vetores s e t
		for(i = 0; i < 8; i = i + 1)
			begin
				s[i] = 0;
				t[i] = 0;
			end
	end

	always @ (*) begin

		if(rst) begin
			for(i = 0; i < 8; i = i + 1) begin //for com a inicializacao dos vetores s e t
				s[i] = 0;
				t[i] = 0;
			end
		end


		else begin
			if(enable) begin
				if(data_InReg<8) //verifica para qual reg enviar os dados
					s[data_InReg] <= data_In; //salva os dados de entrada no reg0
				else if(data_InReg>7)
					t[data_InReg-8] <= data_In;
			end					
		end
	end
	
	always @ (negedge clk) begin
		if(data_OutRegA<8) //verifica se deve enviar os dados para o regA
				regA <= s[data_OutRegA]; //salva no regB o conteudo do s[i]
		else if(data_OutRegA>7)
			regA <= t[data_OutRegA-8];//salva no regB o conteudo do t[i]
			

		if(data_OutRegB<8) //verifica se deve enviar os dados para o regB
			regB <= s[data_OutRegB]; //salva no regB o conteudo do s[i]
		else if(data_OutRegB>7)
			regB <= t[data_OutRegB-8];	//salva no regB o conteudo do t[i]
	end
	
		
	

endmodule
