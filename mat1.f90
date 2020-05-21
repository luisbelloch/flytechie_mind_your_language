PROGRAM MAT1
  IMPLICIT NONE
  REAL, dimension(2,2):: A

  CALL Random_number(A)

  ! Arrays starts at 1
  A(1,1) = 1
  A(1,2) = 2

  WRITE (*,*) A
END
