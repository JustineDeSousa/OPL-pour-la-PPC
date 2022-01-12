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


dvar int x[1..nb_trans] in 1..nb_freq; 

constraints{
	forall(i in 1..nb_trans) x[i] mod 2 == i mod 2;
	forall (i,j in 1..nb_trans) abs(x[i]-x[j]) >= offset[i][j];
}