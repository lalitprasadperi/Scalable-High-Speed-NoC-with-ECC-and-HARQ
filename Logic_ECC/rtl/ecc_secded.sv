//--------------------------------------------------------------------
// Author: Lalit Prasad Peri (lalitprasad@vt.edu)
// Group5 Project: Advance VLSI Design, ECE5545 Spring2024 
//--------------------------------------------------------------------

module ecc_secded
    (
        // input interface from switching logic
        input wire          i_aclk,
        input wire          i_aresetn,

        input wire          i_enable_ecc,

        input wire          i_wvalid,
        input wire [39:0]   i_wdata,

	output logic        o_serr,
	output logic        o_decerr,

        output logic        o_wvalid,
        output logic [39:0] o_wdata

    );

wire [7:0] gen_ecc;
wire [7:0] serr_pos;
reg  [7:0] recvd_ecc;

//--------------------------------------------------------------------
always_ff@(posedge i_aclk or negedge i_aresetn)
begin
if(!i_aresetn)
  begin
  o_wvalid       <= 1'b0;
  //o_wdata[39:32] <= 8'b0; 
  recvd_ecc      <= 8'b0; 
  end
else
  begin
  o_wvalid         <= i_wvalid;
  //o_wdata[31:0]    <= i_wdata[31:0]; 
  //o_wdata[39:32]   <= 8'b0; 
  recvd_ecc[7:0] <= i_wdata[39:32]; 
  end
end

//--------------------------------------------------------------------
// Single-Bit error and correction;
//--------------------------------------------------------------------
always_ff@(posedge i_aclk or negedge i_aresetn)
begin
if(!i_aresetn)
   o_serr <= 1'b0;
else
   o_serr <= i_enable_ecc & (^serr_pos);     
end

//--------------------------------------------------------------------
// Locate Bit position of Single Bit Error
//--------------------------------------------------------------------
assign serr_pos[7] = recvd_ecc[7] ^gen_ecc[7]; 	
assign serr_pos[6] = recvd_ecc[6] ^gen_ecc[6]; 	
assign serr_pos[5] = recvd_ecc[5] ^gen_ecc[5]; 	
assign serr_pos[4] = recvd_ecc[4] ^gen_ecc[4]; 	
assign serr_pos[3] = recvd_ecc[3] ^gen_ecc[3]; 	
assign serr_pos[2] = recvd_ecc[2] ^gen_ecc[2]; 	
assign serr_pos[1] = recvd_ecc[1] ^gen_ecc[1]; 	
assign serr_pos[0] = recvd_ecc[0] ^gen_ecc[0]; 

//--------------------------------------------------------------------
// Data Self-Correction Logic Base on Error Bit position
//--------------------------------------------------------------------

always_ff@(posedge i_aclk or negedge i_aresetn)
begin
if(!i_aresetn)
  o_wdata <= 40'b0; 
else
    case(serr_pos) 
	8'b10000000 : o_wdata <= {8'b0,i_wdata[31],i_wdata[30],i_wdata[29],i_wdata[28],i_wdata[27:0]};
	8'b01000000 : o_wdata <= {8'b0,i_wdata[31:28],i_wdata[27],i_wdata[26],i_wdata[25],i_wdata[24],i_wdata[23:0]};
	8'b00100000 : o_wdata <= {8'b0,i_wdata[31:24],i_wdata[23],i_wdata[22],i_wdata[21],i_wdata[20],i_wdata[19:0]};
	8'b00010000 : o_wdata <= {8'b0,i_wdata[31:20],i_wdata[19],i_wdata[18],i_wdata[17],i_wdata[16],i_wdata[15:0]};
	8'b00001000 : o_wdata <= {8'b0,i_wdata[31:16],i_wdata[15],i_wdata[14],i_wdata[13],i_wdata[12],i_wdata[11:0]};
	8'b00000100 : o_wdata <= {8'b0,i_wdata[31:12],i_wdata[11],i_wdata[10],i_wdata[9],i_wdata[8],i_wdata[7:0]};
	8'b00000010 : o_wdata <= {8'b0,i_wdata[31:8],i_wdata[7],i_wdata[6],i_wdata[5],i_wdata[4],i_wdata[3:0]};
	8'b00000001 : o_wdata <= {8'b0,i_wdata[31:4],i_wdata[3],i_wdata[2],i_wdata[1],i_wdata[0]};
	default :     o_wdata <= i_wdata;
    endcase
end

//--------------------------------------------------------------------
// Double-Bit error and Detection;
//--------------------------------------------------------------------
always_ff@(posedge i_aclk or negedge i_aresetn)
begin
if(!i_aresetn)
   o_decerr <= 1'b0;
else
	if(i_enable_ecc)
	begin
	//  Calculated ECC & Recievd ECC bits dont match and it is not
	//  single-bit error then flag double bit error;
	  o_decerr <= o_serr? 1'b0: (recvd_ecc!==gen_ecc);
	end
	else
	  o_decerr <= 1'b0;
end

//--------------------------------------------------------------------
//--- 32bit data / 8bit Hamming Encode ---
//--------------------------------------------------------------------

assign gen_ecc[7] = 
  i_wdata[31]  ^i_wdata[30]  ^i_wdata[29]  ^i_wdata[28] 
 ^i_wdata[27]  ^i_wdata[26]  ^i_wdata[25]  ^i_wdata[24]   
 ^i_wdata[23]  ^i_wdata[22]  ^i_wdata[21]  ^i_wdata[20]  
 ^i_wdata[19]  ^i_wdata[18]  ^i_wdata[17]  ^i_wdata[16]  
 ^i_wdata[15]  ^i_wdata[14]  ^i_wdata[13]  ^i_wdata[12]  
 ^i_wdata[11]  ^i_wdata[10]  ^i_wdata[9]   ^i_wdata[8]   
 ^i_wdata[7]   ^i_wdata[6]   ^i_wdata[5]   ^i_wdata[4]   
 ^i_wdata[3]   ^i_wdata[2]   ^i_wdata[1]   ^i_wdata[0];

 assign gen_ecc[6] = 
  !i_wdata[31]  ^!i_wdata[30]  ^!i_wdata[29]  ^!i_wdata[28] 
 ^!i_wdata[27]  ^!i_wdata[26]  ^!i_wdata[25]  ^!i_wdata[24]   
 ^!i_wdata[23]  ^!i_wdata[22]  ^!i_wdata[21]  ^!i_wdata[20]  
 ^!i_wdata[19]  ^!i_wdata[18]  ^!i_wdata[17]  ^!i_wdata[16]  
 ^!i_wdata[15]  ^!i_wdata[14]  ^!i_wdata[13]  ^!i_wdata[12]  
 ^!i_wdata[11]  ^!i_wdata[10]  ^!i_wdata[9]   ^!i_wdata[8]   
 ^!i_wdata[7]   ^!i_wdata[6]   ^!i_wdata[5]   ^!i_wdata[4]   
 ^!i_wdata[3]   ^!i_wdata[2]   ^!i_wdata[1]   ^!i_wdata[0];

assign gen_ecc[5] = 
  i_wdata[31]  ^i_wdata[30]  ^i_wdata[29]  ^i_wdata[28] 
 ^i_wdata[27]  ^i_wdata[26]  ^i_wdata[25]  ^i_wdata[24]   
 ^i_wdata[23]  ^i_wdata[22]  ^i_wdata[21]  ^i_wdata[20]  
 ^i_wdata[19]  ^i_wdata[18]  ^i_wdata[17]  ^i_wdata[16]  
 ^i_wdata[15]  ^i_wdata[14]  ^i_wdata[13]  ^i_wdata[12]  
 ^i_wdata[11]  ^i_wdata[10]  ^i_wdata[9]   ^i_wdata[8]   
 ^i_wdata[7]   ^i_wdata[6]   ^i_wdata[5]   ^i_wdata[4]   
 ^i_wdata[3]   ^i_wdata[2]   ^i_wdata[1]   ^i_wdata[0];

assign gen_ecc[4] = 
  !i_wdata[31]  ^!i_wdata[30]  ^!i_wdata[29]  ^!i_wdata[28] 
 ^!i_wdata[27]  ^!i_wdata[26]  ^!i_wdata[25]  ^!i_wdata[24]   
 ^!i_wdata[23]  ^!i_wdata[22]  ^!i_wdata[21]  ^!i_wdata[20]  
 ^!i_wdata[19]  ^!i_wdata[18]  ^!i_wdata[17]  ^!i_wdata[16]  
 ^!i_wdata[15]  ^!i_wdata[14]  ^!i_wdata[13]  ^!i_wdata[12]  
 ^!i_wdata[11]  ^!i_wdata[10]  ^!i_wdata[9]   ^!i_wdata[8]   
 ^!i_wdata[7]   ^!i_wdata[6]   ^!i_wdata[5]   ^!i_wdata[4]   
 ^!i_wdata[3]   ^!i_wdata[2]   ^!i_wdata[1]   ^!i_wdata[0];

assign gen_ecc[3] = 
  i_wdata[31]  ^i_wdata[30]  ^i_wdata[29]  ^i_wdata[28] 
 ^i_wdata[27]  ^i_wdata[26]  ^i_wdata[25]  ^i_wdata[24]   
 ^i_wdata[23]  ^i_wdata[22]  ^i_wdata[21]  ^i_wdata[20]  
 ^i_wdata[19]  ^i_wdata[18]  ^i_wdata[17]  ^i_wdata[16]  
 ^i_wdata[15]  ^i_wdata[14]  ^i_wdata[13]  ^i_wdata[12]  
 ^i_wdata[11]  ^i_wdata[10]  ^i_wdata[9]   ^i_wdata[8]   
 ^i_wdata[7]   ^i_wdata[6]   ^i_wdata[5]   ^i_wdata[4]   
 ^i_wdata[3]   ^i_wdata[2]   ^i_wdata[1]   ^i_wdata[0];

 assign gen_ecc[2] = 
  !i_wdata[31]  ^!i_wdata[30]  ^!i_wdata[29]  ^!i_wdata[28] 
 ^!i_wdata[27]  ^!i_wdata[26]  ^!i_wdata[25]  ^!i_wdata[24]   
 ^!i_wdata[23]  ^!i_wdata[22]  ^!i_wdata[21]  ^!i_wdata[20]  
 ^!i_wdata[19]  ^!i_wdata[18]  ^!i_wdata[17]  ^!i_wdata[16]  
 ^!i_wdata[15]  ^!i_wdata[14]  ^!i_wdata[13]  ^!i_wdata[12]  
 ^!i_wdata[11]  ^!i_wdata[10]  ^!i_wdata[9]   ^!i_wdata[8]   
 ^!i_wdata[7]   ^!i_wdata[6]   ^!i_wdata[5]   ^!i_wdata[4]   
 ^!i_wdata[3]   ^!i_wdata[2]   ^!i_wdata[1]   ^!i_wdata[0];

assign gen_ecc[1] = 
  i_wdata[31]  ^i_wdata[30]  ^i_wdata[29]  ^i_wdata[28] 
 ^i_wdata[27]  ^i_wdata[26]  ^i_wdata[25]  ^i_wdata[24]   
 ^i_wdata[23]  ^i_wdata[22]  ^i_wdata[21]  ^i_wdata[20]  
 ^i_wdata[19]  ^i_wdata[18]  ^i_wdata[17]  ^i_wdata[16]  
 ^i_wdata[15]  ^i_wdata[14]  ^i_wdata[13]  ^i_wdata[12]  
 ^i_wdata[11]  ^i_wdata[10]  ^i_wdata[9]   ^i_wdata[8]   
 ^i_wdata[7]   ^i_wdata[6]   ^i_wdata[5]   ^i_wdata[4]   
 ^i_wdata[3]   ^i_wdata[2]   ^i_wdata[1]   ^i_wdata[0];

assign gen_ecc[0] = 
  !i_wdata[31]  ^!i_wdata[30]  ^!i_wdata[29]  ^!i_wdata[28] 
 ^!i_wdata[27]  ^!i_wdata[26]  ^!i_wdata[25]  ^!i_wdata[24]   
 ^!i_wdata[23]  ^!i_wdata[22]  ^!i_wdata[21]  ^!i_wdata[20]  
 ^!i_wdata[19]  ^!i_wdata[18]  ^!i_wdata[17]  ^!i_wdata[16]  
 ^!i_wdata[15]  ^!i_wdata[14]  ^!i_wdata[13]  ^!i_wdata[12]  
 ^!i_wdata[11]  ^!i_wdata[10]  ^!i_wdata[9]   ^!i_wdata[8]   
 ^!i_wdata[7]   ^!i_wdata[6]   ^!i_wdata[5]   ^!i_wdata[4]   
 ^!i_wdata[3]   ^!i_wdata[2]   ^!i_wdata[1]   ^!i_wdata[0];

endmodule

//--------------------------------------------------------------------
