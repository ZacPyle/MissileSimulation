clear all;
close all;
clc;
format long;

name = 'Zachary Pyle';
id = 'A12601746';
hw_num = 'project';

global g

%Get the data for all of the trajectories

for j = 1:7
    
    [ X0, Y0, Z0, m0, mf, Thmag0, theta, phi, Tburn ] = read_input( 'missile_data.txt', j );
    [ T{j}, X{j}, Y{j}, Z{j}, U{j}, V{j}, W{j} ] = missile( X0, Y0, Z0, m0, mf, Thmag0, theta, phi, Tburn );
    
end

%%%%%   TASK ONE    %%%%%%

%Load terrain data for figure 1
load('terrain.mat');

%Start figure 1
figure(1); hold on;
ground = surf(x_terrain/1000, y_terrain/1000, h_terrain/1000); 
shading interp; 

%Graphing each trajectory for figure 1
for i = 1:7
    x_target = X{i}(end); 
    y_target = Y{i}(end);
    h_target = interp2(x_terrain, y_terrain, h_terrain, x_target, y_target);
    
    if i == 1
        plot3(x_target/1000, y_target/1000, h_target/1000,'ro','MarkerSize', 10, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r');
        M1 = plot3(X{i}/1000,Y{i}/1000,Z{i}/1000,'LineWidth',2,'color','c');
    elseif i == 2
        landing = plot3(x_target/1000, y_target/1000, h_target/1000,'ro','MarkerSize', 10, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r');
        M2 = plot3(X{i}/1000,Y{i}/1000,Z{i}/1000,'LineWidth',2,'color','k');
    elseif i == 3
        plot3(x_target/1000, y_target/1000, h_target/1000,'ro','MarkerSize', 10, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r');
        M3 = plot3(X{i}/1000,Y{i}/1000,Z{i}/1000,'LineWidth',2,'color','m');
    elseif i == 4
        plot3(x_target/1000, y_target/1000, h_target/1000,'ro','MarkerSize', 10, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r');
        M4 = plot3(X{i}/1000,Y{i}/1000,Z{i}/1000,'LineWidth',2,'color','b');
    elseif i == 5
        plot3(x_target/1000, y_target/1000, h_target/1000,'ro','MarkerSize', 10, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r');
        M5 = plot3(X{i}/1000,Y{i}/1000,Z{i}/1000,'LineWidth',2,'color','y');
    elseif i == 6
        plot3(x_target/1000, y_target/1000, h_target/1000,'ro','MarkerSize', 10, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r');
        M6 = plot3(X{i}/1000,Y{i}/1000,Z{i}/1000,'LineWidth',2,'color','g');
    elseif i == 7
        plot3(x_target/1000, y_target/1000, h_target/1000,'ro','MarkerSize', 10, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r');
        M7 = plot3(X{i}/1000,Y{i}/1000,Z{i}/1000,'LineWidth',2,'color','r');
    end
end

%Legend and axis and stuff for figure 1
hold off;
xlabel('x (km)'); ylabel('y (km)'); zlabel('z (km)');
legend([ground landing M1 M2 M3 M4 M5 M6 M7],'Terrain','Target','M1','M2','M3','M4','M5','M6',' M7');
view(3); axis([0 30 0 30 0 3.5]); grid on; 
set(gca,'LineWidth',2,'FontSize',16,'Xtick',[0:5:30],'Ytick',[0:5:30],'Ztick',[0:.5:3.5]);
title('Target on the terrain')

%Now get data on the speed of the missiles for figure 2
speed = {};
for m = 1:7
    for n = 1:length(U{m})
        speed{m}(n) = sqrt(U{m}(n)^2 + V{m}(n)^2 + W{m}(n)^2);
    end
end

%Plot the mach number vs time for all missiles
figure(2); hold on;
subplot(2,1,1)
for k = 1:7
    if k == 1
        plot(T{k},speed{k}./340,'-c','LineWidth',2);hold on;
    elseif k == 2
        plot(T{k},speed{k}./340,'-r','LineWidth',2)
    elseif k == 3
        plot(T{k},speed{k}./340,'-g','LineWidth',2)
    elseif k == 4
        plot(T{k},speed{k}./340,'-b','LineWidth',2)
    elseif k == 5
        plot(T{k},speed{k}./340,'-m','LineWidth',2)
    elseif k == 6
        plot(T{k},speed{k}./340,'-y','LineWidth',2)
    elseif k == 7
        plot(T{k},speed{k}./340,'-k','LineWidth',2)
    end
end
axis('tight')
xlabel('Time(s)')
ylabel('Mach Number')
grid on;

%Now create acceleration cell array 
acceleration = {};
for L = 1:7
    acceleration{L} =[(diff(speed{L}))/.005];
end

%Now plot it
subplot(2,1,2);
for q = 1:7
    if q == 1
        plot(T{q(2:end)},acceleration{q}./g,'-c','LineWidth',2);hold on;
    elseif q == 2
        plot(T{q(2:end)},acceleration{q}./g,'-r','LineWidth',2)
    elseif q == 3
        plot(T{q(2:end)},acceleration{q}./g,'-g','LineWidth',2)
    elseif q == 4
        plot(T{q(2:end)},acceleration{q}./g,'-b','LineWidth',2)
    elseif q == 5
        plot(T{q(2:end)},acceleration{q}./g,'-m','LineWidth',2)
    elseif q == 6
        plot(T{q(2:end)},acceleration{q}./g,'-y','LineWidth',2)
    elseif q == 7
        plot(T{q(2:end)},acceleration{q}./g,'-k','LineWidth',2)
    end
end
axis('tight')
xlabel('Time(s)')
ylabel('Acceleration/g (m/s^2)')
legend('M1','M2','M3','M4','M5','M6','M7')
grid on;
hold off;

%First find when they hit mach one the first time
altitude_index = {};
mach_index = {};
for a = 1:7
    for b = 2:length(speed{a})/2
        if speed{a}(b-1)/340 < 1 && speed{a}(b+1)/340 > 1
            altitude_index{a} = [Z{a}(speed{a} == speed{a}(b))];
            mach_index{a} = [speed{a}(speed{a} == speed{a}(b))/340];
        end
    end
end

%Now find when they hit mach one the second time
altitude_index2 = {};
mach_index2 = {};
for c = 1:7
    for d = 2:length(speed{c})-1
        if speed{c}(d-1)/340 > 1 && speed{c}(d+1)/340 < 1
            altitude_index2{c} = [Z{c}(speed{c} == speed{c}(d))];
            mach_index2{c} = [speed{c}(speed{c} == speed{c}(d))/340];
        end
    end
end

%Now plot figure 3
figure(3)
for r = 1:7
    if r == 1
        MM1 = plot(speed{r}./340,Z{r}./1000,'-c','LineWidth',2); hold on;
        plot(mach_index{r},altitude_index{r}/1000,'oc','MarkerFaceColor','c')
        plot(mach_index2{r},altitude_index2{r}/1000,'oc','MarkerFaceColor','c')
    elseif r == 2
        MM2 = plot(speed{r}./340,Z{r}./1000,'-r','LineWidth',2);
        plot(mach_index{r},altitude_index{r}/1000,'or','MarkerFaceColor','r')
        plot(mach_index2{r},altitude_index2{r}/1000,'or','MarkerFaceColor','r')
    elseif r == 3
        MM3 = plot(speed{r}./340,Z{r}./1000,'-g','LineWidth',2);
        plot(mach_index{r},altitude_index{r}/1000,'og','MarkerFaceColor','g')
        plot(mach_index2{r},altitude_index2{r}/1000,'og','MarkerFaceColor','g')
    elseif r == 4
        MM4 = plot(speed{r}./340,Z{r}./1000,'-b','LineWidth',2);
        plot(mach_index{r},altitude_index{r}/1000,'ob','MarkerFaceColor','b')
        plot(mach_index2{r},altitude_index2{r}/1000,'ob','MarkerFaceColor','b')
    elseif r == 5
        MM5 = plot(speed{r}./340,Z{r}./1000,'-m','LineWidth',2);
        plot(mach_index{r},altitude_index{r}/1000,'om','MarkerFaceColor','m')
        plot(mach_index2{r},altitude_index2{r}/1000,'om','MarkerFaceColor','m')
    elseif r == 6
        MM6 = plot(speed{r}./340,Z{r}./1000,'-y','LineWidth',2);
        plot(mach_index{r},altitude_index{r}/1000,'oy','MarkerFaceColor','y')
        plot(mach_index2{r},altitude_index2{r}/1000,'oy','MarkerFaceColor','y')
    elseif r == 7
        MM7 = plot(speed{r}./340,Z{r}./1000,'-k','LineWidth',2);
        plot(mach_index{r},altitude_index{r}/1000,'ok','MarkerFaceColor','k')
        plot(mach_index2{r},altitude_index2{r}/1000,'ok','MarkerFaceColor','k')
    end
end

%Legend and axis and stuff for figure 3
xlabel('Mach Number')
ylabel('Altitude (km)')
grid on;
legend([MM1 MM2 MM3 MM4 MM5 MM6 MM7],'M1','M2','M3',',M4','M5','M6','M6');
hold off;

%%%%%   TASK TWO    %%%%%%

%Index the location of the max altitude of each missile
max_height_coordinate = {};
for y = 1:7
    for u = 2:length(Z{y})-1
        if (Z{y}(u-1) < Z{y}(u)) && (Z{y}(u+1) < Z{y}(u))
            max_height_coordinate{y} = find(Z{y} == Z{y}(u));
        end
    end
end

%create the fields for my structure
%DO I HAVE TO DIVIDE ACCELERATION BY G?
missile_ID = [1 2 3 4 5 6 7];
landing_time = [T{1}(end) T{2}(end) T{3}(end) T{4}(end) T{5}(end) T{6}(end) T{7}(end)];
travel_distance = [sum(sqrt(diff(X{1}).^2+diff(Y{1}).^2+diff(Z{1}).^2)) ...
    sum(sqrt(diff(X{2}).^2+diff(Y{2}).^2+diff(Z{2}).^2)) ...
    sum(sqrt(diff(X{3}).^2+diff(Y{3}).^2+diff(Z{3}).^2)) ...
    sum(sqrt(diff(X{4}).^2+diff(Y{4}).^2+diff(Z{4}).^2)) ...
    sum(sqrt(diff(X{5}).^2+diff(Y{5}).^2+diff(Z{5}).^2)) ...
    sum(sqrt(diff(X{6}).^2+diff(Y{6}).^2+diff(Z{6}).^2)) ...
    sum(sqrt(diff(X{7}).^2+diff(Y{7}).^2+diff(Z{7}).^2))];
max_height_position = {[X{1}(max_height_coordinate{1}) Y{1}(max_height_coordinate{1}) Z{1}(max_height_coordinate{1})] ...
    [X{2}(max_height_coordinate{2}) Y{2}(max_height_coordinate{2}) Z{2}(max_height_coordinate{2})] ...
    [X{3}(max_height_coordinate{3}) Y{3}(max_height_coordinate{3}) Z{3}(max_height_coordinate{3})] ...
    [X{4}(max_height_coordinate{4}) Y{4}(max_height_coordinate{4}) Z{4}(max_height_coordinate{4})] ...
    [X{5}(max_height_coordinate{5}) Y{5}(max_height_coordinate{5}) Z{5}(max_height_coordinate{5})] ...
    [X{6}(max_height_coordinate{6}) Y{6}(max_height_coordinate{6}) Z{6}(max_height_coordinate{6})] ...
    [X{7}(max_height_coordinate{7}) Y{7}(max_height_coordinate{7}) Z{7}(max_height_coordinate{7})]};
max_height_Ma = [speed{1}(max_height_coordinate{1})/340 ...
    speed{2}(max_height_coordinate{2})/340 ...
    speed{3}(max_height_coordinate{3})/340 ...
    speed{4}(max_height_coordinate{4})/340 ...
    speed{5}(max_height_coordinate{5})/340 ...
    speed{6}(max_height_coordinate{6})/340 ...
    speed{7}(max_height_coordinate{7})/340];
max_height_Acc = [acceleration{1}(max_height_coordinate{1}) ...
    acceleration{2}(max_height_coordinate{2}) ...
    acceleration{3}(max_height_coordinate{3}) ...
    acceleration{4}(max_height_coordinate{4}) ...
    acceleration{5}(max_height_coordinate{5}) ...
    acceleration{6}(max_height_coordinate{6}) ...
    acceleration{7}(max_height_coordinate{7})];
landing_location = {[X{1}(end) Y{1}(end) Z{1}(end)] ...
    [X{2}(end) Y{2}(end) Z{2}(end)] ...
    [X{3}(end) Y{3}(end) Z{3}(end)] ...
    [X{4}(end) Y{4}(end) Z{4}(end)] ...
    [X{5}(end) Y{5}(end) Z{5}(end)] ...
    [X{6}(end) Y{6}(end) Z{6}(end)] ...
    [X{7}(end) Y{7}(end) Z{7}(end)]};
landing_Ma = [speed{1}(end)/340 ...
    speed{2}(end)/340 ...
    speed{3}(end)/340 ...
    speed{4}(end)/340 ...
    speed{5}(end)/340 ...
    speed{6}(end)/340 ...
    speed{7}(end)/340];
landing_Acc  = [acceleration{1}(end) ...
    acceleration{2}(end) ...
    acceleration{3}(end) ...
    acceleration{4}(end) ...
    acceleration{5}(end) ...
    acceleration{6}(end) ...
    acceleration{7}(end)];

flight_stat = [];
%Now create structure from these fields
for s = 1:7
    flight_stat(s).missile_ID = missile_ID(s);
    flight_stat(s).landing_time = landing_time(s);
    flight_stat(s).travel_distance = travel_distance(s);
    flight_stat(s).max_height_position = max_height_position{s};
    flight_stat(s).max_height_Ma = max_height_Ma(s);
    flight_stat(s).max_height_Acc = max_height_Acc(s);
    flight_stat(s).landing_location = landing_location{s};
    flight_stat(s).landing_Ma = landing_Ma(s);
    flight_stat(s).landing_Acc = landing_Acc(s);
end
    
%%%%%   TASK THREE    %%%%%%

%Open the text file
fid = fopen('report.txt','wb');

%write data into the text file
fprintf(fid,'%s %s \n%s \n','Zachary','Pyle','A12601746');
for i = 1:7
    fprintf(fid,'%1.0f, %15.9e(s), %15.9e(m), %15.9e(m/s), %15.9e(m/s^2)\n',flight_stat(i).missile_ID, ...
        flight_stat(i).landing_time, flight_stat(i).travel_distance, speed{i}(end),flight_stat(i).landing_Acc);
end

%close text file
fclose(fid);

%Stuff asked for at the end
p1a = 'See figure 1';
p1b = 'See figure 2';
p1c = 'See figure 3';
p2a = flight_stat(1);
p2b = flight_stat(2);
p2c = flight_stat(3);
p2d = flight_stat(4);
p2e = flight_stat(5);
p2f = flight_stat(6);
p2g = flight_stat(7);
p3 = evalc('type report.txt');

