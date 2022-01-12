/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Justine
 * Creation Date: 12 janv. 2022 at 17:03:58
 *********************************************/
execute Ecriture{
	//Ecriture de la solution et  calcul du f_max
	var f_max = 0;
	for(var i=1; i<=thisOplModel.nb_trans; i++){	
		var x_i = thisOplModel.x[i]*2-i % 2;
		if(x_i >= f_max)
			f_max = x_i;
		write(x_i, " ");
	}
	writeln("\t freq_max = ", f_max)
}