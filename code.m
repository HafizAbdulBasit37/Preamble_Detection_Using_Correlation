%% QPSK Preamble Detection Using Correlation
% Author: Abdul Basit
% Description: Generate QPSK preamble and payload, combine signals, 
% and detect preamble using correlation.

clear; close all; clc;

%% Parameters
A = 16384;                   % Amplitude scaling factor
samples_per_bit = 16;        % Oversampling factor

%% Preamble Bit Sequences (I and Q)
preamble_I_bits = [0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1];
preamble_Q_bits = [0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1];

% Upsample preamble bits
preamble_I_upsampled = repelem(preamble_I_bits, samples_per_bit);
preamble_Q_upsampled = repelem(preamble_Q_bits, samples_per_bit);

% Scale preamble signals
preamble_I_signal = A * preamble_I_upsampled;
preamble_Q_signal = A * preamble_Q_upsampled;

% Convert to bit values (0 or 1)
preamble_I_bits_scaled = preamble_I_signal / A;
preamble_Q_bits_scaled = preamble_Q_signal / A;

% Combine I and Q bits into symbol values (0-3) for QPSK mapping
symbol_map = 2 * preamble_I_bits_scaled + preamble_Q_bits_scaled;
symbol_map = symbol_map(:);

%% Map symbols to QPSK constellation amplitudes
I_amplitude = zeros(size(symbol_map));
Q_amplitude = zeros(size(symbol_map));

for k = 1:length(symbol_map)
    switch symbol_map(k)
        case 0
            I_amplitude(k) = -A;
            Q_amplitude(k) = -A;
        case 1
            I_amplitude(k) = -A;
            Q_amplitude(k) =  A;
        case 2
            I_amplitude(k) =  A;
            Q_amplitude(k) = -A;
        case 3
            I_amplitude(k) =  A;
            Q_amplitude(k) =  A;
    end
end

%% Payload Bit Sequences (I and Q) and repetition
payload_I_bits = [1 1 1 1 0 0 1 0 0 0 0 1];
payload_Q_bits = [0 1 1 1 0 0 0 0 1 1 1 0];

repeat_times = 10;
payload_I_repeated = repmat(payload_I_bits, 1, repeat_times);
payload_Q_repeated = repmat(payload_Q_bits, 1, repeat_times);

% Map bits {0,1} to amplitudes {-A, +A}
payload_I_signal = A * (2 * payload_I_repeated - 1);
payload_Q_signal = A * (2 * payload_Q_repeated - 1);

% Upsample payload signals
payload_I_upsampled = repelem(payload_I_signal, samples_per_bit);
payload_Q_upsampled = repelem(payload_Q_signal, samples_per_bit);

%% Combine Preamble and Payload signals
I_combined = [I_amplitude; payload_I_upsampled(:)];
Q_combined = [Q_amplitude; payload_Q_upsampled(:)];

% Form complex baseband signal
S = I_combined + 1j * Q_combined;

% Known preamble complex signal for correlation
Preamble = I_amplitude + 1j * Q_amplitude;

%% Preamble detection via correlation
corr_result = conv(S, conj(flipud(Preamble)));

%% Visualization

% Correlation magnitude
figure;
plot(abs(corr_result), 'k', 'LineWidth', 1.5);
title('Correlation Result between received signal and Preamble');
xlabel('Sample Index');
ylabel('Correlation Magnitude');
grid on;

% Payload I & Q signals (first 200 samples)
figure;
subplot(2,1,1);
plot(payload_I_upsampled(1:200), 'b');
title('Payload I Signal (first 200 samples)');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(payload_Q_upsampled(1:200), 'r');
title('Payload Q Signal (first 200 samples)');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

% Preamble I & Q Amplitude
figure;
subplot(2,1,1);
plot(I_amplitude, 'b');
title('Preamble I Amplitude');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(Q_amplitude, 'r');
title('Preamble Q Amplitude');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

% Combined I & Q Signals
figure;
subplot(2,1,1);
plot(I_combined, 'b');
title('Combined I Signal (Preamble + Payload)');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(Q_combined, 'r');
title('Combined Q Signal (Preamble + Payload)');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

% QPSK Constellation diagram (Preamble)
figure;
plot(I_amplitude, Q_amplitude, 'ko', 'MarkerFaceColor', 'g');
title('QPSK Constellation (Preamble)');
xlabel('In-phase (I)');
ylabel('Quadrature (Q)');
grid on;
axis equal;

% Real and Imaginary parts of combined signal
figure;
subplot(2,1,1);
plot(real(S), 'b');
title('Real Part of Combined Signal S (I)');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(imag(S), 'r');
title('Imaginary Part of Combined Signal S (Q)');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

% Magnitude and Phase of combined signal
figure;
subplot(2,1,1);
plot(abs(S), 'b');
title('Magnitude of Combined Signal S');
xlabel('Sample Index');
ylabel('Magnitude');
grid on;

subplot(2,1,2);
plot(angle(S), 'r');
title('Phase of Combined Signal S');
xlabel('Sample Index');
ylabel('Radians');
grid on;

