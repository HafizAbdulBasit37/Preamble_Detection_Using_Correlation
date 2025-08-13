# QPSK Preamble Detection Using Correlation in MATLAB

## Overview

This project implements a **QPSK preamble detection** algorithm using correlation in MATLAB. It simulates the generation of a preamble and payload bit sequences, combines them into a QPSK-modulated signal, and detects the preamble via cross-correlation. The approach is fundamental for synchronization and packet detection in digital communication systems.

---

## Features

- Preamble generation using known I/Q bit sequences  
- QPSK modulation with 4-level constellation mapping  
- Payload data creation with repeated bit sequences  
- Signal upsampling for oversampling simulation  
- Concatenation of preamble and payload signals  
- Preamble detection using convolution-based correlation  
- Multiple plots for visualization of signals and constellation  

---

## Requirements

- MATLAB R2018b or later (compatible with earlier versions)  
- Basic MATLAB knowledge for running scripts and viewing plots  

---

## Usage

1. Clone or download this repository.  
2. Open `preamble_detection.m` (or the provided MATLAB script) in MATLAB.  
3. Run the script.  
4. Review generated plots:
   - Correlation magnitude showing preamble detection  
   - Time-domain waveforms for preamble and payload (I and Q)  
   - QPSK constellation diagram  
   - Signal magnitude and phase  

---

## How It Works

- Define amplitude scaling and samples per bit (oversampling).  
- Create known preamble bit sequences for I and Q channels, then upsample.  
- Generate QPSK symbols using bit combinations mapped to ±A levels.  
- Create payload sequences and similarly modulate and upsample.  
- Concatenate preamble and payload signals in both I and Q branches.  
- Combine I and Q to form a complex baseband signal.  
- Use convolution between the received signal and conjugate-flipped preamble to detect the start of the packet.  
- The peak in correlation magnitude indicates preamble location.  

---

## Plots Included

- Correlation magnitude vs. sample index  
- Preamble I and Q amplitude plots  
- Payload I and Q signal waveforms  
- Combined I and Q signals (preamble + payload)  
- QPSK constellation points of the preamble  
- Real and imaginary parts of combined signal  
- Magnitude and phase of combined signal  

---

## Example Plot: Correlation Result

![Correlation Result](docs/correlation_plot.png)

*(Replace above image with your actual plot if uploading screenshots)*

---

## Applications

- Wireless communication systems  
- Digital modem and receiver design  
- Signal synchronization and frame detection  
- Software-defined radio (SDR) development  
- Communication systems research and education  

---

## Author

**Abdul Basit**  
Electrical and Electronics Engineer | FPGA & DSP Enthusiast  
[LinkedIn Profile](https://www.linkedin.com/in/yourprofile)  
[GitHub](https://github.com/yourgithub)  

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Contact

Feel free to reach out for questions, collaboration, or improvements!  

---

