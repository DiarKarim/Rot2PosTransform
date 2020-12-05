%sensors = h.sensors;
%initLiberty;

input('Press ENTER when ready to start');   % takes input from user - starts recording

h.flush                                     % discards any old data

data = h.read(200*8);



plot3(data(:,1),data(:,2),data(:,3))
axis equal