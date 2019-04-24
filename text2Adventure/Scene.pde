public class Scene {

    private ArrayList<Text> description;
    private ArrayList<Choice> choices;

    public Scene(ArrayList<Text> Description, ArrayList<Choice> Choices){
        description = Description;
        choices = Choices;
    }

    public ArrayList<Choice> getChoices(){
        return choices;
    }

    public void setChoices(ArrayList<Choice> newChoices){
        choices = newChoices;
        return;
    }

    public ArrayList<Text> getDescription(){ 
        return description;
    }

    public void setDescription(ArrayList<Text> Description){
        description = Description;
        return;
    }
}