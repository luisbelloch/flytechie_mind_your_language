%title: Retro-languages: FORTRAN
%author: luisbelloch
%date: 2020-05-22

# FORTRAN

Stands for _Formula Translation_
originally intended for math

Created: 1953 @ IBM

Older than my mother

---

Gained popularity because doing
_manual programming_ was hard.

---

# FORTRAN77

Released in 1977

Code starts from column 7, ends in 77

```
       PROGRAM HELLO
C This is a comment
       REAL HGHT0, HGHT, V0, VEL, ACCEL, TIME
       ACCEL = -9.807
       V0 = 90.0
       TIME = 4.3
       VEL = ACCEL * TIME + V0
  400  PRINT *, 'AT ', TIME, ' VELOCITY IS ', VEL
       END PROGRAM HELLO
```

---

# 'Good' ideas in programming

Implicit types: first letter of variable gives type

*INTEGER*  Starting i, j, ..., n
*REAL*     Rest of letters

```
PROGRAM BAD
JAM = 4
XENA = 3.4
END PROGRAM BAD
```

---

You can even set everything as **real**

```
implicit real (a-z)
```

---

# FORTRAN90

Close to what we know today as language

---

(sample code)

---

# C interop

Plays very well with other languages

Half of the world runs in Fortran for
numeric calculations

---

```
int some(int a, int *b);
```

```
interface
  integer (C_INT) function some (a, b) &
    BIND(C, name='some)
    use, intrinsic :: ISO_C_BINDING
    implicit none
    integer (C_INT), value :: a
    type (C_PTR), value :: b
  end function some
end interface
```

---

# BLAS: Basic Linear Algebra Subprograms

3 Levels:
- Vector / Vector
- Matrix / Vector
- Matrix / Matrix

```
SAXPY: Vector-Scalar product
y ← α * x + y
```



