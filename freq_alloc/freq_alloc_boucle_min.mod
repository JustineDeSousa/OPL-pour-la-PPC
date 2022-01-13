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
	var model = thisOplModel;
	thisOplModel.generate();
	cp.startNewSearch();
	
	var oldModel = model;
	
	while(cp.solve()) {
		
		
		// Mémoire de la solution	
		oldModel = model;
		
		// Calcul de la frequence max
		var frequence_max = -1;	
		for(var i=1; i<=model.nb_trans; i++){
			if (model.x[i]*2-i % 2 >= frequence_max)
				frequence_max = model.x[i]*2-i % 2;
		}
		
		//Copie les datas du modèle courant et les modifie
		var data = model.dataElements;
		data.nb_freq = frequence_max - 1;
		writeln("nouvelle frequence max = ", data.nb_freq)

		//Crée un nouveau modèle identique
		model = new IloOplModel(model.modelDefinition,cp);
		
		//Ajoute les nouvelles datas au nouveau modèle
		model.addDataSource(data);
		model.generate();

	}
	//Récupère le dernier modèle ayant une solution
	var model = new IloOplModel(oldModel.modelDefinition,cp);
	model.addDataSource(oldModel.dataElements)
	
	//Solve the model
	model.generate();
	cp.solve();
	
	//Write the solution
	model.postProcess();
}

include "freq_alloc_ecriture.mod";
