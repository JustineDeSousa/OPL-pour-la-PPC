/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Justine
 * Creation Date: 11 janv. 2022 at 18:17:35
 *********************************************/
using CP;

int N = ...;
int d = ...;

//tuple position{
//	x;
//	y;
//}
dvar int x[1..N] in 1..d;
dvar int y[1..N] in 1..d;


subject to{
	forall(i in 1..d) forall(j in 1..d)
	  sum(k in 1..N) (i==x[k] && j==y[k] || ((abs(x[k] - i) + abs(y[k] - j)==3)&& i != x[k]&& j != y[k])) >= 1;
}

execute{

	for( var i=1; i<=d; i++){	
		var line = "";	
		for(var j=1; j<=d; j++){
			var found = false;		
			for( var k=1; k<=N; k++){			
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
}