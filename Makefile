# bioSyntax Makefile
# 
# packages the bioSyntax release from the
# git repository.

#-- System Config            --
SHELL =/bin/bash
SOURCEDIR = $(PWD)
ZIP = tar -zcvf

CD = cd
MKDIR_P = mkdir -p
RM = rm
MV = mv
CP_R = cp -r

#-- bioSyntax Release Config --
version = v0.1.5
release = bioSyntax_$(version)
components = all gedit sublime vim less alt man zip


.PHONY: $(components)
all: $(release) $(components)

$(release):
	$(MKDIR_P) $(release)

gedit:
	# gedit -----------------------------------------------
	$(CP_R) $(SOURCEDIR)/gedit $(release)
	#
	#

sublime:
	# sublime --------------------------------------------
	$(CP_R) $(SOURCEDIR)/sublime $(release)
	# TODO: Add control to ensure that bioSyntax-sublime
	# submodule is downloaded via git

	# Create sublime-settings file for each sublime syntax
	# {bash script}

	$(CD) $(release)/sublime;\
	{ \
	TEMPLATE='bioSyntax.sublime-settings' ;\
	for SYNTAXFILE in $$(ls *.sublime-syntax);\
		do SYNTAX=$$(basename -s .sublime-syntax $$SYNTAXFILE) ;\
		printf " Making .sublime-settings file for:\t$$SYNTAX\n" ;\
		cp $$TEMPLATE $$SYNTAX".sublime-settings" ;\
	done;\
	}
	#

vim:
	# vim -------------------------------------------------
	$(CP_R) $(SOURCEDIR)/vim $(release)
	# TODO: Add control to ensure that bioSyntax-vim
	# submodule is downloaded via git
	#

less:
	# less ------------------------------------------------
	$(CP_R) $(SOURCEDIR)/less $(release)
	#

alt:
	# alt-syntax + examples -------------------------------
	$(CP_R) $(SOURCEDIR)/examples $(release)
	$(CP_R) $(SOURCEDIR)/alt-syntax $(release)
	#

man:
	# scripts + manuals -----------------------------------
	$(CP_R) README.md $(release)
	$(CP_R) INSTALL.md $(release)
	$(CP_R) bioSyntax_INSTALL.sh $(release)
	$(CP_R) LICENSE.md $(release)
	$(CP_R) man.pdf $(release)
	#

zip:
	# Create zip of release 
	$(ZIP) $(release).tar.gz $(release)