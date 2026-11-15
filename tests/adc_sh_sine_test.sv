class adc_sh_sine_test extends adc_base_test;

    `uvm_component_utils(adc_sh_sine_test)

    function new(string name = "adc_sh_sine_test",
                 uvm_component parent = null);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);

        adc_sine_sequence seq;

        phase.raise_objection(this);

        // Senoide entre 0.5 V y 1.5 V
        seq = adc_sine_sequence::type_id::create("seq");
        seq.amplitude = 0.5;
        seq.offset    = 1.0;

        // Senoide más lenta:
        // ~20 conversiones SAR por periodo
        seq.period = 2000ns;

        // Actualización de Vin cada 500 ps
        seq.step = 500ps;

        // Simular 2 periodos completos = 4 us
        seq.n_periods = 2;

        seq.start(env.agent.sequencer);

        #1ns;

        phase.drop_objection(this);

    endtask

endclass
