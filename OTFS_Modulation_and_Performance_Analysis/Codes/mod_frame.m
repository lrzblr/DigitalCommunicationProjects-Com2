%Modulasyon

X_dt = M * ifft(X, M, 2); %Antitransformasyon
s1 = reshape(X_dt, N * M, 1); 