%: %.f90 clean
	clear
	gfortran $< -o $@
	./$@

.PHONY: clean
clean:
	rm -f $(patsubst %.f90,%,$(wildcard *.f90))

.PHONY: dependencies
dependencies:
	brew install gcc mdp
	brew cask install cool-retro-term

.PHONY: slides
slides:
	mdp slides.md

