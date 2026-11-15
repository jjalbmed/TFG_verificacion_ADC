class adc_driver extends uvm_driver #(adc_transaction);

    `uvm_component_utils(adc_driver)

    virtual gp_adc_interface.driver vif;

    function new(string name="adc_driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(virtual gp_adc_interface.driver)::get(this, "", "vif", vif))
            `uvm_fatal("NO VIF", "VIF no declarada")

    endfunction


    task automatic drive_sine(adc_transaction sine_req);

        int  n_steps;
        real pi;
        real normalized_time;

        if ((sine_req.sine_period == 0) ||(sine_req.sine_step == 0) ||(sine_req.sine_periods <= 0)) begin

            `uvm_error("DRV", "VIN_SINE requiere periodo, step y numero de periodos validos")

            return;

        end

        pi = 3.141592653589793;
        n_steps = sine_req.sine_periods *(sine_req.sine_period / sine_req.sine_step);

        for (int i = 0; i <= n_steps; i++) begin

            normalized_time =
                (real'(i) * real'(sine_req.sine_step)) / real'(sine_req.sine_period);

            vif.vin = sine_req.sine_offset + sine_req.sine_amplitude * $sin(2.0 * pi * normalized_time);

            #(sine_req.sine_step);

        end

    endtask


    task run_phase(uvm_phase phase);

        forever begin

            seq_item_port.get_next_item(req);

            case (req.stimulus_kind)

                VIN_LEVEL: begin

                    `uvm_info("DRV", $sformatf("ADC vin = %0.3f", req.vin), UVM_LOW)

                    // Se aplica tras el flanco para que Vin sea estable en el siguiente muestreo.
                    @(vif.driver_cb);

                    // El clocking block define la relación de planificación con el flanco de reloj.
                    vif.driver_cb.vin <= req.vin;
                end

                VIN_SINE: begin
                    `uvm_info("DRV","Generando estimulo VIN_SINE", UVM_LOW)

                    drive_sine(req);

                end

                default: begin

                    `uvm_error("DRV", "Tipo de estimulo Vin no soportado")
                end

            endcase

            seq_item_port.item_done();

        end

    endtask

endclass
