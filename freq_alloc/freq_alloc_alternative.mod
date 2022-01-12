/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Justine
 * Creation Date: 11 janv. 2022 at 15:46:03
 *********************************************/
using CP;

int nb_trans = ...;
int nb_freq = ...;
int offset[1..nb_trans][1..nb_trans] = ...;
string phase = ...;


dvar int even[1..nb_trans div 2] in 1..nb_trans div 2;
dvar int odd[1..(nb_trans + nb_trans mod 2)div 2] in 1..(nb_trans + nb_trans mod 2)div 2;

dexpr int x[i in 1..nb_trans]=(i mod 2 == 0)?even[i div 2]:odd[i div 2 + 1];

//minimize max(i in 1..nb_trans) (x[i]*2-i % 2);

constraints{
	forall (i,j in 1..nb_trans) abs(2*x[i]-(i mod 2)-2*x[j]+ (j mod 2)) >= offset[i][j];
}

execute{
	for(var i=1; i<=thisOplModel.nb_trans; i++){
		write(thisOplModel.x[i]*2-i % 2, " ");
	}
	writeln()
}