/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Justine
 * Creation Date: 11 janv. 2022 at 10:01:36
 *********************************************/
using CP;

int nb_trans = ...;
int nb_freq = ...;
int offset[1..nb_trans][1..nb_trans] = ...;
string phase = ...;


dvar int x[1..nb_trans] in 1..nb_freq; 

//minimize max(i in 1..nb_trans) x[i];

constraints{
	forall(i in 1..nb_trans) x[i] mod 2 == i mod 2;
	forall (i,j in 1..nb_trans) abs(x[i]-x[j]) >= offset[i][j];
}

main{

	var f = cp.factory;
	
	var phase1 = f.searchPhase( thisOplModel.x,	f.selectSmallest(f.domainSize()), 	f.selectSmallest(f.value())); 
	var phase2 = f.searchPhase( thisOplModel.x,	f.selectLargest(f.domainSize()), 	f.selectSmallest(f.value()));	
	var phase3 = f.searchPhase( thisOplModel.x,	f.selectSmallest(f.varIndex(thisOplModel.x)), 	f.selectSmallest(f.value()));
	var phase4 = f.searchPhase( thisOplModel.x,	f.selectLargest(f.varIndex(thisOplModel.x)), 	f.selectSmallest(f.value()));
	var phase5 = f.searchPhase( thisOplModel.x,	f.selectSmallest(f.varIndex(thisOplModel.x)), 	f.selectRandomValue());
	
	if (thisOplModel.phase == "phase1")
		cp.setSearchPhases(phase1); 
	else if (thisOplModel.phase == "phase2")
		cp.setSearchPhases(phase2); 
	else if (thisOplModel.phase == "phase3")
		cp.setSearchPhases(phase3);
	else if (thisOplModel.phase == "phase4")
		cp.setSearchPhases(phase4);
	else if (thisOplModel.phase == "phase5")
		cp.setSearchPhases(phase5); 
	
	// Rechercher les 10 premières solutions
	thisOplModel.generate();
	cp.startNewSearch();
	var n=1;
	while(n <=10 && cp.next()) {
			
		for(var i=1; i<=thisOplModel.nb_trans; i++){
			write(thisOplModel.x[i], " ");
		}
		n++;
		writeln();
	}
}


