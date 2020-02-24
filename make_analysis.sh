#!/bin/bash 

mkanalysis-sess \
  -a ../mkanalysis/vm.lh -fsd bold -surface fsaverage lh -fwhm 5  \
  -event-related -paradigm vm.par -nconditions 2 \
  -spmhrf 0 -TR 2.3 -refeventdur 14 -nskip 4 -polyfit 2 \
  -per-run -runlistfile vmruns -force

mkanalysis-sess \
  -a ../mkanalysis/vm.rh -fsd bold -surface fsaverage rh -fwhm 5  \
  -event-related -paradigm vm.par -nconditions 2 \
  -spmhrf 0 -TR 2.3 -refeventdur 14 -nskip 4 -polyfit 2 \
  -per-run -runlistfile vmruns -force

mkanalysis-sess \
  -a ../mkanalysis/vm.mni -fsd bold -mni305 -fwhm 5  \
  -event-related -paradigm vm.par -nconditions 2 \
  -spmhrf 0 -TR 2.3 -refeventdur 14 -nskip 4 -polyfit 2 \
  -per-run -runlistfile vmruns -force

mkanalysis-sess \
  -a ../mkanalysis/recog.lh -fsd bold -surface fsaverage lh -fwhm 5  \
  -event-related -paradigm recog.par -nconditions 3 \
  -spmhrf 0 -TR 2.3 -refeventdur 14 -nskip 4 -polyfit 2 \
  -per-run -runlistfile recogruns -force

mkanalysis-sess \
  -a ../mkanalysis/recog.rh -fsd bold -surface fsaverage lh -fwhm 5  \
  -event-related -paradigm recog.par -nconditions 3 \
  -spmhrf 0 -TR 2.3 -refeventdur 14 -nskip 4 -polyfit 2 \
  -per-run -runlistfile recogruns -force

mkanalysis-sess \
  -a ../mkanalysis/recog.mni -fsd bold -surface fsaverage lh -fwhm 5  \
  -event-related -paradigm recog.par -nconditions 3 \
  -spmhrf 0 -TR 2.3 -refeventdur 14 -nskip 4 -polyfit 2 \
  -per-run -runlistfile recogruns -force

mkanalysis-sess \
  -a ../mkanalysis/efn.lh -fsd bold -surface fsaverage lh -fwhm 5  \
  -event-related -paradigm efn.par -nconditions 4 \
  -spmhrf 0 -TR 2.3 -refeventdur 14 -nskip 4 -polyfit 2 \
  -per-run -runlistfile efnruns -force

mkanalysis-sess \
  -a ../mkanalysis/efn.rh -fsd bold -surface fsaverage rh -fwhm 5  \
  -event-related -paradigm efn.par -nconditions 4 \
  -spmhrf 0 -TR 2.3 -refeventdur 14 -nskip 4 -polyfit 2 \
  -per-run -runlistfile efnruns -force

mkanalysis-sess \
  -a ../mkanalysis/efn.mni -fsd bold -mni305 -fwhm 5  \
  -event-related -paradigm efn.par -nconditions 4 \
  -spmhrf 0 -TR 2.3 -refeventdur 14 -nskip 4 -polyfit 2 \
  -per-run -runlistfile efnruns -force

mkanalysis-sess \
  -a ../mkanalysis/fb.lh -fsd bold -surface fsaverage lh -fwhm 5  \
  -event-related -paradigm fb.par -nconditions 2 \
  -spmhrf 0 -TR 2.3 -refeventdur 14 -nskip 4 -polyfit 2 \
  -per-run -runlistfile fbruns -force

mkanalysis-sess \
  -a ../mkanalysis/fb.rh -fsd bold -surface fsaverage rh -fwhm 5  \
  -event-related -paradigm fb.par -nconditions 2 \
  -spmhrf 0 -TR 2.3 -refeventdur 14 -nskip 4 -polyfit 2 \
  -per-run -runlistfile fbruns -force

mkanalysis-sess \
  -a ../mkanalysis/fb.mni -fsd bold -mni305 -fwhm 5  \
  -event-related -paradigm fb.par -nconditions 2 \
  -spmhrf 0 -TR 2.3 -refeventdur 14 -nskip 4 -polyfit 2 \
  -per-run -runlistfile fbruns -force
~                                      
~                                       

