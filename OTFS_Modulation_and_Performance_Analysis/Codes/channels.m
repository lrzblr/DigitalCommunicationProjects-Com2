% Kanal Parametreleri
taps = 2;
g = [1 0.4];
l = [0 1];
k = [0 -1];
% Kimlik Matrisi:
In = eye(N);
Im = eye(M);
% FFT Matrisi:
Fn = dftmtx(N);
Fm = dftmtx(M);

% Gecikme - Doppler Kanal Matrisi:
Hdd = zeros(N, M);
for t = 1 : length(g)
    Hdd(l(t) + 1, k(t) + (M / 2)) = g(t);
end

% Gecikme - Zaman Tepki Kanalı :
gs = zeros(N, N * M);
Z = exp((2 * pi * 1j)/(N * M));
for a = 1 : N     
    for q = 1 : N * M
        for i = 1 : taps
            if a == l(i) + 1
                gs(a, q) = gs(a, q) + g(i) * Z ^ (k(i) * (q - 1 - l(i)));
            end
        end
    end
end

P = zeros(N * M, N * M);
for a = 1 : M
    for b = 1 : N
        E = zeros(N, M);
        E(b, a) = 1;
        P((a - 1) * N + 1 : a * N, (b - 1) * M + 1 : b * M) = E;
    end
end

% Gecikme - Zaman Kanal Matrisi:
G = zeros(N * M, N * M);
for q = 1 : N * M
	for ell = 1 : N
		if(q >= ell)
			G(q, q - ell + 1) = gs(ell, q);
		end
	end
end


% Gecikme - Doppler Kanal Matrisi:
H = (1 / M) * kron(In, Fm) * (P' * G * P) * kron(In, Fm');