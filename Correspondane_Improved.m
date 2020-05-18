EG=(AG+AG')/2+j*(AG-AG')/2
EH=(AH+AH')/2+j*(AH-AH')/2
[VG,DG]=eig(EG)
[VH,DH]=eig(EH)
[VG1,DG1]=GramSchmidt(VG)
[VH1,DH1]=GramSchmidt(VH)
dist=norm(P*VG1-VH1)


