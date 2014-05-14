function output = Load2Matlab( mat_nm, param )
% This is an example translator for Matlab.  It will import the contents of
% each Matlab file as a Matlab structure using a convention.  This
% translator is specifically for the files stored in this output Git
% repository.
%
% <var-name>.<field-name>
%
% <field-name> has a few keywords
% name
% comment
% image
% url
% link
% description
% include
% tag
% html

load( mat_nm );

file_nm = @(s)regexprep(fliplr( strtok( fliplr( s), filesep ) ), '.mat','');

output.name = file_nm( mat_nm );

if ~exist( 'param','var') param.isplot = true; param.todir = '.'; end

% The molecular positions of the Aluminum Atoms
output.position = data;
% This pair correlation function computed from Batch_Stats.m
output.stats_probability = paircorr.I;
output.stats_distance = paircorr.xx;


%% Simulation metadata output
% The metaoutput variable captures some of the simulation conditions in the LAMMPS
% input files.

fldnames = fieldnames( meta );
for ii = 1 : numel( fldnames )
    output = setfield( output, fldnames{ii}, getfield( meta, fldnames{ii} ) );
end

output.tag{1} = classname;

%% Attach a plot of the spatial statistics

if param.isplot
    if ~isdir('assets')
        mkdir( './assets')
    end
    
    % Plot the md positions;
    plot3( output.position(:,1), output.position(:,2), output.position(:,3), ...
        'ko','Markersize',10, 'MarkerFaceColor', rand( 1,3) );
    axis equal
    let = 'xyz';
    for ii = 1 : 3
        eval( sprintf('%slim( [0, output.L%s(end)] )', let(ii), let(ii)));
    end
    grid on;
    saveas( gcf, sprintf( '%s/assets/%s-positions.png', param.todir, output.name ))
    output.image{1} = sprintf( '%s-positions.png', output.name );
    
    % Plot the spatial statistics
    plot( output.stats_distance, output.stats_probability, 'k-o', 'LineWidth',3);
    grid on
    xlabel('Distance')
    ylabel({'Probability of finding another Al atom','It still needs to be normalized'});
    title('Pair correlation function of the inter-spacing of Al atoms');
    sprintf( '%s/assets/%s-pair-correlation.png', param.todir, output.name )
    saveas( gcf, sprintf( '%s/assets/%s-pair-correlation.png', param.todir, output.name ));
    output.image{2} = sprintf( '%s-pair-correlation.png', output.name );
end