%s/\\mathcal{C}/\&\#x2102;/g
%s/\\text{\([^}]*\)}/**\1**/g
" Replace P_n with P<sub>n</sub>
%s/\(P_\)\([0-9]\)/P<sub>\2<\/sub>/g

" Replace b_n with b<sub>n</sub>
%s/\(b_\)\([0-9]\)/b<sub>\2<\/sub>/g
