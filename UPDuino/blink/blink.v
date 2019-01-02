//----------------------------------------------------------------------------
//                                                                          --
//                         Module Declaration                               --
//                                                                          --
//----------------------------------------------------------------------------
module blink 
(
  output  wire        REDn,       // Red
  output  wire        BLUn,       // Blue
  output  wire        GRNn        // Green
);
  reg         rstn;
  reg [27:0]  frequency_counter_i;

  SB_HFOSC  u_SB_HFOSC(.CLKHFPU(1), .CLKHFEN(1), .CLKHF(int_osc));

  always @(posedge int_osc) begin
    frequency_counter_i <= frequency_counter_i + 1'b1;
  end

  SB_RGBA_DRV RGB_DRIVER ( 
    .RGBLEDEN (1'b1),
    .RGB0PWM  (frequency_counter_i[24]&frequency_counter_i[23]),
    .RGB1PWM  (frequency_counter_i[24]&~frequency_counter_i[23]),
    .RGB2PWM  (~frequency_counter_i[24]&frequency_counter_i[23]),
    .CURREN   (1'b1), 
    .RGB0     (REDn),		//Actual Hardware connection
    .RGB1     (GRNn),
    .RGB2     (BLUn)
  );
  defparam RGB_DRIVER.RGB0_CURRENT = "0b000001";
  defparam RGB_DRIVER.RGB1_CURRENT = "0b000001";
  defparam RGB_DRIVER.RGB2_CURRENT = "0b000001";
endmodule