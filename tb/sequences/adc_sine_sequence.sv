class adc_sine_sequence extends uvm_sequence #(adc_transaction);

    `uvm_object_utils(adc_sine_sequence)

    real amplitude;
    real offset;
    time period;
    time step;
    int  n_periods;

    function new(string name = "adc_sine_sequence");
        super.new(name);
    endfunction

    task body();
        adc_transaction req;

        req = adc_transaction::type_id::create("req");
        start_item(req);
        req.stimulus_kind  = VIN_SINE;
        req.sine_amplitude = amplitude;
        req.sine_offset    = offset;
        req.sine_period    = period;
        req.sine_step      = step;
        req.sine_periods   = n_periods;
        finish_item(req);
    endtask

endclass
