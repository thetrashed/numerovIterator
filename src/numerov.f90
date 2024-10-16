module numerov
   implicit none

contains

  subroutine numerovBackward(g, xs, ys, h, iterations, n, Z, l)
      real, intent(in) :: xs(:)
      real, intent(inout) :: ys(:)

      integer, intent(in) :: iterations, l
      real, intent(in) :: h, n, Z

      integer :: i
      real :: normalization
      real :: fs(size(xs))

      interface
         pure real function g(x, n, Z, l)
            implicit none
            real, intent(in) :: x, n, Z
            integer, intent(in) :: l
         end function
      end interface

      ! Calculate all the values of g_n
      do concurrent(i=1:iterations)
         fs(i) = 1.0 + (h**2/12)*g(xs(i), n, Z, l)
      end do

      ys(iterations) = 0
      ys(iterations - 1) = 0.001
      do concurrent(i=iterations - 2:1:-1)
         ys(i) = ((12 - 10*fs(i + 1))*ys(i + 1) - ys(i + 2)*fs(i + 2))/fs(i)
      end do

      normalization = normalize(xs, ys)
      
      print *, normalization
      do concurrent(i=1:iterations)
         ys(i) = ys(i)/normalization
      end do
      
    end subroutine numerovBackward
    
    ! Normalisation -> using Simpson's 3/8 rule
    real function normalize(x_vals, y_vals) result(normalization_const)
      implicit none
      real, intent(in) :: x_vals(:), y_vals(:)
      integer :: points(4)
      real :: h

      h = (x_vals(size(x_vals)) - x_vals(1))/3.0
      points(1) = 0
      points(2) = floor(size(y_vals)*(1.0/3.0))
      points(3) = ceiling(size(y_vals)*(2.0/3.0))
      points(4) = size(y_vals)

      normalization_const = (3*h/8)* &
                            (y_vals(points(1))**2 + 3*(y_vals(points(2))**2) + &
                             3*(y_vals(points(3))**2) + y_vals(points(4))**2)

      normalization_const = sqrt(normalization_const)
   end function

end module
