`timescale 1ns/1ps

import uvm_pkg::*;
import adc_tb_pkg::*;
`include "uvm_macros.svh"

module tb_top(gp_adc_interface intf);

    import uvm_pkg::*;
    import adc_tb_pkg::*;

    // Generación de reloj.
    initial begin
        intf.clk = 0;
        forever #5 intf.clk = ~intf.clk;
    end

    // Configuración UVM.
    initial begin
        uvm_config_db#(virtual gp_adc_interface.driver)::set(null,"uvm_test_top.env.agent.driver","vif",intf.driver);

        uvm_config_db#(virtual gp_adc_interface.monitor)::set(null,"uvm_test_top.env.agent.monitor","vif",intf.monitor);

        run_test(); // Selección del test mediante argumentos de simulación.

    end

endmodule
