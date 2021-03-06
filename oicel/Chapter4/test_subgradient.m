zeta = 1e-1;
clc
close all
load incidence.mat
terminal{1} = 4;
source{1} = 1;

terminal{2} = [4, 3];
source{2} = [1, 5];

ok = true;
for t = 1:length(terminal)
    if t == 1
        fprintf('\n\n*******Testing single flow*******\n\n')
    elseif t == 2
%           fprintf('Multiflow not yet implemented\n')
%         break; 
        fprintf('\n\n*******Testing multi flow*******\n\n') %#ok<UNRCH>
    end
    
    [x, u, lambda, util] = networkflow_subgradient(M, terminal{t}, source{t});
    [xOpt, uOpt, lambdaOpt, utilOpt] = networkflow_cvx(M, terminal{t}, source{t});
    
    if max(abs(xOpt-x))>zeta
        [x, xOpt] %#ok<NOPTS>
        display(['FAIL,  wrong flows,  test No. ' num2str(t)])
        keyboard
        ok=fals e;
    end
    if max(abs(uOpt-u))>zeta
        [u, uOpt] %#ok<NOPTS>
        display(['FAIL,  wrong link capacities,  test No. ' num2str(t)])
        keyboard
        ok=false;
    end
    if max(abs(lambdaOpt-lambda))>zeta
        [lambda, lambdaOpt]
        display(['WARNING,  wrong lambda,  test No. ' num2str(t)])
        display(['this is usually not a problem'])
    end
    if max(abs(utilOpt-util))>zeta
        display(['FAIL,  wrong utility,  test No. ' num2str(t)])
        keyboard
        ok=false;
    end
end

if ok
    disp('OK')
end