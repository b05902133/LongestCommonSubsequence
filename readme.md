# Longest Common Subsequence
  研究所課程『演算法設計方法論』的程式作業一
## 問題描述
   請看 [problemDescription.md](./problemDescription.md)
## 解法描述
   請看 [algorithm.md](./algorithm.md)
## makefile target
   - 預設: debug
   - release: 用 -O2 進行編譯
   - debug: 用 -g 進行編譯
   - tags: 用 ctags 產生 tag 檔供 vim 等支援 tag 的編輯器使用
   - test: 比較程式輸出結果與助教提供的參考解答
     - 使用 bash 的命令做資源限制與結果判斷
       - 基本上 *nux 應該都支援
       - 時間限制: 1000s
       - 記憶體限制: 64000 KB
   - clean: 清除程式與目的檔
## 作者
   - flotisable
   - email: s09930698@gmail.com
   - github: https://github.com/flotisable
   - github page: https://flotisable.github.io