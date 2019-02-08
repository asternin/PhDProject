%Get trial order
set1=dir(['VolumeNormalized/','01-*']);
set2=dir(['VolumeNormalized/','02-*']);
set3=dir(['VolumeNormalized/','03-*']);
set4=dir(['VolumeNormalized/','04-*']);
set5=dir(['VolumeNormalized/','05-*']);
set6=dir(['VolumeNormalized/','06-*']);
set7=dir(['VolumeNormalized/','07-*']);
set8=dir(['VolumeNormalized/','08-*']);
set9=dir(['VolumeNormalized/','09-*']);
set10=dir(['VolumeNormalized/','10-*']);
%set=dir(['VolumeNormalized/','*.mp3']);
order=[92 152 122 102 112 62 142 82];
rng shuffle % reset random seed
songlist1=[];
songlist2=[];
songorder1=[];
songorder2=[];
for p=1:25
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=1:4
        songlist1{p,i}=[set1(s1(i)).folder,filesep,set1(s1(i)).name];
        songlist2{p,i}=[set1(s2(i)).folder,filesep,set1(s2(i)).name];
        songorder1(p,i)=order(s1(i));
        songorder2(p,i)=order(s2(i));
    end
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=5:8
        songlist1{p,i}=[set2(s1(i)).folder,filesep,set2(s1(i)).name];
        songlist2{p,i}=[set2(s2(i)).folder,filesep,set2(s2(i)).name];
        songorder1(p,i)=order(s1(i));
        songorder2(p,i)=order(s2(i));    
    end
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=9:12
        songlist1{p,i}=[set3(s1(1)).folder,filesep,set3(s1(1)).name];
        songlist2{p,i}=[set3(s2(1)).folder,filesep,set3(s2(1)).name];
    end
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=13:16
        songlist1{p,i}=[set4(s1(1)).folder,filesep,set4(s1(1)).name];
        songlist2{p,i}=[set4(s2(1)).folder,filesep,set4(s2(1)).name];
    end
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=17:20
        songlist1{p,i}=[set5(s1(1)).folder,filesep,set5(s1(1)).name];
        songlist2{p,i}=[set5(s2(1)).folder,filesep,set5(s2(1)).name];
    end
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=21:24
        songlist1{p,i}=[set6(s1(1)).folder,filesep,set6(s1(1)).name];
        songlist2{p,i}=[set6(s2(1)).folder,filesep,set6(s2(1)).name];
    end
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=25:28
        songlist1{p,i}=[set7(s1(1)).folder,filesep,set7(s1(1)).name];
        songlist2{p,i}=[set7(s2(1)).folder,filesep,set7(s2(1)).name];
    end
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=29:32
        songlist1{p,i}=[set8(s1(1)).folder,filesep,set8(s1(1)).name];
        songlist2{p,i}=[set8(s2(1)).folder,filesep,set8(s2(1)).name];
    end
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=33:36
        songlist1{p,i}=[set9(s1(1)).folder,filesep,set9(s1(1)).name];
        songlist2{p,i}=[set9(s2(1)).folder,filesep,set9(s2(1)).name];
    end
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=37:40
        songlist1{p,i}=[set10(s1(1)).folder,filesep,set10(s1(1)).name];
        songlist2{p,i}=[set10(s2(1)).folder,filesep,set10(s2(1)).name];
    end
end
save('songlist1.mat','songlist1');
save('songlist2.mat','songlist2');