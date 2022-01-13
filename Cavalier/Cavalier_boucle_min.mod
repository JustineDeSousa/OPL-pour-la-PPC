/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Justine
 * Creation Date: 11 janv. 2022 at 18:17:35
 *********************************************/
using CP;

int d = ...;
int n = ...;


dvar int x[1..n] in 1..d;
dvar int y[1..n] in 1..d;


subject to{
	forall(i in 1..d) forall(j in 1..d)
	  sum(k in 1..n) ((i==x[k] && j==y[k] || ((abs(x[k] - i) + abs(y[k] - j)==3)&& i != x[k]&& j != y[k]))) >= 1;
}

main{
	var model = thisOplModel;
	thisOplModel.generate();
	cp.startNewSearch();
	
	var oldModel = model;
	
	while(cp.solve()) {
		
		
		// Mémoire de la solution	
		oldModel = model;
		
		//Copie les datas du modèle courant et les modifie
		var data = model.dataElements;
		data.n = model.dataElements.n - 1;
		writeln("nombre cavaliers max = ", data.n)

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


execute{

	for( var i=1; i<=d; i++){	
		var line = "";	
		for(var j=1; j<=d; j++){
			var found = false;		
			for( var k=1; k<=n; k++){			
				if(i == x[k] && j == y[k]){
					write(" o ");
					found = true;
					break;	
				}
			}
			if(!found){
				write("   ");
			}
			if(j!=d)
				write("|");
			line += "----";
		}
		writeln();
		writeln(line);
	}
	write("Cavaliers min = ", n);
}