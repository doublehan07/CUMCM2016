% @ Copyright Han ZHANG(haldak) | All rights reserved.

%========================================================================
% 2016 China Undergraduate Mathematical Contest of Modeling, Problem A.
% For details of the problem, please see ./CUMCM2016Problems

%========================================================================
% WARNING: NO COMMERCIAL USE!

% Please do not delete these comments when you fork repo or copy files.
% Thank you.

% If you have any questions, feel free to contact me on GitHub(@haldak).
%========================================================================

% Introduction to this program.

% - Click 'Run' on upper toolbox or just type 'ProblemGo' at Command Window.
% - H is the height of buoy under sea level.
% - If the HorizonFlag = 1, it indicates that not all the anchor chains
%   suspend in the sea. Then xHorizon gives the length of anchor chain
%   which is NOT at suspension condition.
% - If the SinkFlag = 1, means all the system sinks under sea level.
% - Ca[x,y] shows the coordianate of the point where connects both anchor
%   chain and rod.
% - Theta1 to Theta5 is the angle between rod and the plumb line.
%   Where Theta1 is for the rod near anchor chain.
%   (Then obviously Theta5 is for the rod near sea level.)
% - ThetaCa is the tangent angle at the upper side of anchor chain.
% - ThetaMao is the tagent angle at the lower side of anchor chain. Also,
%   it is the side where is connected to anchor lying on seabed.
% - If it takes a long time for program to get an answer, 
%   try comment Line85 & Line86 in ProblemA.m to ban a syscall for the
%   function 'BinarySearchX' defined by myself...
%=======================================================================
clear all;
close all;

Vwind = 36;
Vsea = 0;
Mball = 1200;
Depth = 18;

VariableScope;
ProblemA(Vwind, Vsea, Mball, Depth); % function ProblemA(vwind, vsea, mball, depth)
