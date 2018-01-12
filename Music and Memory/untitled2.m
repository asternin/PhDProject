song1_r=audioread('NotNormalized/20th Century - Whole.wav','native');
song2_r=audioread('NotNormalized/Americans - Whole.wav');
song3_r=audioread('NotNormalized/Fun loving angels - Instrumental.wav');
song4_r=audioread('NotNormalized/Half Life - Instrumental.wav');
song5_r=audioread('NotNormalized/Notting Hill - Sung.wav');
song6_r=audioread('NotNormalized/waving not drowning - Sung.wav');
song7_r=audioread('NotNormalized/Sold - Spoken.mp3');
song8_r=audioread('NotNormalized/Thinking About You - Spoken.mp3');
songs_r={song1_r,song2_r,song3_r,song4_r,song5_r,song6_r,song7_r,song8_r};
datpath = '/Users/asternin/Documents/PhDProject.git/Music and Memory - Lucy/Stimuli/VolumeNormalized';
cd(datpath)
fn = dir(sprintf('ISS*.mp3',datpath));{fn.name}'
for i = 1:length(songs_r);
tmp=my_normalize(songs_r{i}(:,2),-20,'r');
figure
plot(tmp);
hold on;
plot(audioread(fn(i).name));
end