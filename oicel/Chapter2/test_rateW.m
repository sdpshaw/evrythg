function test_rateW(filename)

if nargin<1, filename = 'testData'; end

load(filename)

zeta = 1e-7;

ok = true;
try
    for t=1:length(testSets)
            R = rateW(testSets(t).W,testSets(t).H);
            if max(abs(testSets(t).rateW-R))>zeta
                display(['FAIL, wrong rate, test No. ' num2str(t)])
                keyboard
                ok=false;
            end
    end
catch e
    disp('FAIL, error');
    disp(getReport(e,'extended'))
    ok = false;
end
if ok
    disp('OK')
end