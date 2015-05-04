% a DEMO function for tvb.m

clear all;close all;clc
n = 17; % number of points
d = 3; % dimension (default d = 2)
p = rand(n,d); % generate n number of points in R^d

[tvb_pnt, tvb_prt] = tvb(p);

%%%%% PLOT
[sp_x,sp_y,sp_z] = sphere; % make sphere
radi = 0.015;
for i = 1:size(tvb_prt,2)
    col(i,:)= rand(1,3);   % generate random coler set
end
figure,
drawCube(tvb_pnt, 2*radi); % draw Tverberg point
hold on;
line([tvb_pnt(1) tvb_pnt(1)],[tvb_pnt(2) tvb_pnt(2)],[0 tvb_pnt(3)],'LineStyle','-', 'Color','b')
hold on;
line([tvb_pnt(1) 0],[tvb_pnt(2) tvb_pnt(2)],[tvb_pnt(3) tvb_pnt(3)],'LineStyle','-', 'Color','b')
hold on;
line([tvb_pnt(1) tvb_pnt(1)],[tvb_pnt(2) 0],[tvb_pnt(3) tvb_pnt(3)],'LineStyle','-', 'Color','b')
hold on;
% Draw convex hull of disjoint subsets
for i = 1:size(tvb_prt,2)
    for j = 1:size(tvb_prt{i},1)
        surf(radi*sp_x+tvb_prt{i}(j,1),radi*sp_y+tvb_prt{i}(j,2),radi*sp_z+tvb_prt{i}(j,3),'FaceColor',col(i,:),'FaceAlpha',0.5,'EdgeAlpha',0.1)
        hold on;
    end
    if size(unique(tvb_prt{i},'rows'),1) >=4 
        K = convhulln(tvb_prt{i});
        trisurf(K,tvb_prt{i}(:,1),tvb_prt{i}(:,2),tvb_prt{i}(:,3),'FaceColor',col(i,:),'FaceAlpha',0.2)
        hold on;  
    elseif size(unique(tvb_prt{i},'rows'),1) ==3
        K1 = [1 2 3];
        trisurf(K1,tvb_prt{i}(:,1),tvb_prt{i}(:,2),tvb_prt{i}(:,3),'FaceColor',col(i,:),'FaceAlpha',0.2)
    else
        line(tvb_prt{i}(:,1),tvb_prt{i}(:,2),tvb_prt{i}(:,3));
        hold on;
    end
end
% view([1 0 0]);view([0 0 1]);view([0 -1 0])
view(3) 
grid off 
axis('equal')
axis([0 1 0 1 0 1])
