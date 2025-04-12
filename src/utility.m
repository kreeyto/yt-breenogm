clc; clearvars; close all
addpath(fullfile(pwd, '..', 'functions'));

%%%% LOAD ARRAYS %%%%
load("soundfms.mat");
load("panfms.mat");
%%%%%%%%%%%%%%%%%%%%

arraynames = who;
sons = eval(arraynames{2});
pans = eval(arraynames{1});
nsoundfiles = numel(eval(arraynames{2}));
fpath = "D:\\MATLAB\\A NOVA HERA\\media\\pendulumSons\\pendulum";
apath = "D:\\MATLAB\\A NOVA HERA\\media\\pendulumSons\\composites\\";

frames = genArray(nsoundfiles, fpath, sons, pans);
genAudio(frames, apath, 60, 0, 10);
