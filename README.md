# 複数の家系図をまとめて描く

あ。



---



## ０．インストール方法

```bash
# condaの仮想環境内で

git clone https://github.com/hamanakakohei/pedigree
```



---



## １．使い方

```bash
optional arguments:
  --ped             典型的なpedファイル（列名：family_id、individual_id、paternal_id、maternal_id、sex）に、
                    label列（シンボル下に書きたい文字列）と
                    fill列（罹患ならblackと記入）を加えたファイル
                    [default: data/families.ped]
  --pedigree_title  family_id、titleという2列からなるファイル、家系図の上のタイトルを指定できる
                    [default: data/pedigree_title.txt]
  --nrow            描く時の行数 [default: 8]
  --ncol            描く時の列数 [default: 7]
  --width           画像の横幅cm [default: 16]
  --height          画像の縦幅cm [default: 23]
  --interval_width  左右の家系図との距離、家系図の絵を1とした時の相対値 [default: 0]
  --interval_height 上下の家系図との距離、家系図の絵を1とした時の相対値 [default: 0]
  --cex             ラベルの大きさ [default: 0.7]
  --title_cex       タイトルの大きさ [default: 0.7]
  --symbolsize      シンボルの大きさ [default: 0.6]
  --dpi             [default: 300]
  --out             [default: results/output.png]

```
