%% Lesson 5d: File I/O
% We often need to parse data stored in files, or export data to files for
% persistent storage. For example, we may want to process an audio file, or
% export a generated image. We explore a few common file functions here!
clc; clear; close all;

%% Dumping and loading a workspace
% It may be useful to store your workspace so that you can come back to it
% later. This may be useful to save the results of an expensive
% computation or to save a reproducible dataset for use later. It is saved
% in a proprietary binary format only intended to be re-imported into
% MATLAB. (This process is known as (de)serialization, and is similar to
% Python's `pickle`.)

% Create some data for our workspace
a = 1:5;
b = struct('a', a, 'b', uint8(a), 'anotherfield', "a string");

% Traditionally, an exported MATLAB workspace has file extension .mat
save res/myWorkspaceDump.mat;

%%
clear;

%% Reloading the workspace
load res/myWorkspaceDump.mat

%% Reading from a text file
% `fopen` acts very similar to in C. It returns a file pointer (an integer
% >= 3; 0, 1, and 2 are reserved for stdin, stdout, and stderr,
% respectively.)
fp = fopen('res/grades.csv');

% `textscan` is very useful for CSV files.
C_text = textscan(fp, '%s', 4, 'Delimiter', '|');
C_data0 = textscan(fp, '%d %f %f %f');
C_data0{1};

%% Writing to a text file
fp = fopen('res/outputTextFile.txt', 'w');
fprintf(fp, '1 Januar 2014, 20.2, 100.5 \n');
fprintf(fp, '1 Februar 2014, 21.6, 102.7 \n');
fprintf(fp, '1 März 2014, 20.7, 99.8 \n');
fclose(fp);

%% Reading audio signal
[y, fs] = audioread("res/hallelujah.wav");

%% Playing an audio signal
soundsc(y, fs);

%% Exporting an audio signal
audiowrite("res/mySong.wav", y, fs);

%% Image I/O
% imread returns a HxWxC (height, width, channels) matrix.
% Sometimes image formats are finnicky, when in doubt use simple formats
% like bitmap (.bmp) files.
img = imread("res/lena.png");

%%
imshow(img);

%%
imwrite(img, "res/myImg.png");