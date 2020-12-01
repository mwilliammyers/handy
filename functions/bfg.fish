function bfg
  docker run --rm -it -v (pwd):/tmp donderom/bfg-repo-cleaner $argv
end
