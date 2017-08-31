[ $? -eq 0 ] && rm -rf Python-3.6.2
[ $? -eq 0 ] && tar Jxvf Python-3.6.2.tar.xz
[ $? -eq 0 ] && cd Python-3.6.2
[ $? -eq 0 ] && ./configure --prefix="$(readlink -f ../..)/$(basename `pwd` | tr '[A-Z]' '[a-z]')" --enable-shared
[ $? -eq 0 ] && make && make altinstall
[ $? -eq 0 ] && cd ..

[ $? -eq 0 ] && rm -rf Python-3.5.4
[ $? -eq 0 ] && tar Jxvf Python-3.5.4.tar.xz
[ $? -eq 0 ] && cd Python-3.5.4
[ $? -eq 0 ] && ./configure --prefix="$(readlink -f ../..)/$(basename `pwd` | tr '[A-Z]' '[a-z]')" --enable-shared
[ $? -eq 0 ] && make && make altinstall
[ $? -eq 0 ] && cd ..

[ $? -eq 0 ] && rm -rf Python-2.7.13
[ $? -eq 0 ] && tar Jxvf Python-2.7.13.tar.xz
[ $? -eq 0 ] && cd Python-2.7.13
[ $? -eq 0 ] && ./configure --prefix="$(readlink -f ../..)/$(basename `pwd` | tr '[A-Z]' '[a-z]')" --enable-shared
[ $? -eq 0 ] && make && make altinstall
[ $? -eq 0 ] && cd ..

