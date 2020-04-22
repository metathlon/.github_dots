#------------- MAKE su WORK WITH fish

function su
   command su --shell=/usr/bin/fish $argv
end
