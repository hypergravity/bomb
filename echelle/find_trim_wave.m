function [ wave_trim1, wave_trim2 ] = find_trim_wave( wave, flux, npix_med, flux_cut )
%UNTITLED19 Summary of this function goes here
%   Detailed explanation goes here

wave_len = length(wave);


i = npix_med + 1;
while median(flux(i-npix_med:i+npix_med)) < flux_cut & i < wave_len/2
    i = i + 1;
end

j = wave_len - npix_med;
while median(flux(j-npix_med:j+npix_med)) < flux_cut & j > wave_len/2
    j = j - 1;
end


if wave(1) < wave(2)
    wave_trim1 = wave(i);
    wave_trim2 = wave(j);
else
    wave_trim1 = wave(j);
    wave_trim2 = wave(i);
end



end

