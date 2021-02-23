PROGRAM MAT2
  IMPLICIT NONE
  REAL, dimension(1000,1000):: A,B,C
  INTEGER I,J,K
  REAL :: start, finish

  C=0

  CALL Random_number(A)
  CALL Random_number(B)
  CALL cpu_time(start)

  DO I=1,1000
    DO J=1,1000
      DO K=1,1000
        C(I,J) = C(I,J) + A(I,K) * B(K,J)
      END DO
    END DO
  END DO

  CALL cpu_time(finish)
  PRINT '("Time = ",f6.3," seconds.")',finish-start

  !WRITE (*,*) A
  !WRITE (*,*) B
  !WRITE (*,*) C
END
