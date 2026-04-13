module tt_um_icell (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire ena,
    input  wire clk,
    input  wire rst_n
);

    wire VPWR;
    wire VGND;

    wire Rn    = ui_in[0];
    wire Cn    = ui_in[1];
    wire Sn    = ui_in[2];
    wire Vbias = uio_in[0];

    wire Iout;

    icell uut (
        .VPWR(VPWR),
        .VGND(VGND),
        .Rn(Rn),
        .Cn(Cn),
        .Sn(Sn),
        .Vbias(Vbias),
        .Iout(Iout)
    );

    assign uo_out[0] = Iout;

    assign uo_out[7:1] = 0;
    assign uio_out = 0;
    assign uio_oe  = 0;

endmodule
