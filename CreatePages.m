%% Generate the datapages for each of the datasets in the repository


% Data directory
 data_dir = ['MAT'];

 ff = dir( data_dir );
 
 for ii = 1 : 4 : numel( ff );
%      if ~all( ff(ii).name == '.' );
%          out = Load2Matlab( sprintf('%s%s%s', data_dir, filesep, ff(ii).name ) );
%          matinpublish( out, 'title', out.name );
%      end
     if ~all( ff(ii).name == '.' );
         out = Load2Matlab( sprintf('%s%s%s', data_dir, filesep, ff(ii).name ) );
         matinpublish( @Load2Matlab, sprintf('%s%s%s', data_dir, filesep, ff(ii).name), 'title', out.name );
     end
 end