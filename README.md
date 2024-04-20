## Vim Configuration

#### Install

Put all files in ~/.vim/

    ~$ git clone https://github.com/brandon733/vim.git .vim

Your ~/.vimrc should look something like:

    scriptencoding utf-8
    set encoding=utf-8
    source ~/.vim/vimrc

    " read ~/.vimrc_local, localvimrc plugin uses `.vimrc.local`
    if filereadable(expand('~/.vimrc_local'))
        source ~/.vimrc_local
    endif

Then:

    ~/.vim$ ./update

To update plugins:

    ~/.vim$ ./update

VIM directory structure:

* <http://learnvimscriptthehardway.stevelosh.com/chapters/42.html>


## Inspiration

Based on

* <http://bitbucket.org/sjl/dotfiles/src/tip/vim/>

And:

*  https://stevelosh.com/blog/2010/09/coming-home-to-vim/
*  https://begriffs.com/posts/2012-09-10-bespoke-vim.html

Also:

* <https://github.com/bling/dotvim/blob/master/vimrc>
* <https://github.com/spf13/spf13-vim>
* <https://github.com/marcelgruenauer/dotfiles/blob/master/src/.vimrc>
* <http://amix.dk/vim/vimrc.html>
* <https://github.com/whiteinge/dotfiles/blob/master/.vimrc>
* <http://dougblack.io/words/a-good-vimrc.html>
* <https://github.com/grassdog/dotfiles/blob/master/files/.vim/vimrc>
* <https://github.com/romainl/idiomatic-vimrc/blob/master/idiomatic-vimrc.vim>

### Plugins

* ale
* fzf
* tpope

### Command line tricks

* <http://apple.stackexchange.com/questions/5435/got-any-tips-or-tricks-for-terminal-in-mac-os-x>
* <https://git.herrbischoff.com/awesome-macos-command-line/about/>
* <https://git.herrbischoff.com/awesome-command-line-apps/about/>

Try:

      lsof, fs_usage, dtrace, opensnoop
      C-x C-e (edit current cmd in editor)
      telnet towel.blinkenlights.nl (watch starwars in ascii)

## Fonts

* Try https://app.programmingfonts.org/ first

### Interesting Characters

*  ⚡ ϟ ↯ ⠠⠵
*  Do you need ZWS? Try: &amp;#8203; &amp;#x200b; <200b>, utf-8 is e2808b

Unicode
* <https://en.wikipedia.org/wiki/List_of_Unicode_characters>
* <http://unicode-table.com/en/sets/>
* <https://www.compart.com/en/unicode/based>
* <http://www.copypastecharacter.com/all-characters>


Various
* alphabet: <https://en.wikipedia.org/wiki/Mathematical_Alphanumeric_Symbols>
* math:     <http://sites.psu.edu/symbolcodes/accents/math/mathchart/>
* emoji:    <http://unicode.org/emoji/charts/full-emoji-list.html>


I use SF Mono 10pt or 12pt on gruvbox8_soft Light for gui and PaperColor Light for command line.


Windows doesn't seem to render digraphs and special fonts correctly unless you do:
(Put this in _vimrc):

    set renderoptions=type:directx

