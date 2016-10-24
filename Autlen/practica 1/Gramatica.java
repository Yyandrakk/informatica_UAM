package practica1;

import java.io.*;
import java.util.*;


public class Gramatica {

	
	private List<String> terminales; 
    private List<No_Terminales> no_terminales;
    private  String  axioma;
	 /**
     * @param args the command line arguments
     * @throws leer.ParamException
     * @throws java.io.FileNotFoundException
     */
     public Gramatica()
     {
    	 this.terminales = new ArrayList<>();
    	 this.no_terminales = new ArrayList<No_Terminales>();
     }
   
	public void cargar_fichero (String nombre_file) throws IOException
	{
		File archivo = new File (nombre_file);
        FileReader fr = new FileReader (archivo);
        BufferedReader br = new BufferedReader(fr);
        
        List<String> simbolos = new ArrayList<>();
        String frase,izq; 
        int n_rep,i,n_rep1;
        frase = br.readLine();
        n_rep= Integer.parseInt (frase);
         for ( i=0;i<n_rep;i++)
         {
              frase = br.readLine();
              this.terminales.add(frase);
         }
                
        frase = br.readLine();
        n_rep= Integer.parseInt (frase);
        
        for (i=0;i<n_rep;i++)
         {
              frase = br.readLine();
              this.no_terminales.add(new No_Terminales(frase));
         }
           
        frase = br.readLine();
        n_rep= Integer.parseInt (frase);
        
        for (i=0;i<n_rep;i++)
        {
        	No_Terminales NTaux;
        	izq = br.readLine();
        	
        	frase = br.readLine();
            n_rep1= Integer.parseInt(frase);
            for (int j=0;j<n_rep1;j++)
            {
            	frase = br.readLine();
            	simbolos.add(frase);
            }
        	Reglas r =new Reglas(izq,simbolos);
        	simbolos.clear();
        	
        	for(int k=0;k<this.no_terminales.size();k++)
        	{
        		NTaux = this.no_terminales.get(k);
        		
        		if(NTaux.getSimbolo().equals(izq))
        		{
        			NTaux.anadirReglas(r);
        			break;
        		}
        	}
        }
        this.axioma = br.readLine();
        fr.close();
	}

	public void derivar(char dir, char regla, int max_prof)
	{
		List<String> sentencia = new ArrayList<String>();
		sentencia.add(this.axioma);
		boolean find_nt=false;
		TablaDerivaciones tabla = new TablaDerivaciones((ArrayList<String>) sentencia);
		
		int possent = 0,posnt=0;
		for (int i=1;i<max_prof;i++){	
			if(sentencia.isEmpty())
				break;
			find_nt=false;
			switch(dir)
			{
			case 'i':
				
				for (int j=0;j<sentencia.size();j++)
				{
					for (int k=0;k<this.no_terminales.size();k++)
					{
						if(this.no_terminales.get(k).getSimbolo().equals(sentencia.get(j)))
						{
							find_nt=true;
							posnt=k;
							break;
						}
					}
					if(find_nt==true)
					{
						possent=j;
						break;
					}
				}
				if(find_nt==true)
				{
					sentencia.remove(possent);
					List<Reglas> listr = this.no_terminales.get(posnt).getReglas();
					switch(regla)
					{
						case'p':
							tabla.deriva(possent,(ArrayList<String>) listr.get(0).getDerecha());
							for(String s: listr.get(0).getDerecha())
								sentencia.add(possent++,s);
							
							break;
						case'a':
							Random a=new Random();
							int aleatorio = a.nextInt(listr.size());
							tabla.deriva(possent,(ArrayList<String>) listr.get(aleatorio).getDerecha());
							for(String s: listr.get(aleatorio).getDerecha())
								sentencia.add(possent++,s);
							break;
						case'u':
							tabla.deriva(possent,(ArrayList<String>) listr.get(listr.size()-1).getDerecha());
							for(String s: listr.get(listr.size()-1).getDerecha())
								sentencia.add(possent++,s);
							break;
					}
				}	
				break;
			case 'd':
				 find_nt=false;
				for (int j=sentencia.size()-1;j>=0;j--)
				{
					for (int k=0;k<this.no_terminales.size();k++)
					{
						if(this.no_terminales.get(k).getSimbolo().equals(sentencia.get(j)))
						{
							find_nt=true;
							posnt=k;
							break;
						}
					}
					if(find_nt==true)
					{
						possent=j;
						break;
					}
				}
				if(find_nt==true){
					sentencia.remove(possent);
					List<Reglas> listr2 = this.no_terminales.get(posnt).getReglas();
					switch(regla)
					{
						case'p':
							tabla.deriva(possent,(ArrayList<String>) listr2.get(0).getDerecha());
							for(String s: listr2.get(0).getDerecha())
								sentencia.add(possent++,s);
							break;
						case'a':
							Random a=new Random();
							int aleatorio = a.nextInt(listr2.size());
							tabla.deriva(possent,(ArrayList<String>) listr2.get(aleatorio).getDerecha());
							for(String s: listr2.get(aleatorio).getDerecha())
								sentencia.add(possent++,s);
							break;
						case'u':
							tabla.deriva(possent,(ArrayList<String>) listr2.get(listr2.size()-1).getDerecha());
							for(String s: listr2.get(listr2.size()-1).getDerecha())
								sentencia.add(possent++,s);
							break;
					}
				}
					break;
		}		
			if(find_nt==false)
				break;
		}
		System.out.println(sentencia);
		tabla.dibuja();
		
	}
	
}
