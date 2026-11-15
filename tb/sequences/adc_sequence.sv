// Secuencia para aplicar un nivel constante de Vin.
class adc_sequence extends uvm_sequence #(adc_transaction);
    `uvm_object_utils(adc_sequence)

    real vin_value;

    function new(string name = "adc_sequence");
        super.new(name);
        vin_value = 0.0;
    endfunction

    task body();
        adc_transaction req;

        req = adc_transaction::type_id::create("req");
        start_item(req);
        req.stimulus_kind = VIN_LEVEL;
        req.vin           = vin_value;
        finish_item(req);
    endtask

endclass
