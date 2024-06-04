function x = oscillator(freq, fs, dur, A, D, S, R)
  format long
  x = 0;
  no = fs * dur;
  no = int64(no);
  t = (0:1/fs:dur)';
  t = t(1:no);
  wave = sin(2*pi*freq*t);
  no_A = floor(A*fs);
  no_D = floor(D*fs);
  no_R = floor(R*fs);
  no_S = no - no_A - no_D - no_R;
  A_ramp = linspace(0,1, no_A)';
  D_ramp = linspace(1, S, no_D)';
  R_ramp = linspace(S, 0, no_R)';
  S_ramp(1:no_S,1) = S;
  final_env = zeros(no,1);
  for k = 1:no_A
    final_env(k,1) = A_ramp(k,1);
  end
  for k = 1:no_D
    final_env(k+no_A,1) = D_ramp(k,1);
  end
  for k = 1:no_R
    final_env(k+no_A+no_D,1) = R_ramp(k,1);
  end
  for k = 1:no_S
    final_env(k+no-no_S,1) = S_ramp(k,1);
  end
  x = wave .* final_env;
endfunction

