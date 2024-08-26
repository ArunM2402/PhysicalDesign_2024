`timescale 1ns / 1ps
`ifdef PRE_SYNTH_SIM
   `include "arunn_rvmyth.v"
   `include "clk_gate.v"
`endif

module tb;
   reg reset;
   reg clk_arun;
   wire [9:0] OUT;

   //instantiate core module
   rvmyth dut(
      .OUT(OUT),
      .CLK(clk_arun), //self defined clock
      .reset(reset)
   );
   
   

   initial begin
      reset = 0; 
      clk_arun=0;  //initial clk
      #10 reset = 1;
      #100 reset = 0; //reset low
      #100000 $finish;
   end


   always
    begin
      #5 clk_arun= ~clk_arun; //generate clk
    end
   initial begin
`ifdef PRE_SYNTH_SIM
      $dumpfile("pre_synth_sim.vcd"); //create dump file
`endif
      $dumpvars(0,tb);
   end
