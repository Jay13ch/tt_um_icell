# OpenLane configuration for tt_um_jaycam_icell wrapper

set ::env(DESIGN_NAME) "tt_um_jaycam_icell"

# Point to your top-level wrapper
set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/src/tt_um_jaycam_icell.v]

# Clock configuration (required by the TT wrapper logic)
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "20.0"

# --- Hard Macro Integration ---
# Point OpenLane to your analog GDS and LEF
set ::env(EXTRA_LEFS) [list $::env(DESIGN_DIR)/lef/icell.lef]
set ::env(EXTRA_GDS_FILES) [list $::env(DESIGN_DIR)/gds/icell.gds]

# Inform OpenLane of the SPICE netlist for top-level LVS
set ::env(EXTRA_SPICE_MODELS) [list $::env(DESIGN_DIR)/spice/icell.spice]

# --- Power Distribution Network (PDN) Hooks ---
# Maps the global TT power nets (VPWR/VGND) to the pins inside your icell
# Format: <instance_name> <macro_VDD_pin> <top_VDD_net> <macro_GND_pin> <top_GND_net>
set ::env(FP_PDN_MACRO_HOOKS) "my_sensor_cell VPWR VPWR my_sensor_cell VGND VGND"

# --- Floorplanning ---
# Use a separate file to dictate exactly where the macro sits inside the wrapper
set ::env(MACRO_PLACEMENT_CFG) $::env(DESIGN_DIR)/macro.cfg

# Since this is a pre-routed analog block, prevent OpenLane from modifying it
set ::env(SYNTH_USE_SPATIAL_MEM) 0
set ::env(OBSERVE_MACRO_ROUTING_OBSTRUCTIONS) 1
set ::env(RUN_CTS) 0
set ::env(DIODE_INSERTION_STRATEGY) 0
