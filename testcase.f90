program test
real, dimension(:,:), allocatable, save::a
integer, dimension(:), allocatable, save::IZROV,IPOSV
integer::m,n,m1,m2,m3,np,mp,ICASE,temp
open(11,file='input1.txt',status='unknown')
open(12,file='output.txt',status='unknown')

read(11,*)M
read(11,*)N
read(11,*)m1,m2,m3
NP=N+1 !Una fila mas para la columna de costes
MP=M+2 !dos filas mas, funcion de costes y funcion de costes fase 1
allocate(a(MP,NP))
a=0
do i=1,m+1
read(11,*) A(i,:)
end do

DO I=1,mp
		write(12,"(7f12.5)")A(i,:)
END DO
allocate(IZROV(n))
allocate (IPOSV(M))
izrov=0 !inicializo las 3 variables, da igual el valor
iposv=0
ICASE=0
call simplx(a,m,n,mp,np,m1,m2,m3,ICASE,izrov,iposv)
!escribo resultados en output (sin formato)
write(12,*)' '
write(12,*)'izrov'
write(12,*)izrov
write(12,*)' '
write(12,*)'iposv'
write(12,*)iposv
write(12,*)' '
write(12,*)'icase '
write(12,*)icase
write(12,*)' '

DO I=1,mp
	write(12,"(7e15.5)")A(I,:)
END DO
PRINT*,'ICASE'
PRINT*,ICASE
write(12,*)'_____________________'
write(12,*)'SOLUTION',ICASE
!ordenamos el vector de menor a mayor
DO J = 1,m-1
	DO K = J+1,m
		IF(iposv(J) > iposv(K)) THEN
			temp = iposv(K)
			iposv(K) = iposv(J)
			iposv(J) = temp
		END IF
	END DO
END DO
!escribimos los resultados
do j=1,m
	if (iposv(j)>n) then
		write(12,*)'y',IPOSV(J)-n,'=',A(J+1,1) !sustituyo x por y cuando i>n
	else	
		write(12,*)'x',IPOSV(J),'=',A(J+1,1)
	end if
end do

write(12,*)'total = ',A(1,1)
end program test
