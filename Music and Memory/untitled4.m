figure
datpath = '/Users/asternin/Documents/PhDProject.git/Music and Memory - Lucy/Stimuli/NotNormalized';
cd(datpath)
fn = dir(sprintf('*.mp3',datpath));{fn.name}'
for dat = 1:size(fn,1)
song=audioread(fn(dat).name,'native');
%songmean_not(dat,:)=mean(song);
plot(song)
title('Not Normalized')
hold on
end

figure
plot(songmean_not)
datpath = '/Users/asternin/Documents/PhDProject.git/Music and Memory - Lucy/Stimuli/PeakNormalized';
cd(datpath)
fn = dir(sprintf('*.mp3',datpath));{fn.name}'
for dat = 1:size(fn,1)
song=audioread(fn(dat).name,'native');
songmean_peak(dat,:)=mean(song);
end

figure
datpath = '/Users/asternin/Documents/PhDProject.git/Music and Memory - Lucy/Stimuli/VolumeNormalized';
cd(datpath)
fn = dir(sprintf('*.mp3',datpath));{fn.name}'
for dat = 1:size(fn,1)
song=audioread(fn(dat).name,'native');
%songmean_volume(dat,:)=mean(song);
plot(song)
title('Volume Normalized')
hold on
end

plot(songmean_not)
hold on; plot(songmean_peak)
hold on; plot(songmean_volume)