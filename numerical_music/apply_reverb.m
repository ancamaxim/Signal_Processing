function signal = apply_reverb(x, impulse_response)
  signal = 0;
  mono_imp = stereo_to_mono(impulse_response);
  signal = fftconv(x, mono_imp, 1);
  signal = signal / max(abs(signal));
endfunction

