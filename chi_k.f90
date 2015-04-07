!--------------------------------------------------------------------------
!---------------- Calculate polarization vectors -------------------------
!--------------------------------------------------------------------------
module chi_k
Implicit none 

contains 

subroutine calc_chik 
 use main_stuff
 Implicit none 
 real(8), dimension(3) :: rCM, raj 
 real(8) :: magraj, q, kdotr
 double complex, dimension(3) :: mPol !polarization vector for molecule
 double complex, dimension(3) :: Pol !total polarization vector at that k


do n = 1, Nk 
	Pol = 0
	do i = 1, Nmol
		!find geometrical charge center of each molecule
		!(not really center of mass)
		!rCM = 0 
		!do j = 1, AtomsPerMol		
		!	rCM = rCM + atoms(:,j,i)
		!enddo
		!rCM = rCM/AtomsPerMol
		!use first atom in system as reference
		rCM = atoms(:,1,i)

		mPol = 0

		!if TTM3F load charges for each atom
		if (TTM3F) then 
			if (j .eq. 1) qs(1) = qOs(i)
			if (j .eq. 2) qs(2) = qHs(2*i-0)
			if (j .eq. 3) qs(3) = qHs(2*i-1)
		endif

		do j = 1, AtomsPerMol
			raj = atoms(:,j,i) - rCM
			raj = raj - box*anint(raj/box)!PBC

			kdotr = dot_product(kvec(:,n),raj)

			if (kdotr /= 0.0) then
				mPol = mPol - dcmplx(0, 1)*( qs(j)*raj/kdotr )*( exp( dcmplx(0, 1)*kdotr ) - 1d0 ) 
			endif

		enddo!j = 1, AtomsPermol

		kdotr = dot_product(kvec(:,n),rCM)

		Pol = Pol + mPol*exp( dcmplx(0, -1)*kdotr )
	
		!if TTM3F add polarization vector
		if (TTM3F) Pol = Pol + Pdip(:,i)*0.20819434d0*exp( dcmplx(0, -1)*dot_product(kvec(:,n),Msites(:,i)) )

	enddo! i = 1, Nmol
 		
	PolTkt(n,t,:) = cross_product(kvec(:,n) , Pol)
	!rhokt(n,t)    = dot_product(kvec(:,n) , Pol)

enddo! n = 1, Nk 

end subroutine calc_chik 



!--------------------------------------------------------------------------
!------  Longitudinal chi(k) & structure factor calculation for H2O ------
!--------------------------------------------------------------------------
subroutine calc_chikL_alternate 
 use main_stuff
 Implicit none 
 real(8) :: qRP, qCP, rRP, rCP, molRp, molCP

do n = 1, Nk 
	qRP = 0 
	qCP = 0 
 	!longitudinal part 
	do j = 1, Nmol
		molRP = 0		
		molCP = 0 

		!if TTM3F load charges for each atom and add point dipole
		!(cf Bertolini Tani Mol Phys 75 1065)
		if (TTM3F) then 
			if (j .eq. 1) qs(1) = qOs(j)
			if (j .eq. 2) qs(2) = qHs(2*j-0)
			if (j .eq. 3) qs(3) = qHs(2*j-1)

			muL = dot_product(kvec(:,n),Pdip(:,i))*0.20819434d0  !convert Debye to eAng
			molRP = molRP + muL*dcos( dot_product(kvec(:,n),Msites(:,i)) )
			molCP = molcP + muL*dsin( dot_product(kvec(:,n),Msites(:,i)) )
		endif

		!molecular longitudinal polarization
		do i = 1, AtomsPerMol
			molRP = molRP + qs(i)*dcos( dot_product(kvec(:,n),atoms(:,i,j)) )
			molCP = molCP + qs(i)*dsin( dot_product(kvec(:,n),atoms(:,i,j)) ) 
		enddo
 
		!self part contribution for this moleucle
		chik0_self(n) = chik0_self(n) +  molRP**2 + molCP**2

		qRP = qRP + molRP
		qCP = qCP + molCP

 	enddo!do j = 1, Nmol 

	rhokt(n,t) = rhokt(n,t) + dcmplx(qRP, qCP)

	chik0(n)   = chik0(n) + qRP**2 + qCP**2

	str_fackt(n,t) = 0 !defunct! str_fackt(n,t) +  (tmpOr    +    tmpHr)**2 +  (tmpOc    +    tmpHc)**2
enddo
end subroutine calc_chikL_alternate 





!----------------------------------------------------------------------------------
!------------------- function to compute COMPLEX cross product ------------------- 
!----------------------------------------------------------------------------------
function cross_product(x,z)
 Implicit None
 real(8), dimension(3), intent(in) :: x
 double complex, dimension(3), intent(in) :: z 
 double complex, dimension(3) :: cross_product

  cross_product(1) = cmplx(x(2))*z(3) - z(2)*cmplx(x(3)) 
  cross_product(2) = z(1)*cmplx(x(3)) - cmplx(x(1))*z(3)
  cross_product(3) = cmplx(x(1))*z(2) - z(1)*cmplx(x(2))

end function cross_product




end module chi_k
