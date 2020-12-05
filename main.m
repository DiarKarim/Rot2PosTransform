clear; clf; clc

load('TrialRig1.mat'); % This loads the data (data) variable

% Offsets in any axis in (cm)
offsetValx = 10; 
offsetValy = 20;
offsetValz = 0;

% Real Marker
reMarker(1) = plot3([0 1],[0 0],[0 0],'r','LineWidth',2);
hold on
reMarker(2) = plot3([0,0],[0,1],[0 0],'g','LineWidth',2);
reMarker(3) = plot3([0,0],[0,0],[0 1],'b','LineWidth',2);

% Virtual Marker
vrMarker(1) = plot3([0 1],[0 0],[0 0],'m','LineWidth',2);
hold on
vrMarker(2) = plot3([0,0],[0,1],[0 0],'c','LineWidth',2);
vrMarker(3) = plot3([0,0],[0,0],[0 1],'k','LineWidth',2);

% Set View Parameters
%axis normal
%axis equal
%axis manual
ax = axes('XLim',[-70 70],'YLim',[-70 70],'ZLim',[-70 70]);
grid on
axis vis3d %VIS3D

% Create 3D objects
% 3D Object on real marker
realObj = hgtransform('Parent',ax);
set(reMarker,'Parent',realObj)

% 3D Object on virtual marker
virtObj = hgtransform('Parent',ax);
set(vrMarker,'Parent',virtObj)

% Plot
view(45,45)
input('Enter . . .')
for i = 1:length(data)
    Txy = makehgtform('translate',[data(i,1) data(i,2) data(i,3)]);
    % Get real marker rotations and CONVERT  from degrees to radians
    Rx = makehgtform('xrotate',deg2rad(data(i,4))); 
    Ry = makehgtform('yrotate',deg2rad(data(i,5)));
    Rz = makehgtform('zrotate',deg2rad(data(i,6)));
    Rxyz = Rx*Ry*Rz;
    
    set(realObj,'Matrix',Txy*Rxyz)
    
    %---------------------------------------------------------------------
    %---------------------------------------------------------------------
    %---------------------------------------------------------------------
    
    % Get real marker transform and offset it by specified vals (see above)
    % for the virtual marker
    realMarkerPose = realObj.Matrix;
    
    % Virtual Marker
    offSetPose = realMarkerPose;
    offSetPose(1,4) = realMarkerPose(1,4)-offsetValx; % Create offset from real marker in X-Direction by 10cm
    offSetPose(2,4) = realMarkerPose(2,4)-offsetValy; % Create offset from real marker in Y-Direction by 20cm
    offSetPose(3,4) = realMarkerPose(3,4)-offsetValz; % Create offset from real marker in Y-Direction by 0cm
    
    virtualMarkerPose = realMarkerPose * offSetPose;
    
    set(virtObj,'Matrix',virtualMarkerPose)
    
    %---------------------------------------------------------------------
    %---------------------------------------------------------------------
    %---------------------------------------------------------------------
    
    drawnow
end



% %% Transforms
% 
% % Get real marker position and orientation (pose)
% realMarkerPose = realObj.Matrix;
% 
% % Virtual Marker
% offSetPose = realMarkerPose;
% offSetPose(1,4) = realMarkerPose(1,4)-offsetValx; % Create offset from real marker in X-Direction by 10cm
% offSetPose(2,4) = realMarkerPose(2,4)-offsetValy; % Create offset from real marker in Y-Direction by 20cm
% vMPx = offSetPose(1,4);
% vMPy = offSetPose(2,4);
% vMPz = offSetPose(3,4);
% 
% vTxy = makehgtform('translate',[vMPx vMPy vMPz]);
% set(virtObj,'Matrix',vTxy)



