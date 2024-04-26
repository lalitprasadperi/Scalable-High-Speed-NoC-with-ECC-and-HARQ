//--------------------------------------------------------------------
// Author: Lalit Prasad Peri (lalitprasad@vt.edu)
// Group5 Project: Advance VLSI Design, ECE5545 Spring2024 
//--------------------------------------------------------------------

module ecc_encode
    (
        // input interface from switching logic
        input wire          i_aclk,
        input wire          i_aresetn,

        input wire          i_enable_ecc,

        input wire          i_wvalid,
        input wire [39:0]   i_wdata,

        output logic        o_wvalid,
        output logic [39:0] o_wdata

    );

wire [7:0] r_eccdata;

always_ff@(posedge i_aclk or negedge i_aresetn)
begin
if(!i_aresetn)
  begin	
  o_wvalid      <= 1'b0;
  o_wdata[39:0] <= 40'b0; 
  end
else
  begin	
  o_wvalid       <= i_wvalid;
  o_wdata[39:0]  <= {r_eccdata[7:0], i_wdata[31:0]}; 
  end
end


//--- 32bit data / 8bit Hamming Encode ---

assign r_eccdata[7] = 
  i_wdata[31]  ^i_wdata[30]  ^i_wdata[29]  ^i_wdata[28] 
 ^i_wdata[27]  ^i_wdata[26]  ^i_wdata[25]  ^i_wdata[24]   
 ^i_wdata[23]  ^i_wdata[22]  ^i_wdata[21]  ^i_wdata[20]  
 ^i_wdata[19]  ^i_wdata[18]  ^i_wdata[17]  ^i_wdata[16]  
 ^i_wdata[15]  ^i_wdata[14]  ^i_wdata[13]  ^i_wdata[12]  
 ^i_wdata[11]  ^i_wdata[10]  ^i_wdata[9]   ^i_wdata[8]   
 ^i_wdata[7]   ^i_wdata[6]   ^i_wdata[5]   ^i_wdata[4]   
 ^i_wdata[3]   ^i_wdata[2]   ^i_wdata[1]   ^i_wdata[0];

 assign r_eccdata[6] = 
  !i_wdata[31]  ^!i_wdata[30]  ^!i_wdata[29]  ^!i_wdata[28] 
 ^!i_wdata[27]  ^!i_wdata[26]  ^!i_wdata[25]  ^!i_wdata[24]   
 ^!i_wdata[23]  ^!i_wdata[22]  ^!i_wdata[21]  ^!i_wdata[20]  
 ^!i_wdata[19]  ^!i_wdata[18]  ^!i_wdata[17]  ^!i_wdata[16]  
 ^!i_wdata[15]  ^!i_wdata[14]  ^!i_wdata[13]  ^!i_wdata[12]  
 ^!i_wdata[11]  ^!i_wdata[10]  ^!i_wdata[9]   ^!i_wdata[8]   
 ^!i_wdata[7]   ^!i_wdata[6]   ^!i_wdata[5]   ^!i_wdata[4]   
 ^!i_wdata[3]   ^!i_wdata[2]   ^!i_wdata[1]   ^!i_wdata[0];

assign r_eccdata[5] = 
  i_wdata[31]  ^i_wdata[30]  ^i_wdata[29]  ^i_wdata[28] 
 ^i_wdata[27]  ^i_wdata[26]  ^i_wdata[25]  ^i_wdata[24]   
 ^i_wdata[23]  ^i_wdata[22]  ^i_wdata[21]  ^i_wdata[20]  
 ^i_wdata[19]  ^i_wdata[18]  ^i_wdata[17]  ^i_wdata[16]  
 ^i_wdata[15]  ^i_wdata[14]  ^i_wdata[13]  ^i_wdata[12]  
 ^i_wdata[11]  ^i_wdata[10]  ^i_wdata[9]   ^i_wdata[8]   
 ^i_wdata[7]   ^i_wdata[6]   ^i_wdata[5]   ^i_wdata[4]   
 ^i_wdata[3]   ^i_wdata[2]   ^i_wdata[1]   ^i_wdata[0];

assign r_eccdata[4] = 
  !i_wdata[31]  ^!i_wdata[30]  ^!i_wdata[29]  ^!i_wdata[28] 
 ^!i_wdata[27]  ^!i_wdata[26]  ^!i_wdata[25]  ^!i_wdata[24]   
 ^!i_wdata[23]  ^!i_wdata[22]  ^!i_wdata[21]  ^!i_wdata[20]  
 ^!i_wdata[19]  ^!i_wdata[18]  ^!i_wdata[17]  ^!i_wdata[16]  
 ^!i_wdata[15]  ^!i_wdata[14]  ^!i_wdata[13]  ^!i_wdata[12]  
 ^!i_wdata[11]  ^!i_wdata[10]  ^!i_wdata[9]   ^!i_wdata[8]   
 ^!i_wdata[7]   ^!i_wdata[6]   ^!i_wdata[5]   ^!i_wdata[4]   
 ^!i_wdata[3]   ^!i_wdata[2]   ^!i_wdata[1]   ^!i_wdata[0];

assign r_eccdata[3] = 
  i_wdata[31]  ^i_wdata[30]  ^i_wdata[29]  ^i_wdata[28] 
 ^i_wdata[27]  ^i_wdata[26]  ^i_wdata[25]  ^i_wdata[24]   
 ^i_wdata[23]  ^i_wdata[22]  ^i_wdata[21]  ^i_wdata[20]  
 ^i_wdata[19]  ^i_wdata[18]  ^i_wdata[17]  ^i_wdata[16]  
 ^i_wdata[15]  ^i_wdata[14]  ^i_wdata[13]  ^i_wdata[12]  
 ^i_wdata[11]  ^i_wdata[10]  ^i_wdata[9]   ^i_wdata[8]   
 ^i_wdata[7]   ^i_wdata[6]   ^i_wdata[5]   ^i_wdata[4]   
 ^i_wdata[3]   ^i_wdata[2]   ^i_wdata[1]   ^i_wdata[0];

 assign r_eccdata[2] = 
  !i_wdata[31]  ^!i_wdata[30]  ^!i_wdata[29]  ^!i_wdata[28] 
 ^!i_wdata[27]  ^!i_wdata[26]  ^!i_wdata[25]  ^!i_wdata[24]   
 ^!i_wdata[23]  ^!i_wdata[22]  ^!i_wdata[21]  ^!i_wdata[20]  
 ^!i_wdata[19]  ^!i_wdata[18]  ^!i_wdata[17]  ^!i_wdata[16]  
 ^!i_wdata[15]  ^!i_wdata[14]  ^!i_wdata[13]  ^!i_wdata[12]  
 ^!i_wdata[11]  ^!i_wdata[10]  ^!i_wdata[9]   ^!i_wdata[8]   
 ^!i_wdata[7]   ^!i_wdata[6]   ^!i_wdata[5]   ^!i_wdata[4]   
 ^!i_wdata[3]   ^!i_wdata[2]   ^!i_wdata[1]   ^!i_wdata[0];

assign r_eccdata[1] = 
  i_wdata[31]  ^i_wdata[30]  ^i_wdata[29]  ^i_wdata[28] 
 ^i_wdata[27]  ^i_wdata[26]  ^i_wdata[25]  ^i_wdata[24]   
 ^i_wdata[23]  ^i_wdata[22]  ^i_wdata[21]  ^i_wdata[20]  
 ^i_wdata[19]  ^i_wdata[18]  ^i_wdata[17]  ^i_wdata[16]  
 ^i_wdata[15]  ^i_wdata[14]  ^i_wdata[13]  ^i_wdata[12]  
 ^i_wdata[11]  ^i_wdata[10]  ^i_wdata[9]   ^i_wdata[8]   
 ^i_wdata[7]   ^i_wdata[6]   ^i_wdata[5]   ^i_wdata[4]   
 ^i_wdata[3]   ^i_wdata[2]   ^i_wdata[1]   ^i_wdata[0];

assign r_eccdata[0] = 
  !i_wdata[31]  ^!i_wdata[30]  ^!i_wdata[29]  ^!i_wdata[28] 
 ^!i_wdata[27]  ^!i_wdata[26]  ^!i_wdata[25]  ^!i_wdata[24]   
 ^!i_wdata[23]  ^!i_wdata[22]  ^!i_wdata[21]  ^!i_wdata[20]  
 ^!i_wdata[19]  ^!i_wdata[18]  ^!i_wdata[17]  ^!i_wdata[16]  
 ^!i_wdata[15]  ^!i_wdata[14]  ^!i_wdata[13]  ^!i_wdata[12]  
 ^!i_wdata[11]  ^!i_wdata[10]  ^!i_wdata[9]   ^!i_wdata[8]   
 ^!i_wdata[7]   ^!i_wdata[6]   ^!i_wdata[5]   ^!i_wdata[4]   
 ^!i_wdata[3]   ^!i_wdata[2]   ^!i_wdata[1]   ^!i_wdata[0];

endmodule


