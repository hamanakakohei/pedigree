#!/bin/bash


./scripts/plot_pedigrees.R \
  --ped             data/families.ped \
  --pedigree_title  data/pedigree_title.txt \
  --nrow            8 \
  --ncol            7 \
  --width           16 \
  --height          23 \
  --interval_width  0 \
  --interval_height 0 \
  --cex             0.7 \
  --title_cex       0.7 \
  --symbolsize      0.6 \
  --dpi             300 \
  --out             results/output.png

