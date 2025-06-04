function status = checkPropagationStatus(filename, voltageThreshold, timeThreshold)
% CHECKPROPAGATIONSTATUS  Checks AP propagation at final node and classifies result.
%
% Usage:
%   status = checkPropagationStatus('file.mat');
%   status = checkPropagationStatus('file.mat', -20, 3000); %you can set
%   custom thresholds
%
% Returns:
%   status = 'too low'   → AP failed to reach voltage threshold
%   status = 'too late'  → AP arrived after time threshold
%   status = 'successful'→ AP was above threshold and on time

    % Load simulation data
    data = load(filename);
    V = data.MEMBRANE_POTENTIAL;
    t = data.TIME_VECTOR;

    % Default thresholds
    if nargin < 2, voltageThreshold = -20; end  % mV
    if nargin < 3, timeThreshold = 3000; end    % ms

    % Final node signal
    finalNode = size(V, 2);
    Vfinal = V(:, finalNode);

    % Peak voltage and time
    [vMax, idxPeak] = max(Vfinal);
    peakTime_ms = t(idxPeak) * 1000;

    % Determine status
    if vMax < voltageThreshold
        status = 'too low';
    elseif peakTime_ms > timeThreshold
        status = 'too late';
    else
        status = 'successful';
    end

    % Print results
    fprintf('\n--- Propagation Check ---\n');
    fprintf('Final Node Peak Voltage: %.2f mV\n', vMax);
    fprintf('Final Node Peak Time: %.2f ms\n', peakTime_ms);
    fprintf('Status: %s\n', upper(status));
end

