% a DEMO function for tvb.m

clear all;close all;clc
n = 50; % number of points
d = 3; % dimension (default d = 2)
p = rand(n,d); % generate n number of points in R^d

[tvb_pnt, tvb_prt] = tvb(p);

%%%%% PLOT
[sp_x,sp_y,sp_z] = sphere; % make sphere
radi = 0.03;

col = distinguishable_colors(size(tvb_prt,2)); % generate colors
figure('position',[0 0 600 600],'Color',[1 1 1]);

% Draw convex hull of disjoint subsets
for i = 1:size(tvb_prt,2)

    if size(unique(tvb_prt{i},'rows'),1) >=4 
        K = convhulln(tvb_prt{i});
        trisurf(K,tvb_prt{i}(:,1),tvb_prt{i}(:,2),tvb_prt{i}(:,3),'FaceColor',col(i,:),'FaceAlpha',0.3)
        hold on;  
    elseif size(unique(tvb_prt{i},'rows'),1) ==3
        K1 = [1 2 3];
        trisurf(K1,tvb_prt{i}(:,1),tvb_prt{i}(:,2),tvb_prt{i}(:,3),'FaceColor',col(i,:),'FaceAlpha',0.3)
    else
        line(tvb_prt{i}(:,1),tvb_prt{i}(:,2),tvb_prt{i}(:,3));
        hold on;
    end
    for j = 1:size(tvb_prt{i},1)
        scatter3(tvb_prt{i}(j,1),tvb_prt{i}(j,2),tvb_prt{i}(j,3),'Marker','o','MarkerFaceColor',[.75 .75 .75], 'MarkerEdgeColor','k')
        hold on;
    end    
end
surf(radi*sp_x+tvb_pnt(1),radi*sp_y+tvb_pnt(2),radi*sp_z+tvb_pnt(3),'FaceColor','b') 
hold on;
line([tvb_pnt(1) tvb_pnt(1)],[tvb_pnt(2) tvb_pnt(2)],[0 tvb_pnt(3)],'LineStyle','-', 'Color','b')
hold on;
line([tvb_pnt(1) 0],[tvb_pnt(2) tvb_pnt(2)],[tvb_pnt(3) tvb_pnt(3)],'LineStyle','-', 'Color','b')
hold on;
line([tvb_pnt(1) tvb_pnt(1)],[tvb_pnt(2) 0],[tvb_pnt(3) tvb_pnt(3)],'LineStyle','-', 'Color','b')
hold on;
view(3) 
axis('equal')
axis([0 1 0 1 0 1]);
set(gca,'xtick',[0 1]);
set(gca,'ytick',[0 1]);
set(gca,'ztick',[0 1]);
set(gca,'FontSize',16);
xlabel('X');ylabel('Y');zlabel('Z');
