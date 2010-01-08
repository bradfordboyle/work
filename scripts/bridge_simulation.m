% 01 December 2009
% This script calculates the system reliability for the bridge system using
% direct enumeration, Monte Carlo simulation, antithetic variables, and
% parameterized antithetic variables. I consider both homogeneous and
% heterogeneous components. The general gist is that PAV (as it currently
% stands) is biased for the multi-link case.
%
% Bradford Boyle

clc
clear
h = @(S) max([prod(S([1 3 5])),...
    prod(S([2 3 4])), prod(S([1 4])), prod(S([2 5]))]);
r = 0;
p = [0.5 0.5 0.5 0.5 0.5];
n = 2e3;
X_bar = zeros(n,3);
V = zeros(n,3);
r_bar = 0;

for ii = 0:31
    S = de2bi(ii,5);
    r = r + h(S)*prod(p(find( S == 1)))*prod(1-p(find( S == 0)));
end

t0 = cputime;
for i = 1:n
    U = rand(1,5);
    S = double(U < p);
    phi = h(S);
    
    r_bar = r_bar + (phi - r_bar)/i;
    X_bar(i,1) = r_bar;
    if i == 1, continue; end
    V(i,1) = (1-1/(i-1))*V(i-1,1)+i*(X_bar(i,1)-X_bar(i-1,1))^2;
end % for
cputime-t0

r_bar = 0;
t0 = cputime;
for i = 1:(n/2)
    U = rand(1,5);
    S = double(U < p);
    Sc = double((1-U) < p);
    phi = h(S)/2;
    
    phi = phi + h(S)/2;
    
    r_bar = r_bar + (phi - r_bar)/i;
    X_bar(i,2) = r_bar;
    if i == 1, continue; end
    V(i,2) = (1-1/(i-1))*V(i-1,2)+i*(X_bar(i,2)-X_bar(i-1,2))^2;
end % for
cputime-t0


r_bar = 0;
t0 = cputime;
beta = 0.4;
for i = 1:(n/2)
    U = beta*rand(1,5);
    S = double(U < p);
    phi = beta*h(S);
    
    S = double((beta-U) < p);
    
    phi = phi + beta*h(S);
    
    U = ((1-beta)/beta)*U+beta;
    
    S = double(U < p);
    phi = phi + (1-beta)*h(S);
    
    S = double((1-U+beta) < p);
    phi = phi + (1-beta)*h(S);
    
    phi = phi/2;
    
    r_bar = r_bar + (phi - r_bar)/i;
    X_bar(i,3) = r_bar;
    if i == 1, continue; end
    V(i,3) = (1-1/(i-1))*V(i-1,3)+i*(X_bar(i,3)-X_bar(i-1,3))^2;
end % for
cputime-t0


pIdx = 2:floor(n/50):n;

CI = normcdf(0.975,0,1)*sqrt(V(pIdx,1)./pIdx');

figure(1)
h = plot(pIdx,X_bar(pIdx,1),'b',pIdx,X_bar(pIdx,1)+CI,'r',pIdx,X_bar(pIdx,1)-CI,'r',[0 n],[r r],'g');
set(h, 'LineWidth',2)
ylim([0 1])
xlim([0,n])
xlabel('Iteration Number')
ylabel('System Reliability')
title('Monte Carlo Estimate')

pIdx = 2:floor(n/100):n/2;
CI = normcdf(0.975,0,1)*sqrt(V(pIdx,2)./pIdx');

figure(2)
h = plot(pIdx,X_bar(pIdx,2),'b',pIdx,X_bar(pIdx,2)+CI,'r',pIdx,X_bar(pIdx,2)-CI,'r',[0 n],[r r],'g');
set(h, 'LineWidth',2)
ylim([0 1])
xlim([0,n])
xlabel('Iteration Number')
ylabel('System Reliability')
title('Antithetic Variables')

pIdx = 2:floor(n/100):n/2;
CI = normcdf(0.975,0,1)*sqrt(V(pIdx,3)./pIdx');

figure(3)
h = plot(pIdx,X_bar(pIdx,3),'b',pIdx,X_bar(pIdx,3)+CI,'r',pIdx,X_bar(pIdx,3)-CI,'r',[0 n],[r r],'g');
set(h, 'LineWidth',2)
ylim([0 1])
xlim([0,n])
xlabel('Iteration Number')
ylabel('System Reliability')
title('Parameterized Antithetic Variables')