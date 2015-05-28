import java.util.Date;
import java.util.Vector;


public class Film implements java.io.Serializable{
	
	String name;
	Integer rating;
	Vector<String> categorii;
	Date data_lansarii;
	

	public Film()
	{
		Vector<String> categorii=new Vector<String>();
	}
	public String getName() {
		
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getRating() {
		return rating;
	}

	public void setRating(Integer rating) {
		this.rating = rating;
	}

	public Vector<String> getCategorii() {
		return categorii;
	}

	public void setCategorii(Vector<String> categorii) {
		this.categorii = categorii;
	}

	public Date getData_lansarii() {
		return data_lansarii;
	}

	public void setData_lansarii(Date data_lansarii) {
		this.data_lansarii = data_lansarii;
	}

	public Film(String name, Vector<String> categorii, Date data_lansarii ,Integer rating){
		
		this.name=name;
		this.categorii=categorii;
		this.data_lansarii=data_lansarii;
		this.rating=rating;
	}
	

}
