!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
!   DATE:        2024-09-01
!   AUTHOR:      Luo Yang
!   EMAIL:       mengheerguotou@gmail.com
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!   VERSION INFORMATION:v0.1
!   
!   NAME        :       ECCPF.f90
!   CONTAINS:
!      SUBROUTINES  : NONE
!      FUNCTIONS    : NONE
!   USE     : 
!      SUBROUTINES  : NONE
!      FUNCTIONS    : NONE
!      COMMON BLOCKS: NONE
!      MODULES      : NONE
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

PROGRAM ECCPF

   USE MOD_FLT
   USE MOD_COOR
   USE MOD_GEO
   USE MOD_PHY
   USE MOD_DEBUG
   USE MOD_TEST
   USE NETCDF

!---------------!---------------!---------------!---------------!---------------
   IMPLICIT NONE

   INTEGER::    I
   INTEGER::    J
   INTEGER::    K

!-------------------------------------------------------------------------------

   WRITE(*,*)'--- YOU ARE RUNNING ECCPF ---'
   WRITE(*,*)''

!-------------------------------------------------------------------------------

   CALL TIMESTAMP 

   CALL READ_INPUT  

   CALL ALLOCATE_VARS

!---------------!---------------!---------------!---------------!---------------

   CALL READ_CONFIGURATION

   CALL CONFIG_CHECK

!---------------!---------------!---------------!---------------!---------------

   CALL GFILE_BUILD_PEST_COOR  
   
   CALL GFILE_BUILD_BOOZ_COOR 

   CALL FLTP

   !CALL PROCESS_STOP
!---------------!---------------!---------------!---------------!---------------
   
   CALL FLT_SOL

   CALL SAFETY_FACTOR_SOL

   !CALL COOR_LABEL

!---------------!---------------!---------------!---------------!---------------

   WRITE(*,*)'--- IOTA PROFILE ---'

   !CALL IOTA_PROFILE
   CALL ROTATIONAL_TRANSFORM

   !WRITE(*,*)' --- BOOZER_CHI_SORT --- '
   !CALL BOOZER_CHI_SORT

   !WRITE(*,*)' --- FFT_BOOZER_CHI --- '
   !CALL FFT_BOOZER_CHI

   WRITE(*,*)'--- WFT BOOZER CHI ---'
   CALL WFT_BOOZER_CHI

   WRITE(*,*)'--- CHECK WFT BOOZER CHI ---'
   CALL CHECK_WFT_BOOZER_CHI


   IF (LOG_FLT_DCHI) THEN

      CALL FLT_DCHI

   END IF

   WRITE(*,*)'--- POINCARE SEQUENCE ---'
   CALL POINCARE_SEQUENCE
!    CALL FLT_POINCARE_SORT

   WRITE(*,*)'--- TOROIDAL MAGNETIC FLUX CALCULATED BY MAGNETIC PONTENTIAL ---'
   CALL TOROIDAL_FLUX_MAGPOT

   WRITE(*,*)'--- BUILD BOX ---'
   CALL BUILD_BOX

!---------------!---------------!---------------!---------------!---------------

   !WRITE(*,*)' --- FFT MAGNETIC FLUX 1D --- '
   !CALL MAGFLUX_FFT_1D

   !WRITE(*,*)' --- FFT MAGNETIC FLUX 2D --- '
   !CALL MAGFLUX_FFT_2D

   WRITE(*,*)'--- FFT MAGNETIC FLUX 3D ---'
   CALL MAGFLUX_FFT_3D

   WRITE(*,*)'--- FFT GRADIENT FLUX ---'
   CALL FFT_GRADIENT_FLUX

   WRITE(*,*)'--- FFT BMN FLUX 3D ---'
   CALL FFT_BMN_FLUX_3D

   WRITE(*,*)'--- POLOIDAL MAGNETIC FLUX ---'
   CALL POLOIDAL_MAGNETIC_FLUX

!---------------!---------------!---------------!---------------!---------------

   IF (LOG_FLT_2FL) THEN

      CALL FLT_DCHI

   END IF

!---------------!---------------!---------------!---------------!---------------

   !WRITE(*,*)'--- WFT BOOZER FLTC ---'
   !CALL WFT_BOOZER_FLTC
   !
   !WRITE(*,*)'--- CHECK WFT BOOZER FLTC ---'
   !CALL CHECK_WFT_BOOZER_FLTC

!---------------!---------------!---------------!---------------!---------------

   WRITE(*,*)'--- DEBUG ---'

   WRITE(*,*)'--- CHECKMAG ---'
   CALL CHECKMAG

!---------------!---------------!---------------!---------------!---------------

   WRITE(*,*)'--- DEALLOCATE VARS ---'
   CALL DEALLOCATE_VARS

   WRITE(*,*)'--- TIME ---'
   CALL TIMESTAMP 
   
!---------------!---------------!---------------!---------------!---------------

   WRITE(*,*)'--- YOU ARE LEAVING ECCPF ---'

!---------------!---------------!---------------!---------------!---------------
END PROGRAM ECCPF

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
