function signal = low_pass(x, fs, cutoff_freq)
  signal = 0;
  x_fft = fft(x);
  n = length(x_fft);
  k = fs/n;
  f = zeros(n,1);
  for i = 1:n
    f(i,1) = (i-1) * k;
  end
  mask = zeros(n,1);
  for i = 1:n
    mask(i,1) = f(i,1) < cutoff_freq;
  end
  new_x = x_fft .* mask;
  filtered_signal = ifft(new_x);
  filtered_signal = filtered_signal / max(abs(filtered_signal));
  signal = filtered_signal;
endfunction

