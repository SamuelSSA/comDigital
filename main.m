close all;

%% Write an Audio File  
% Create a WAVE file from the example file |handel.mat|, and read the file
% back into MATLAB(R).   

%% 
% Write a WAVE (|.wav|) file in the current folder. 
load handel.mat

filename = 'handel.wav';
audiowrite(filename,y,Fs);
clear y Fs  

%% 
% Read the data back into MATLAB using |audioread|. 
%[y,Fs] = audioread(filename);  

%% 
% Listen to the audio.    

[audio_WAV,audio_sample_rate]=audioread(filename,'native');
audio_len=length(audio_WAV);
df=audio_sample_rate/audio_len;

interval=-audio_sample_rate/2:df:audio_sample_rate/2-df;
figure

FFT=fft(audio_WAV)/length(audio_WAV);

subplot(4,1,1)
plot(interval,abs(FFT));
title('FFT of Input Audio');
xlabel('Frequency(Hz)');
ylabel('Amplitude');

%%
subplot(4,1,2)
plot(audio_WAV);
title('.WAV audio');
xlabel('Samples');
ylabel('Amplitude');
%%

audio_WAV = int32(audio_WAV);
audio_WAV = audio_WAV + 32768;
audio_WAV = uint16(audio_WAV);
audio_bin = de2bi(audio_WAV);

subplot(4,1,3)
plot(audio_WAV);
title('.WAV audio OFFSET');
xlabel('Samples');
ylabel('Amplitude');
%%

subplot(4,1,4)
%plot(bi2de(audio_bin));
%title('.WAV audio bi2de');
%xlabel('Samples');
%ylabel('Amplitude');
%%

i = 1;
n = 1;

while n <= (length(audio_bin) - 4)
   symbol_value(i) = bi2de(audio_bin(n:n+3));
   i = i+1;
   n = n + 4;
end

t = 0:1/audio_sample_rate:1;
i = 1;

n = 1;
while n < length(symbol_value)
    
    if symbol_value(i) == 4
      % signal(i) = 2*cos(2*pi*);
    else
       signal(i) = 1;     
    end
   
    i = i + 1;
    n = n +1;
end

plot(signal);
title('SIGNAL');
xlabel('Samples');
ylabel('Amplitude');

%dataMod = qammod(symbol_value,16,'bin','PlotConstellation',true);

%%