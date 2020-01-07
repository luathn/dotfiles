git clone https://github.com/exg/rxvt-unicode.git /tmp/rxvt-unicode
cd /tmp/rxvt-unicode
git clone https://github.com/yusiwen/libptytty.git
git clone https://github.com/yusiwen/libecb.git
git clone https://github.com/yusiwen/libev.git
## sudo apt install libev-dev
./configure --prefix=/usr --enable-everything
make
sudo make install
