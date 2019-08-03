function net = lienet_init_g3d()
% lienet_init: initialize a lienet

rng('default');
rng(0) ;

opts.framenum = 100;
opts.datadim = [3, 3, 3, 3];
opts.skedim = [342, 171, 171, 15];
opts.sked = [7,7];



opts.layernum = length(opts.datadim)-1;

Winit = cell(opts.layernum+3,1);
Winit1 = cell(opts.layernum-1,1);
for i_w = 1 : opts.layernum
    Winit{i_w}.w = zeros(opts.datadim(1),...
                          opts.datadim(1),opts.datadim(i_w));
    for i_s = 1 : opts.skedim(i_w)
        A = rand(opts.datadim(i_w));
        [U1, S1, V1] = svd(A * A');
        Winit{i_w}.w(:,:,i_s) = U1(:,1:opts.datadim(i_w+1))';
    end
end


for i_w = 1 : opts.layernum-1
    Winit1{i_w}.w = zeros(opts.datadim(1),...
                          opts.datadim(1),opts.datadim(i_w));
    for i_s = 1 : opts.sked(i_w)
        A = rand(opts.datadim(i_w));
        [U1, S1, V1] = svd(A * A');
        Winit1{i_w}.w(:,:,i_s) = U1(:,1:opts.datadim(i_w+1))';
    end
end

f=1/500 ;
classNum = 20;
fdim = 19*7;

theta1 = f*randn(fdim, 20, 'single');
theta2 = f*randn(50,20,'single');
% theta3 = f*rand(150,20,'single');
Winit{i_w+2}.w = theta1';
Winit{i_w+3}.w = theta2';
% Winit{i_w+4}.w = theta3';

net.layers = {} ;

% 1 block setting
% net = init_block(net,1,1,Winit,pooling_index{1});

% % 2 block setting
% net = init_block(net,1,0,Winit,pooling_index{1});
% net = init_block(net,2,1,Winit,pooling_index{2});

% 3 block setting
net = init_block(net,1,0,Winit);
net = init_block(net,2,0,Winit);

net = init_block(net,3,0,Winit);

net = init_block1(net,1,0,Winit1);

net = init_block1(net,2,1,Winit1);

net.layers{end+1} = struct('type','normal');
net.layers{end}.step=1;

net.layers{end+1} = struct('type', 'fc', 'weight', Winit{4}.w);
net.layers{end}.step=2;

% 
% net.layers{end+1} = struct('type','normal');
% net.layers{end}.step=2;

net.layers{end+1} = struct('type', 'relu') ;
net.layers{end}.step=2;


% net.layers{end+1} = struct('type', 'fc', 'weight', Winit{5}.w);
% net.layers{end}.step=2;
% net.layers{end+1} = struct('type', 'relu') ;
% net.layers{end}.step=2;
% 

% 
% net.layers{end+1} = struct('type', 'fc', 'weight', Winit{6}.w);
% net.layers{end}.step=2;
% net.layers{end+1} = struct('type', 'relu') ;
% net.layers{end}.step=2;

net.layers{end+1} = struct('type','front');

net.layers{end+1} = struct('type', 'softmaxloss');


function net = init_block(net,i_layer,i_flag,Winit)

net.layers{end+1} = struct('type', 'rotmap') ;
net.layers{end}.weight = Winit{i_layer}.w;
net.layers{end+1} = struct('type', 'pooling') ;
if i_layer < 2
    net.layers{end}.pool = 2;
    net.layers{end}.step = 1;
else
    net.layers{end}.pool = 4;
    net.layers{end}.step = 2;
end

if i_flag ~= 0
    net.layers{end+1} = struct('type', 'logmap') ;

    net.layers{end+1} = struct('type', 'relu') ;
    net.layers{end}.step = 1;

end


function net = init_block1(net,i_layer,i_flag,Winit1)

net.layers{end+1} = struct('type', 'rotmap1') ;
net.layers{end}.weight = Winit1{i_layer}.w;
net.layers{end+1} = struct('type', 'pooling') ;

net.layers{end}.step = 1;
net.layers{end}.pool = 3;

if i_flag ~= 0
    net.layers{end+1} = struct('type', 'logmap') ;
% 
% 
%     net.layers{end+1} = struct('type', 'relu') ;
%     net.layers{end}.step = 1;

end