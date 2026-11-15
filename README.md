# Entorno de verificación UVM de un ADC SAR de 8 bits

Código desarrollado en el marco de un Trabajo de Fin de Grado (TFG) para la verificación *mixed-signal* de un conversor analógico-digital de aproximaciones sucesivas (SAR) de 8 bits.

El trabajo se centra en el **desarrollo de un entorno de verificación en SystemVerilog/UVM** que estimula, supervisa y comprueba el comportamiento de un modelo de ADC realizado en Verilog-A/AMS.

## Descripción del proyecto

El dispositivo bajo prueba (DUT) es un ADC SAR de 8 bits con una tensión de referencia de **1,8 V** y 256 códigos de salida (0–255). Su jerarquía incluye muestreo y retención, comparador, DAC capacitivo, lógica SAR y registro de salida.

El banco de pruebas conecta el dominio SystemVerilog con el modelo analógico mediante señales `wreal` y elementos de frontera configurados para Questa ADMS. El entorno UVM incorpora:

- **Driver y secuencias** para aplicar niveles de tensión y estímulos senoidales.
- **Monitor** para detectar las conversiones y recoger las muestras y los códigos digitales.
- **Scoreboard** para comparar las conversiones con un modelo ideal de cuantificación de 8 bits.
- **Cobertura funcional** de los códigos de entrada cuantificados y los códigos de salida del ADC.
- **Test de cobertura dirigida**, que selecciona nuevos estímulos según los códigos pendientes de cubrir.

## Estructura del repositorio

```text
.
├── dut/                    # Modelos Verilog-A/AMS del ADC SAR
├── tb/
│   ├── agent/              # Driver, monitor, sequencer y agent UVM
│   ├── env/                # Entorno, scoreboard y cobertura funcional
│   ├── interfaces/         # Interfaz SystemVerilog
│   ├── sequences/          # Secuencias de estímulos
│   ├── transactions/       # Transacción UVM
│   ├── adc_tb_pkg.sv       # Package del entorno de verificación
│   └── tb_top.sv           # Testbench UVM y generación del reloj
├── tests/                 # Tests UVM
├── sim/ms_sample_hold.cmd # Configuración mixed-signal de Questa ADMS
├── test_fixture.sv        # Integración del DUT con el testbench
└── recompile_all.sh       # Script de compilación del proyecto
```

## Tests disponibles

| Test | Finalidad |
| --- | --- |
| `adc_full_test` | Comprueba conversiones con entradas de 0 V y 1,8 V. |
| `adc_sh_sine_test` | Aplica una entrada senoidal para verificar el seguimiento de la señal. |
| `adc_full_coverage_test` | Genera estímulos dirigidos para intentar alcanzar el 100 % de cobertura funcional. |
| `adc_base_test` | Clase base común utilizada por los tests anteriores. |

El archivo `tests/burner_test.sv` contiene, por separado, una prueba básica de funcionamiento de UVM y no forma parte de la suite principal compilada por `recompile_all.sh`.

## Herramientas y ejecución

El proyecto se ha desarrollado para un entorno local de **Siemens Questa / Questa ADMS y Eldo**, con soporte para SystemVerilog, UVM y Verilog-A/AMS. Se necesita una instalación y licencia válidas de estas herramientas.

Desde el directorio raíz del proyecto, la compilación se realiza mediante:

```bash
./recompile_all.sh
```

Ejemplo de ejecución del test de cobertura:

```bash
vasim -c -coverage -cmd sim/ms_sample_hold.cmd work.test_fixture +UVM_TESTNAME=adc_full_coverage_test -do "run -all; quit -f"
```

Para seleccionar otro test de la suite principal, se sustituye el valor de `+UVM_TESTNAME` por `adc_full_test` o `adc_sh_sine_test`.

**Nota sobre la reproducción:** el script de compilación y algunos `include` contienen rutas absolutas correspondientes al entorno de desarrollo original. Los comandos se documentan como referencia del entorno utilizado; pueden necesitar ajustes en otra instalación. Los archivos de configuración propios de Siemens, las bibliotecas compiladas y los resultados de simulación no se distribuyen en este repositorio.

## Autoría y procedencia

- **Entorno de verificación SystemVerilog/UVM:** José Javier Alberich Medina.
- **Modelo del ADC SAR en Verilog-A/AMS:** Joan Ferri Montes, procedente de su TFG e incluido con su autorización.

La inclusión del modelo del ADC con autorización no presupone una licencia abierta de reutilización por terceros. No se declara una licencia global para el conjunto del repositorio en este documento.



