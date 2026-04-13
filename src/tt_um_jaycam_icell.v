`default_nettype none

module tt_um_jaycam_icell (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    inout  wire [7:0] ua,       // Analog pins
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // Tie off all unused digital outputs to 0
    assign uo_out  = 8'b0000_0000;
    assign uio_out = 8'b0000_0000;
    assign uio_oe  = 8'b0000_0000;

    // Instantiate your physical analog macro
    icell my_sensor_cell (
        `ifdef USE_POWER_PINS
        .VPWR  (VPWR),  // Power is handled globally by OpenLane PDN
        .VGND  (VGND),  // Ground is handled globally by OpenLane PDN
        `endif
        
        // Digital Inputs
        .Cn    (ui_in[0]),
        .Sn    (ui_in[1]),
        .Rn    (ui_in[2]),
        
        // Analog IOs
        .Vbias (ua[0]),
        .Iout  (ua[1])
    );

endmodule

// --------------------------------------------------------
// Black-box declaration of your LEF macro
// This tells the synthesis tool about your macro's pins
// --------------------------------------------------------
(* blackbox *)
module icell (
    `ifdef USE_POWER_PINS
    inout VPWR,
    inout VGND,
    `endif
    input Cn,
    input Sn,
    input Rn,
    inout Vbias,
    inout Iout
);
endmodule
