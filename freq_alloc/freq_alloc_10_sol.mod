/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Justine
 * Creation Date: 11 janv. 2022 at 15:46:03
 *********************************************/
include "freq_alloc_common.mod";

dvar int even[1..nb_trans div 2] in 1..nb_freq div 2;
dvar int odd[1..(nb_trans + nb_trans mod 2)div 2] in 1..(nb_freq + nb_freq mod 2)div 2;

dexpr int x[i in 1..nb_trans]=(i mod 2 == 0)?even[i div 2]:odd[i div 2 + 1];

constraints{
	forall (i,j in 1..nb_trans) abs(2*x[i]-(i mod 2)-2*x[j]+ (j mod 2)) >= offset[i][j];
}

main{
	// Rechercher les 10 premières solutions
	thisOplModel.generate();
	cp.startNewSearch();
	var n=1;
	while(n <=10 && cp.next()) {
		write("Solution n°", n, " :\t");	
		thisOplModel.postProcess();
		n++;
	}
}

include "freq_alloc_ecriture.mod";