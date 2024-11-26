export DESIGN_NICKNAME = VSDbabysoc
export DESIGN_NAME = vsdbabysoc
export PLATFORM    = sky130hd
export VSDbabysoc_DIR = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)

#export VERILOG_FILES_BLACKBOX = $(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/*.v
export VERILOG_FILES =  $(sort $(wildcard $(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/IPs/*.v \
	 $(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/vsdbabysoc.v \
	 ))
	 
export VERILOG_INCLUDE_DIRS = $(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/include
export SDC_FILE      = $(wildcard $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/constraints.sdc)
export ADDITIONAL_LEFS = $(wildcard $(VSDbabysoc_DIR)/avsddac.lef) \
			$(wildcard $(VSDbabysoc_DIR)/avsdpll.lef)
export ADDITIONAL_LIBS = $(wildcard $(VSDbabysoc_DIR)/lib/*.lib)
export ADDITIONAL_GDS  = $(wildcard $(VSDbabysoc_DIR)/gds)

export PLACE_OPT_CONGESTION_DRIVEN = 1

#export FP_PIN_ORDER_CFG = $(wildcard $ (VSDbabysoc_DIR)/pin_order.cfg)
export FP_SIZING = absolute
export DIE_AREA = 0 0 3000 3000
export CORE_AREA = 50 50 2900 2900

export global_pins_spacing = 20


#export BOTTOM_MARGIN_MULT = 50
#export TOP_MARGIN_MULT = 50
#export LEFT_MARGIN_MULT = 200
#export RIGHT_MARGIN_MULT = 200


export MACRO_PLACEMENT = $(VSDbabysoc_DIR)/macro.cfg

 export RTLMP_BOUNDARY_WT = 0
 #export MACRO_PLACE_HALO = 200 200
 export MACRO_PLACE_CHANNEL = 250 250
 export avsddac_place_halo  = 20 20 20 20
 export avsdpll_place_halo  = 20 20 20 20
 export riscv_pri_routing_halo = 10 10 10 10

#export CORE_UTILIZATION = 30
export PLACE_DENSITY_LB_ADDON = 0.1

export REMOVE_ABC_BUFFERS = 1







