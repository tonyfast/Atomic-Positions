function feature = CreateFeature( datain )

% cutoff distance in nanometers
cut = 20;

%% Place the spatial statistics on a uniform grid
xxinterp = 0 : cut;

feature.data = interp1( datain.stats_distance, ...
    ... % Normalize statistics
    datain.stats_probability./sum(datain.stats_probability), ...
    ...
    xxinterp );

feature.columns = arrayfun( @(x)sprintf('t=%0.1fnm',x),xxinterp, 'UniformOutput',false );
feature.label{1} = datain.tags{1};
feature.step = datain.Step;
feature.cut = cut;