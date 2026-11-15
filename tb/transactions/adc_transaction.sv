typedef enum {
    VIN_LEVEL,
    VIN_SINE
} vin_stimulus_kind_e;


class adc_transaction extends uvm_sequence_item;

    `uvm_object_utils(adc_transaction)

    // Entrada analógica
    real vin;

    // Tipo de estímulo aplicado sobre Vin.
    vin_stimulus_kind_e stimulus_kind;

    // Parámetros de una senoide finita.
    real sine_amplitude;
    real sine_offset;
    time sine_period;
    time sine_step;
    int  sine_periods;

    // Salida analógica
    real vout;

    // Código digital producido por SARR
    bit [7:0] adc_code;

    // Indica que el código corresponde a una conversión completa
    bit conversion_done;


    function new(string name = "adc_transaction");
        super.new(name);

        stimulus_kind  = VIN_LEVEL;
        vin            = 0.0;
        sine_amplitude = 0.0;
        sine_offset    = 0.0;
        sine_period    = 0;
        sine_step      = 0;
        sine_periods   = 0;
        adc_code       = 8'h00;
        conversion_done = 1'b0;
    endfunction : new

endclass : adc_transaction
