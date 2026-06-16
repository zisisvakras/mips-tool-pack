# Convert proodos.md to PDF. Greek needs a Unicode-capable LaTeX engine.
#
# Debian/Ubuntu (the `xelatex` binary comes from texlive-xetex, not a package named "xelatex"):
#   sudo apt install pandoc texlive-xetex texlive-lang-greek fonts-noto-core
#
# Override: make MAINFONT="DejaVu Sans" FONTSIZE=11pt

MD       := proodos.md
PDF      := proodos.pdf
PANDOC   ?= pandoc
ENGINE   ?= xelatex
# Noto Sans: neutral, high legibility; good Greek coverage (fonts-noto-core).
MAINFONT ?= Noto Sans
FONTSIZE ?= 12pt

.PHONY: all pdf clean help check-deps

all: pdf

help:
	@echo "Targets: pdf (default), clean, check-deps"
	@echo "Requires: pandoc, $(ENGINE), and $(MAINFONT) (e.g. fonts-noto-core)."

check-deps:
	@command -v $(PANDOC) >/dev/null || { echo "Missing: $(PANDOC)"; exit 1; }
	@command -v $(ENGINE) >/dev/null || { echo "Missing: $(ENGINE). Debian/Ubuntu: sudo apt install texlive-xetex  # or texlive-luatex for lualatex"; exit 1; }
	@echo "OK: $(PANDOC) and $(ENGINE) found."

pdf: $(PDF)

$(PDF): $(MD)
	@command -v $(PANDOC) >/dev/null || { echo "Missing: $(PANDOC). Run: make help"; exit 1; }
	@command -v $(ENGINE) >/dev/null || { echo "Missing: $(ENGINE). Run: make help"; exit 1; }
	$(PANDOC) "$(MD)" -o "$(PDF)" \
		--pdf-engine="$(ENGINE)" \
		-V mainfont="$(MAINFONT)" \
		-V fontsize="$(FONTSIZE)" \
		-V lang=el \
		--standalone

clean:
	rm -f "$(PDF)"
