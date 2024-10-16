module potentials
   implicit none
contains
   pure real function hydrogen_potential(r, n, Z, l) result(u)
      real, intent(in) :: r, n, Z
      integer, intent(in) :: l

      u = (- (Z**2/n**2) + 2*Z/r - (l*(l + 1.0))/r**2)
   end function hydrogen_potential
end module
