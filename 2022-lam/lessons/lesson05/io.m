%% Lesson 5d: File I/O
% Very often, you would need to process files that are not already in
% MATLAB. For instance, if you have a commo separated value file (csv),
% you would need to find a systematic way to load all your data into
% MATLAB. Moreover, you might also want to export figures and data from
% MATLAB, hence the need to learn file IO. I am only convering a subset of
% file IO in this MATLAB, more information can be found in the
% documentation.

%% Importing Data
load('mypic.mat');                % Import a .mat file

%%
fileID = fopen('grades.txt');             % Returns file indentifier >= 3 (0 = stdin, 1 = stdout, 2 = stderr)
C_text = textscan(fileID,'%s',4,'Delimiter','|')    % Import a textfile
C_data0 = textscan(fileID,'%d %f %f %f')
C_data0{1}

%% Exporting Data
save('allData')                  % saves your whole workspace into a .mat file

%%
fileID = fopen('myFile.txt','w');
fprintf(fileID,'1 Januar 2014, 20.2, 100.5 \n');
fprintf(fileID,'1 Februar 2014, 21.6, 102.7 \n');
fprintf(fileID,'1 März 2014, 20.7, 99.8 \n');
fclose(fileID);

%% Reading audio signal
[y, fs] = audioread("hallelujah.wav");

%% Playing an audio signal
soundsc(y, fs);

%% Exporting an audio signal
audiowrite("mySong.wav", y, fs);