clear all
close all
clc


path='/Users/loictadrist/Desktop/lafleche2018/Documents/';
GPX= 'la-trace-Pays-Basque.gpx';

fileID = fopen([path GPX]);
C = textscan(fileID,'%s','Delimiter',{'<ele>','</ele>'});
fclose(fileID);

V=C{1};
A=15:4:length(V);
elevation=str2double(V(A(1:end-1)));
B=13:4:length(V);
data = V(B(1:end-1));
data=cell2mat(data);
for i=1:length(elevation)
lat(i)=str2double(data(i,13:24));
lon(i)=str2double(data(i,32:43));
end

R_terre = 6371000.0;
lat1=lat(1:end-1);
lat2=lat(2:end);
lon1=lon(1:end-1);
lon2=lon(2:end);
dLat =(lat2-lat1)*pi/180;
dLon =(lon2-lon1)*pi/180; 
hav = sin(dLat/2).^2+cos((lat1)*pi/180).*cos((lat2)*pi/180).*sin(dLon/2).^2; 
delta_dist = 2*R_terre * asin(sqrt(hav));

dist=[0,cumsum(delta_dist)]/1000;

filename1 = [path 'data_elevation.txt'];
%filename2 = [path 'Position_GPS.txt'];

fileID = fopen(filename1,'w');
fprintf(fileID,'%9s\n','data : [{');
for i=1:length(elevation)
fprintf(fileID,'%12s\n',['x: ' num2str(dist(i)) ',']);
fprintf(fileID,'%12s\n',['y: ' num2str(elevation(i))]);
fprintf(fileID,'%3s\n',['},{']);
end
fprintf(fileID,'%9s\n','}]');
fclose(fileID);




