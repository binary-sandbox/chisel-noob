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

  wire led[2:0];

  blink_core blink0(
    .clock(int_osc),
    .reset(rstn),
    .io_led1(led[0]),
    .io_led2(led[1]),
    .io_led3(led[2])
  ); // CHISEL 3 Generator
  
  SB_RGBA_DRV RGB_DRIVER ( 
    .RGBLEDEN (1'b1),
    .RGB0PWM  (led[0]),
    .RGB1PWM  (~led[1]),
    .RGB2PWM  (led[0]|led[1]),
    .CURREN   (1'b1), 
    .RGB0     (REDn),		//Actual Hardware connection
    .RGB1     (GRNn),
    .RGB2     (BLUn)
  );
  defparam RGB_DRIVER.RGB0_CURRENT = "0b000001";
  defparam RGB_DRIVER.RGB1_CURRENT = "0b000001";
  defparam RGB_DRIVER.RGB2_CURRENT = "0b000001";
endmodule