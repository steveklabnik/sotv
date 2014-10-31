default:
	rustdoc one.md -o . --html-in-header=header.inc.html --markdown-no-toc
	rustdoc two.md -o . --html-in-header=header.inc.html --markdown-no-toc
