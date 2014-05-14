function h = PlotMolecules( output )
% Plot the positions of the molecules in the simulation.  Assign a random
% color for the atoms in each individual plot.

h =plot3( output.position(:,1), output.position(:,2), output.position(:,3), ...
        'ko','Markersize',10, 'MarkerFaceColor', rand( 1,3) );
    axis equal
    let = 'xyz';
    for ii = 1 : 3
        eval( sprintf('%slim( [0, output.L%s(end)] )', let(ii), let(ii)));
    end
    grid on;