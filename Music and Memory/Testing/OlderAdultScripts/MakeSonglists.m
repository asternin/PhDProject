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
    for i=1:4
        songlist1{p,i+4}=[set2(s1(i)).folder,filesep,set2(s1(i)).name];
        songlist2{p,i+4}=[set2(s2(i)).folder,filesep,set2(s2(i)).name];
        songorder1(p,i+4)=order(s1(i));
        songorder2(p,i+4)=order(s2(i));    
    end
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=1:4
        songlist1{p,i+8}=[set3(s1(i)).folder,filesep,set3(s1(i)).name];
        songlist2{p,i+8}=[set3(s2(i)).folder,filesep,set3(s2(i)).name];
        songorder1(p,i+8)=order(s1(i));
        songorder2(p,i+8)=order(s2(i));    
    end
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=1:4
        songlist1{p,i+12}=[set4(s1(i)).folder,filesep,set4(s1(i)).name];
        songlist2{p,i+12}=[set4(s2(i)).folder,filesep,set4(s2(i)).name];
        songorder1(p,i+12)=order(s1(i));
        songorder2(p,i+12)=order(s2(i));    
    end
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=1:4
        songlist1{p,i+16}=[set5(s1(i)).folder,filesep,set5(s1(i)).name];
        songlist2{p,i+16}=[set5(s2(i)).folder,filesep,set5(s2(i)).name];
        songorder1(p,i+16)=order(s1(i));
        songorder2(p,i+16)=order(s2(i));    
    end
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=1:4
        songlist1{p,i+20}=[set6(s1(i)).folder,filesep,set6(s1(i)).name];
        songlist2{p,i+20}=[set6(s2(i)).folder,filesep,set6(s2(i)).name];
        songorder1(p,i+20)=order(s1(i));
        songorder2(p,i+20)=order(s2(i));    
    end
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=1:4
        songlist1{p,i+24}=[set7(s1(i)).folder,filesep,set7(s1(i)).name];
        songlist2{p,i+24}=[set7(s2(i)).folder,filesep,set7(s2(i)).name];
        songorder1(p,i+24)=order(s1(i));
        songorder2(p,i+24)=order(s2(i));    
    end
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=1:4
        songlist1{p,i+28}=[set8(s1(i)).folder,filesep,set8(s1(i)).name];
        songlist2{p,i+28}=[set8(s2(i)).folder,filesep,set8(s2(i)).name];
        songorder1(p,i+28)=order(s1(i));
        songorder2(p,i+28)=order(s2(i));    
    end
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=1:4
        songlist1{p,32}=[set9(s1(i)).folder,filesep,set9(s1(i)).name];
        songlist2{p,32}=[set9(s2(i)).folder,filesep,set9(s2(i)).name];
        songorder1(p,i+32)=order(s1(i));
        songorder2(p,i+32)=order(s2(i));    
    end
    s=randperm(8);
    s1=s(1:4);
    s2=s(5:8);
    for i=1:4
        songlist1{p,i+36}=[set10(s1(i)).folder,filesep,set10(s1(i)).name];
        songlist2{p,i+36}=[set10(s2(i)).folder,filesep,set10(s2(i)).name];
        songorder1(p,i+36)=order(s1(i));
        songorder2(p,i+36)=order(s2(i));    
    end
end
save('songlist1.mat','songlist1');
save('songlist2.mat','songlist2');