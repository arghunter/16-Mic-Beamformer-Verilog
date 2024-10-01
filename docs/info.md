<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works
The 16 Microphone Beamformer performs delay and sum beamforming an 16 microphones and outputs an I2S stream for easy processing. First the microphone data is passed in through 8 input pins in DDR(Double Data Rate) format. From there the chip converts the data to SDR (Single Data Rate); 1 wire per microphone. The microphone data is then summed and passed through a 3-stage CIC (Cascading Integrator Comb) Filter to convert it from PDM (Pulse Density Modulation) format to PCM (Pulse-code Modulation). This is then outputted by a I2S bus.

## How to test
You can test it (testing)
Explain how to use your project

## External hardware
You need 16 digital microphones, a clock generator (can be a raspberry pi, microcontroller, etc.), and something that recieves the I2S output (this can be a rapberry pi or most auido output devices).
List external hardware used in your project (e.g. PMOD, LED display, etc), if any
