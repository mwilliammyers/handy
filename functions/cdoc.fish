function cdoc --argument crate --description "Runs `cargo doc`"
	set -q crate
  and set -l crate (basename $PWD)
  
  # TODO: add option to `cargo --open` to specify the browser
	cargo doc --no-deps -p $crate
	and open -a 'Google Chrome' ./target/doc/(string replace -a '-' '_' $crate)/index.html
end
