

program main
  use photochem, only: setup, integrate, cvode_equilibrium, allocate_memory
  use photochem_vars, only: rootdir
  implicit none
  integer :: nnz, nnq, nnp, nnsp, nnr, kks, kkj, nnw
  integer converged
  logical success
  character(len=1000) :: err

  rootdir = '../PhotochemPy/'

  call setup('../input/templates/Hadean+HCN/species.dat', &
             '../input/templates/Hadean+HCN/reactions.rx', &
             '../input/templates/Hadean+HCN/planet.dat', &
             '../input/templates/Hadean+HCN/input_photchem.dat', &
             '../input/templates/Hadean+HCN/atmosphere.txt', &
             '../input/templates/Hadean+HCN/Sun_4.0Ga.txt', err)
  if (len_trim(err) /= 0) then
    print*,trim(err)
    print*,'error worked properly'
    stop
  endif

  
  call integrate(100,converged)
  call cvode_equilibrium(1.d-3, 1.d-30, .true., success)
end program