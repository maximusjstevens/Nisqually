clear all; 
close all;

%% --------------------------------
%define parameters and constants
%----------------------------------
rho=917;              % density of ice in kg/m^3
g=9.8;                  % gravity in m/s^2
n=3;                    % glen's flow law constant

s_per_year = 365.35*24*3600;        % number of seconds in a year (s yr^-1)
A_T = 6.8e-24*s_per_year;       % softness parameter for -5 degree ice (yr^-1 Pa^-3)
fd = 2*A_T/(n+2);                           % constants lumped together, and put into standard units.  (Pa^-3 yr^-1)
fs = 5.7e-20*s_per_year;                % sliding parameter fromOerlemans; (Pa^-3 m^2 yr-1)

%% --------------------------------
%define grid spacing and time
%----------------------------------
load space.mat
% xmx = 6500;          % max of the domain size in m
% delx = 50;              % grid spacing in m
% nxs = round(xmx/delx) + 1;  % number of grid points
% x = 0:delx:xmx;                   % x array (each point)

delt = 0.003; % time step in yrs 
ts = 0;             % starting time in yrs
tf = 500;      % final time in yrs
nts=floor((tf-ts)/delt) +1; % number of time steps ('round' used because need nts as integer)
nyrs = tf-ts;       % just final time - start time

%% -----------------
% define accumulation/ablation
%-----------------

% climate foricing for steady state
b = 22 - (40/5000)*x;      % mass balance in /yr

% climate forcing--for non steady state
mu = 0.65;      % melt rate in m /yr /degC
gamma = 5.5e-3;     % atmospheric lapse rate in degC/m
%gamma = 9e-3;

sigT = 0.2;     % standard deviation of temperature, in deg C
sigP = 0.5;     % standard deviation of precipitation in m/yr

Tp = sigT*randn(nyrs+1,1); % temperature forcing (around the mean).  changes every year (not timestep)
Pp = sigP*randn(nyrs+1,1);  % precip forcing (around the mean).  changes every year (not timestep)

%% ---------------------------------
% glacier bed geometries
%---------------------------------
% del = 4e3/log(3);
% zb =  4392.*exp(-x/del);   % bed profile in m  
% %zb = (-0.1*x+1000);  

%% -----------------------
% initialize arrays
%------------------------
load Hinit.mat
H0 = Hinit;   % initial thickness of ice (in m)--do not confuse with h, ice elevation.  h = H+zb
Qp=zeros(size(x));      % Qp equals j+1/2 flux
Qm=zeros(size(x));      % Qm equals j-1/2 flux
up = zeros(size(x));    % velocity at j +1/2 grid 
um = zeros(size(x));    % velcotiy at j-1/2 grid
dHdt=zeros(size(x));        %  slope of ice thickness -- do not confuse with dhdx, surface slope.  dhdx = dzdx+dHdx
H= H0;                    % initialize height array

yr = 0;         % for counting years
idx_out = 0;    % 
deltout = 1;    % for counting years
nouts = round(nts/1);   % for counting years
edge_out = zeros(length(nouts));    % for counting
t_out = zeros(length(nouts));           % for counting

iter=1;
%%-----------------------------------------
% begin loop over time
%-----------------------------------------

 for i=1:nts
    
     
    t = delt*(i-1); % time in years 
    
    % use the following "if" statement if you want a variable climate
    
        if (t == floor(t))      % only want it if it is a whole number year (not a fraction of a year)
                yr = yr+1;          % tick to the next year
                P = ones(size(x))*(5.0+Pp(yr));        % add the new climat forcing
                T_wk    = (23.375+Tp(yr))*ones(size(x)) - gamma*(zb+H);    % add the new temperature forcing
                melt = max(0,mu*T_wk);      % convert the temeperature to melt/ablation with meltrate factor--don't "negative" melt
                b = P-melt;     % accumulation/ablation profile for this year
        end
%-----------------------------------------
% begin loop over space
%-----------------------------------------
   for j=1:nxs-1  % 
       
       if j==1      % at the glacier divide

                H_ave =(H(1) + H(2))/2;          % average glacier thickness between divide and second point
                dHdx = (H(2) - H(1))/delx;      % linear slope of glacier thickness between divide and second point
                dzbdx = (zb(2) - zb(1))/delx;     % linear slope of bed between divide and second point
                dhdx = dHdx+dzbdx;             % linear surface slope of ice between divide and second point
            
                Qp(1) = -(dhdx).^3 * H_ave.^4*(rho*g)^3*(fd*H_ave+fs/H_ave);       % flux at plus half grid point
                up(1) = Qp(1)/H_ave;    % velocity at half grid point
            
                Qm(1) = 0;                      % flux at minus half grid point = 0 because we start at the divide--nothing flowing in
                um(1) = Qm(1)/H(1);       % velocity is also zero coming in
            
                dHdt(1) = b(1) - Qp(1)/(delx/2);    % change in thickness at the divide for this timestep is based on snowfall in/out, flux out
           
       elseif H(j)==0 && H(j-1)>0 % at the glacier toe
        
                Qp(j) = 0;   % nothing to flux out of the end
                up(j) = 0;   % no velocity b/c no ice
           
                H_ave = (0+H(j-1))/2;              % thickness of glacier is average of  last point with thickness and a thickness of 0     
                dHdx = 0-H(j-1)/delx;              % slope is based on last point with thickness and a thickness of 0
                dzbdx =(zb(j)-zb(j-1))/delx;       % bed slope between toe and last point with thickness
                dhdx = dHdx+dzbdx;            % surface slope between toe and last point with thickness
           
                Qm(j) = -(rho*g)^3*H_ave.^4*(dhdx).^3*(fd*H_ave+fs/H_ave);    % flux coming from the last point with thickness and melting out before it reaches a new grid point
                um(j) = Qm(j)/H_ave;         % velocity at the toe
           
                dHdt(j) = b(j) -(Qp(j)- Qm(j))/delx;     % change in height of the glacier at the toe based on the snowfall in/melt out and the flux in/out
                edgeT = j; 	%index of glacier toe - used for fancy plotting
           
       elseif H(j)<=0 && H(j-1)<=0 % beyond glacier toe - no glacier flux
  
                dHdt(j) = b(j);  % thickness change is only from any change in accumulaiton in/melt out
           
                % no flux in, no flux out
                Qp(j) = 0; 
                Qm(j) = 0;
           
                um(j) =0; 
                up(j) = 0;
            
       else  % within the glacier
            
           % first for the flux going out
                H_ave = (H(j+1) + H(j))/2;              % the average thickness between j and j+1
                dHdx = (H(j+1) - H(j))/delx;           % the linear ice thickness slope between j and j+1
                dzbdx = (zb(j+1) - zb(j))/delx;       % the linear bed slope between j and j+1
                dhdx = dHdx + dzbdx;                      % the surface slope between j and j+1
           
                Qp(j) = -(rho*g)^3*H_ave.^4*(dhdx).^3*(fd*H_ave+fs/H_ave);  % flux coming out
                up(j) = Qp(j)./H_ave;                           % velocity coming out
           
           % now for the flux coming in
                H_ave = (H(j-1) + H(j))/2;               % the average thickness between j and j-1
                dHdx = (H(j) - H(j-1))/delx;            % the linear ice thickness slope between j and j-1
                dzbdx = (zb(j) - zb(j-1))/delx;       % the linear bed slope between j and j-1
                dhdx = dHdx + dzbdx;                      % the surface slope between j and j-1

                Qm(j) = -(rho*g)^3*H_ave.^4*dhdx.^3*(fd*H_ave+fs/H_ave);        % flux coming in
                um(j) = Qm(j)/H_ave;            % velocity coming in
           
           % change in height at point j for this timestep
           dHdt(j) = b(j) - (Qp(j) - Qm(j))/delx;       % based on accumulation in/melt out and flux in/out
       
       end  
       
       dHdt(nxs) = 0; % enforce no change at edge of domian


   end  % done with each point in space
   
 
   % For the next timestep, the thickness is equal to the thickness profile at i
   % (H(:,i)), plus the amount that the thickness has changed at each point
   % over this time period, (dHdt*delt).  The ice thickness at each point
   % needs to be positive, so we choose the max of 0 and the summation.
   % since dHdt can be negative, we want to be sure we don't have values
   % for a negative ice thickness.
   
   H = max(0 , (H + (dHdt*delt)));
   
   ind=find(b<=0, 1 );
   E_surf=H+zb;
   ELA=E_surf(ind);
   
%% ----------------------------
% plot glacier every so often
%----------------------------
        if t/1 == floor(t/1)                    % recall: t = time in years.  so, if t is a whole year (not a fraction thereof)...
            idx_out = idx_out+1;            % bump up the index
            edge_out(idx_out) = delx*(find(H>1,1,'last'));    % save the edge for that whole year
             t_out(idx_out) = t;                % and save the whole years
             time = ['t = ' num2str(t) ' yrs'];
        end
    
        if t/4 == floor(t/4)          % plotting every year would take too long;  plot once every 20 years
        
            fig1=figure(1); hold off
            subplot('position',[0.1 0.40 0.8 0.50]) 
            plot(x/1000,zb/1000,'k','linewidth',2)
            x1 = [x(1:edgeT) fliplr(x(1:edgeT))]; z1 = [zb(1:edgeT) fliplr(zb(1:edgeT)+H(1:edgeT))];
            patch(x1/1000,z1/1000,'c')
            %plot(x1/1000,z1/1000,'g');
%             axis([0 xmx/1000 min(zb)/1000-.1 max(zb)/1000+1]);
            xlim([0 8]);
            xlabel('Distance (km)','fontsize',14); ylabel('Elevation (km)','fontsize',14)
         
            h3 = text('position',[0.7, 0.92],'string',time,'units','normalized','fontsize',16);
            h4 = text('position',[0.7, 0.7],'string',sprintf('ELA = %4.0f m',ELA),'units','normalized','fontsize',16);
            
            grid on
            hold off    
        
         figure(1)
         subplot('position',[0.1 0.1 0.8 0.2])
         plot(t_out,edge_out/1000,'k','linewidth',2); axis([0 tf 3 6]); hold off
         xlabel('Time (years)','fontsize',14); ylabel('Terminus (km)','fontsize',14)
         grid on
         M(iter)=getframe(fig1);
         iter=iter+1;
         
        figure(23);hold off;
        plot(x,H,'c*');
        
        figure(24);hold off;
        plot(x,E_surf,'k.')
        
        end  % done with fancy plotting
   
 end  % done with each time step




