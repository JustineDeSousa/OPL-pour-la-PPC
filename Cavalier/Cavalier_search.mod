/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Justine
 * Creation Date: 11 janv. 2022 at 18:17:35
 *********************************************/
using CP;

int d = ...;
int n = ...;


dvar int x[1..d*d div 2] in 0..d;
dvar int y[1..d*d div 2] in 0..d;


maximize sum(i in 1..d*d div 2) (x[i]==0 && y[i]==0);


subject to{
	forall(i in 1..d) forall(j in 1..d)
	  sum(k in 1..d*d div 2) ((i==x[k] && j==y[k] || ((abs(x[k] - i) + abs(y[k] - j)==3)&& i != x[k]&& j != y[k]))&&x[k]!=0&&y[k]!=0) >= 1;
}


main{
	var f = cp.factory;
	var varChoice = f.selectSmallest(f.domainSize());
	var valChoice = f.selectSmallest(f.value());
	cp.setSearchPhases(f.searchPhase( thisOplModel.x,	varChoice, 	valChoice)); 
	thisOplModel.generate();
	cp.solve();
	thisOplModel.postProcess();
}



execute{
	

	for( var i=1; i<=d; i++){	
		var line = "";	
		for(var j=1; j<=d; j++){
			var found = false;		
			for( var k=1; k<=(d*d / 2); k++){			
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
	write("Cavaliers min = ", Math.floor(d*d / 2) - cp.getObjValue());
}