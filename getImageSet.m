function names = getImageSet(path)
%Reading .jpg files from path

content = dir(path) ;
names = {content.name} ;
ok = regexpi(names, '.*\.(jpg)$', 'start') ;
names = names(~cellfun(@isempty,ok)) ;

for i = 1:length(names)
  names{i} = fullfile(path,names{i}) ;
end
