function [X, GI] = generate_DD_Frame1(N, M, mod_size)

% Bir çerçevedeki bilgi sembollerinin sayısı:
N_syms_per_frame = N*M;

% Bir çerçevedeki bilgi bitlerinin sayısı:
N_bits_per_frame = N_syms_per_frame * log2(mod_size);

% Rastgele bit üretimi:
tx_info_bits = randi([0,1], N_bits_per_frame, 1);
% tx_info_bits = [0; 0; 0; 1; 1; 1; 1; 0; 0; 0; 0; 1; 1; 1; 1; 0];

% QAM modülasyonu:
tx_info_symbols = qammod(tx_info_bits, mod_size, 'gray', 'InputType', 'bit');

% MxN OTFS gecikme-doppler çerçevesini oluşturma

X = reshape(tx_info_symbols, N, M);

GI = zeros(N, M);
GI(N/2, M/2) = 10;

end