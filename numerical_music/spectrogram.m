function [S f t] = spectrogram(signal, fs, window_size)
  format long
	S = 0;
  f = 0;
  t = 0;
  [n m] = size(signal);
  no = floor(n / window_size);
  h_w = hanning(window_size);
  for i = 1:no
    w = zeros(window_size);
    i1 = (i-1)*window_size+1;
    i2 = i*window_size;
    for k = i1:i2
      w(k-i1+1) = signal(k,1);
    endfor
    window = w .* h_w;
    w_2 = fft(window, window_size * 2);
    for j = 1:window_size
      S(j,i) = abs(w_2(j));
    endfor
  endfor
  k = fs/(window_size * 2);
  for i = 1:window_size
    f(i) = (i-1) * k;
  endfor
  k = (window_size) / fs;
  for i = 2:no
    t(i) = (i-1) * k;
  endfor
  t = t';
  f = f';
endfunction

