import java.io.EOFException;
import java.util.Scanner;


public class Manage {

	public static void main(String[] args) throws MyException, EOFException {
		Scanner scanner=new Scanner(System.in);
		Boolean next=true;
		ColectiaMea Colectie = new ColectiaMea();
		
		while(next){
			Colectie.Citire_adaugare();
			System.out.println("doriti sa mai adaugati filme? Y/N");
			String caz=scanner.nextLine();
			
			switch(caz){
				case "Y": 
					next=true;
					break;
				case "N":
					next=false;
					break;
			}
		}
		next=true;
		while(next){
			System.out.println("doriti sa stergeti vreun film? Y/N");
			String caz=scanner.nextLine();
			switch(caz){
				case "Y": 
					next=true;
					Colectie.Citire_stergere();
					break;
				case "N":
					next=false;
					break;
			}
		}
		
		Colectie.Salvare_fisier();
		Colectie.Restaurare_fisier();
		Colectie.raport();
	}

}
