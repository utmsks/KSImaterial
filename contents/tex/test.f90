! test.f90
program test
  implicit none
  integer i, j
  do i = 1,26
     j = 2**i
     print *, i, (1d0+1d0/j)**j
  end do
end program test
