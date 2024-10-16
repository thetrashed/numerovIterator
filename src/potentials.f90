module potentials
   implicit none
contains
   pure real function hydrogenPotential(r, n, Z, l) result(u)
      real, intent(in) :: r, n, Z
      integer, intent(in) :: l

      u = (-(Z**2/n**2) + 2*Z/r - (l*(l + 1.0))/r**2)
   end function hydrogenPotential

   pure real function hfTwoElectronPotential(r, n, Z, l)
   end function

end module
