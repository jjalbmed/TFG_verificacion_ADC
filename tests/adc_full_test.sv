class adc_full_test extends adc_base_test;

    `uvm_component_utils(adc_full_test)

    function new(
        string name = "adc_full_test",
        uvm_component parent = null
    );
        super.new(name, parent);
    endfunction


    task run_phase(uvm_phase phase);

        adc_sequence seq;

        phase.raise_objection(this);

        //--------------------------------------------------
        // Primera entrada
        //--------------------------------------------------
        seq = adc_sequence::type_id::create("vin_zero_seq");
        seq.vin_value = 0.0;
        seq.start(env.agent.sequencer);

        `uvm_info(
            "ADC_FULL",
            "Aplicando Vin = 0.0 V",
            UVM_LOW
        )

        // Tiempo suficiente para que ocurra una conversión completa
        #250ns;


        //--------------------------------------------------
        // Segunda entrada
        //--------------------------------------------------
        seq = adc_sequence::type_id::create("vin_fullscale_seq");
        seq.vin_value = 1.8;
        seq.start(env.agent.sequencer);

        `uvm_info(
            "ADC_FULL",
            "Aplicando Vin = 1.8 V",
            UVM_LOW
        )

        // Tiempo suficiente para otra conversión
        #250ns;


        phase.drop_objection(this);

    endtask : run_phase

endclass : adc_full_test
