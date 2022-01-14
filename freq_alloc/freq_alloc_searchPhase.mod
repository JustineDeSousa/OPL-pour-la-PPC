/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Justine
 * Creation Date: 11 janv. 2022 at 10:01:36
 *********************************************/
include "freq_alloc_common.mod";

dvar int x[1..nb_trans] in 1..nb_freq; 

execute Phase{
	var f = cp.factory;
	//Référence : dans l'ordre
	var phase1 = f.searchPhase( thisOplModel.x,	f.selectSmallest(f.varIndex(thisOplModel.x)), f.selectSmallest(f.value()));
	//Variables
	var phase2 = f.searchPhase( thisOplModel.x,	f.selectSmallest(f.domainSize()), 	f.selectSmallest(f.value())); 
	var phase3 = f.searchPhase( thisOplModel.x,	f.selectLargest(f.domainSize()), 	f.selectSmallest(f.value()));
	//Valeurs
	var phase4 = f.searchPhase( thisOplModel.x,	f.selectSmallest(f.varIndex(thisOplModel.x)), f.selectSmallest(f.valueImpact()));
	var phase5 = f.searchPhase( thisOplModel.x,	f.selectSmallest(f.varIndex(thisOplModel.x)), f.selectLargest(f.valueImpact()));

//	cp.setSearchPhases(phase1);
}

minimize max(i in 1..nb_trans) x[i];

constraints{
	forall(i in 1..nb_trans) x[i] mod 2 == i mod 2;
	forall (i,j in 1..nb_trans) abs(x[i]-x[j]) >= offset[i][j];
}

include "freq_alloc_ecriture.mod";