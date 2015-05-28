import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;
import java.util.StringTokenizer;
import java.util.Vector;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;



public class ColectiaMea implements java.io.Serializable{
	Vector <Film> filme;
	String[] categ = {"drama", "actiune", "sf", "thriler", "comedie", "horror"};
	
	public ColectiaMea()
	{
	filme=new Vector<Film>();

	}
	
	public void Adaugare(String name, Vector<String> categorii, Date data_lansarii, Integer rating ){
		Film newFilm=new Film(name, categorii,data_lansarii,rating);
		filme.add(newFilm);

	}

	public void Stergere(String name,Vector<String>categorii) throws MyException{
		int ok=0;
		for(int i=0;i<filme.size()&&ok==0;i++)
			if(filme.elementAt(i).getName().equals(name) && filme.elementAt(i).getCategorii().equals(categorii)){
				ok=1;
				filme.remove(i);
			}
		if(ok==0)
		throw new MyException("nu exista acest film");
				
	}

	public void Citire_adaugare ()throws MyException {
		Date data_lansarii = null;
		System.out.println("introduceti datele noului film\nnumele:");
		Scanner scanner=new Scanner(System.in);
		String name=scanner.nextLine();
		
		if(name.startsWith(" ")||name.length()==0)
			throw new MyException("ati introdus un nume invalid");
		
		try{
			SimpleDateFormat df = new SimpleDateFormat("mm/dd/yyyy"); 
			df.setLenient(false);
			System.out.print("Introduceti data lansarii(mm/dd/yyyy ): ");
			String dateString = scanner.nextLine();
			data_lansarii = df.parse(dateString);
			
		} 
		catch(Exception e){
			
			e.getMessage();
			throw new MyException("eroare la data.");
		}	
	
		System.out.println("introduceti categoriile");
		String cat=scanner.nextLine();
		Vector<String>categorii=new Vector<String>();		
		StringTokenizer st =new StringTokenizer(cat);
		
		while (st.hasMoreElements()) {
			String token = st.nextElement().toString();
			categorii.add(token);
			}
		
		System.out.println("introduceti ratingul");
		Integer rating=scanner.nextInt();
		if(rating<0|| rating >10)
			throw new MyException("ratingul trebuie sa fie intre 0 si 10");			
			
		else
			Adaugare(name, categorii, data_lansarii, rating);
		
}

	public void Citire_stergere() throws MyException{
		
		System.out.println("introduceti datele filmului pe care doriti sa il stergeti\numele:");
		Scanner scanner=new Scanner(System.in);
	
		String name=scanner.nextLine();
		
		if(name.startsWith(" ")||name.length()==0)
			throw new MyException("ati introdus un nume invalid");
		
		System.out.println("introduceti categoriile:");
	
		String cat=scanner.nextLine();
		Vector<String>categorii=new Vector<String>();		
		StringTokenizer st =new StringTokenizer(cat);
		
		while (st.hasMoreElements()) {
			String token = st.nextElement().toString();
			categorii.add(token);
			}
	
		Stergere(name, categorii);
		
	
}

	public void Salvare_fisier(){
		
		try
	      {
	         FileOutputStream fileOut =
	         new FileOutputStream("filme.ser");
	         ObjectOutputStream out = new ObjectOutputStream(fileOut);
	        	 out.writeObject(filme);
	         out.close();
	         fileOut.close();
	      } catch(IOException i)
	       {
	          i.printStackTrace();
	       }
	   }
		
	public void Restaurare_fisier(){
		Vector<Film> e = null;
		try
	      {
	         FileInputStream fileIn = new FileInputStream("filme.ser");
	         ObjectInputStream in = new ObjectInputStream(fileIn);
	     
	         e = (Vector<Film>) in.readObject();
	        
		     for (Film m : e){
			     System.out.println("Name: " + m.name);
			     System.out.println("Categorie: " + m.categorii);
			     System.out.println("Data lansarii: " + m.data_lansarii);
			     System.out.println("Rating: " + m.rating);
			     
		     }
		     
		     in.close();
		     fileIn.close();

	      }catch(IOException i)
	      {
	         i.printStackTrace();
	         return;
	      }catch(ClassNotFoundException c)
	      {
	         System.out.println("Film class not found");
	         c.printStackTrace();
	         return;
	      }
	      
	}
	
	public void raport(){
		XWPFDocument document = new XWPFDocument();
		
		
		XWPFParagraph paragraph = document.createParagraph();
		XWPFRun run = paragraph.createRun();
		
		boolean ok = true;
		
		for (String c : categ){
			for (Film m : filme){
				if (m.getCategorii().contains(c)){
					if (ok == true){
						run.addBreak();
						run.setText(c.toUpperCase());
						run.setText(":");
						run.addBreak();
						ok = false;
					}
			
					run.setText(m.getName());
					run.addBreak();
				}
		}
			ok = true;
	}		
		
		try{
			FileOutputStream output = new FileOutputStream("Output.docx");
			document.write(output);
			output.close();
		} catch(Exception e){
			e.printStackTrace();
		}
		
	}
}

