" Generate ctags with python site packages
map <F10> :!ctags -R -f ./tags `python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`<CR>
