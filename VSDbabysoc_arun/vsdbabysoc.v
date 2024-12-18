module vsdbabysoc (
   output wire OUT,
   //
   input  wire reset,
   //
   input  wire VCO_IN,
   input  wire ENb_CP,
   input  wire ENb_VCO,
   input  wire REF,
   //
   // input  wire VREFL,
   input  wire VREFH
);

   wire clk_arun;
   wire [9:0] RV_TO_DAC;

   rvmyth rvmyth(
      .OUT(RV_TO_DAC),
      .CLK(clk_arun),
      .reset(reset)
   );

   avsdpll avsdpll (
      .CLK(clk_arun),
      .VCO_IN(VCO_IN),
      .ENb_CP(ENb_CP),
      .ENb_VCO(ENb_VCO),
      .REF(REF)
   );

   avsddac avsddac (
      .OUT(OUT),
      .D(RV_TO_DAC),
      // .VREFL(VREFL),
      .VREFH(VREFH)
   );
   
endmodule
