#!/usr/bin/env python3
fg = "\033[38;5;"
bg = "\033[48;5;"
for i in range(0, 256):
    n = str(i)
    fgstr = fg + n + "m" + n
    bgstr = bg + n + "m" "XXXXXXXX"
    print(fgstr, bgstr, "\033[0m")
