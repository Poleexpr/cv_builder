#!/bin/bash
set -e

cd /resume/CV
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex

mkdir -p /output
cp main.pdf /output/resume.pdf