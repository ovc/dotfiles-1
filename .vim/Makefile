# Makefile gor cleaning .vim.

# Not file targets.
.PHONY: clean help list tar tar-src

### Macros ###
VIMHOME	= $(shell basename `pwd`)

### Targets ###

# target: clean - Deletes all compiled and generated files.
# target: help - Display all targets.
help :
	egrep "#\starget:" [Mm]akefile  | sed 's/\s-\s/\t\t\t/' | cut -d " " -f3- | sort -d

clean : 
	$(RM) ./viminfo
	$(RM) ./.netrwhist
	$(RM) ./yankring_v2.txt
	#$(RM) $(wildcard ./undo/*)
	$(RM) ./undo/*
	#$(RM) $(wildcard ./view/*)
	$(RM) ./view/*
	$(RM) -r ./fuf-data/*


# target: tar - Pack all the files to a gzip'd tarball.
tar : clean
	tar pvczf ../vim.tar.gz -C .. $(VIMHOME) .vimrc --exclude $(VIMHOME)/bundle/eclim/*
	#tar pvczf ../vim.tar.gz -C .. $(VIMHOME) .vimrc .vimrc.local --exclude $(VIMHOME)/bundle/eclim/*
