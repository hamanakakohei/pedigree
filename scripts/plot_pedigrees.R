#!/usr/bin/env Rscript

library(pedtools)
library(tidyverse)
library(argparser)


p <- arg_parser("")
p <- add_argument(p, "--ped",              default='data/families.ped',       type="character", 
  help="典型的なpedファイル（列名：family_id、individual_id、paternal_id、maternal_id、sex）に、\n
  label列（シンボル下に書きたい文字列）と\n
  fill列（罹患ならblackと記入）を加えたファイル")
p <- add_argument(p, "--pedigree_title",   default='data/pedigree_title.txt', type="character", help="family_id、titleという2列からなるファイル、家系図の上のタイトルを指定できる")
p <- add_argument(p, "--nrow",             default=8,            type="numeric"  , help="描く時の行数")
p <- add_argument(p, "--ncol",             default=7,            type="numeric"  , help="描く時の列数")
p <- add_argument(p, "--width",            default=16,           type="numeric"  , help="画像の横幅cm")
p <- add_argument(p, "--height",           default=23,           type="numeric"  , help="画像の縦幅cm")
p <- add_argument(p, "--interval_width",   default=0,            type="numeric"  , help="左右の家系図との距離、家系図の絵を1とした時の相対値")
p <- add_argument(p, "--interval_height",  default=0,            type="numeric"  , help="上下の家系図との距離、家系図の絵を1とした時の相対値")
p <- add_argument(p, "--cex",              default=0.7,          type="numeric"  , help="ラベルの大きさ")
p <- add_argument(p, "--title_cex",        default=0.7,          type="numeric"  , help="タイトルの大きさ")
p <- add_argument(p, "--symbolsize",       default=0.6,          type="numeric"  , help="シンボルの大きさ")
p <- add_argument(p, "--dpi",              default=300,          type="numeric"  , help="")
p <- add_argument(p, "--out",              default='results/output.png', type="character", help="")
argv <- parse_args(p)


# 0. 関数
make_spaced_layout <- function(nrow, ncol) {
  layout_mat <- matrix(0, nrow = nrow * 2 - 1, ncol = ncol * 2 - 1)
  plot_num <- 1
  for (i in seq(1, nrow * 2 - 1, by = 2)) {
    for (j in seq(1, ncol * 2 - 1, by = 2)) {
      layout_mat[i, j] <- plot_num
      plot_num <- plot_num + 1
    }
  }
  return(layout_mat)
}


# １．データ読む、改行（\n）が変な風に読まれるので修正
ped = read_tsv( argv$ped ) %>%
  mutate(label = gsub("\\\\n", "\n", label)) %>%
  mutate(label = replace_na(label, " "))

family_title = read_tsv( argv$pedigree_title ) %>%
  mutate(title = gsub("\\\\n", "\n", title)) 


# 2. 複数プロットのレイアウトを指定しつつ、図を描いて保存する
dpi = argv$dpi
png(argv$out, width = argv$width / 2.54 * dpi, height = argv$height / 2.54 * dpi, res = dpi)

layout_mat <- make_spaced_layout( argv$nrow, argv$ncol )
layout(layout_mat,
  widths  = rep(c(1, argv$interval_width ), length.out = argv$ncol * 2 - 1),
  heights = rep(c(1, argv$interval_height), length.out = argv$nrow * 2 - 1)
)

par(mar = c(3, 3, 3, 3), oma = c(1, 1, 1, 1))

for ( FAMILY_ID in unique(ped$family_id) ) {
  PED = filter( ped, family_id == FAMILY_ID )
  TITLE = family_title %>% filter( family_id == FAMILY_ID ) %>% .$title %>% .[1]

  trio = ped(
    id = PED$individual_id,
    fid = PED$paternal_id,
    mid = PED$maternal_id,
    sex = PED$sex
  )
  
  plot(
    trio, 
    labs = setNames( PED$individual_id, PED$label ), 
    fill = setNames( PED$fill, PED$individual_id  ), 
    foldLabs = FALSE,
    cex = argv$cex,
    title.cex = argv$title_cex,
    symbolsize = argv$symbolsize,
    title = TITLE,
  )
}

dev.off()
