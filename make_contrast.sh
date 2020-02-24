#!/bin/bash

space=(vm.lh vm.rh vm.mni)

for s in ${space[@]}; do
	mkcontrast-sess -analysis ../mkanalysis/$s -contrast word-control -a 2 -c 1 &
	mkcontrast-sess -analysis ../mkanalysis/$s -contrast maineffectwords -a 2 &
	mkcontrast-sess -analysis ../mkanalysis/$s -contrast maineffectcontrol -a 1
done
	
# 1 = control, 2 = words 



space=(recog.lh recog.rh recog.mni)
for s in ${space[@]}; do
	mkcontrast-sess -analysis ../mkanalysis/$s -contrast OldRelated-NewRelated -a 1 -c 2 &
	mkcontrast-sess -analysis ../mkanalysis/$s -contrast OldRelated-NewUnrelated -a 1 -c 3 &  
	mkcontrast-sess -analysis ../mkanalysis/$s -contrast NewRelated-NewUnrelated -a 2 -c 3 &
	mkcontrast-sess -analysis ../mkanalysis/$s -contrast Old-New -a 1 -c 2 -c 3 &
	mkcontrast-sess -analysis ../mkanalysis/$s -contrast OldRelatedMainEffect -a 1 &
	mkcontrast-sess -analysis ../mkanalysis/$s -contrast NewRelatedMainEffect -a 2 &
	mkcontrast-sess -analysis ../mkanalysis/$s -contrast NewUnrelated -a 3
done
	
# 1=OldRelated, 2=NewRelated, 3=NewUnrelated




space=(efn.lh efn.rh efn.mni)
for s in ${space[@]}; do
	mkcontrast-sess -analysis ../mkanalysis/$s -contrast 2back-1back -a 3 -a 4 -c 1 -c 2 &
	mkcontrast-sess -analysis ../mkanalysis/$s -contrast Negative-Neutral -a 2 -a 4 -c 1 -c 3&  
	mkcontrast-sess -analysis ../mkanalysis/$s -contrast 2backNeutral-1backNeutral -a 3 -c 1 &
	mkcontrast-sess -analysis ../mkanalysis/$s -contrast 2backNegative-1backNegative -a 4 -c 2 &
	mkcontrast-sess -analysis ../mkanalysis/$s -contrast 2backNegative-2backNeutral -a 4 -c 3 

done
	
# 1-back & Neutral = 1
# 1-back & Negative = 2
# 2-back & Neutral =3
# 2-back & Negative = 4




space=(fb.lh fb.rh fb.mni)
for s in ${space[@]}; do
	mkcontrast-sess -analysis ../mkanalysis/$s -contrast belief-photo -a 1 -c 2 

done
	
# belief 1 
# photo 2
