program hf_two_electron
   use potentials
   use numerov

   implicit none

   ! Declarations
   real :: MAX_X
   real :: MIN_X
   real :: h, n, Z
   integer :: num_xs, l

   real, allocatable :: xs(:)
   real, allocatable :: ys(:)

   integer :: i, io

   ! Initialisations
   MAX_X = 20
   MIN_X = 1e-10
   num_xs = 500
   h = (MAX_X - MIN_X)/num_xs
   n = 2
   Z = 1
   l = 0

   allocate (xs(num_xs))
   allocate (ys(num_xs))

   do concurrent(i=1:num_xs)
      xs(i) = MIN_X + h*(i - 1)
      ys(i) = 0
   end do

   call numerovBackward(hydrogenPotential, xs, ys, h, num_xs, n, Z, l)

   open (newunit=io, file="plot_data.dat")
   do i = 1, num_xs
      write (io, *) xs(i), ys(i)
   end do

   close (io)
   deallocate (xs)
   deallocate (ys)

end program hf_two_electron

