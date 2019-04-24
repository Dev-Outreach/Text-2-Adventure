public class Text{
    private String trueText;
    private String falseText;
    private ArrayList<CheckpointQuery> checkpointsRequired;

    public Text(String TrueText, String FalseText, ArrayList<CheckpointQuery> CheckpointsRequired){
        trueText = TrueText;
        falseText = FalseText;
        checkpointsRequired = CheckpointsRequired;
    }

    public String getTrueText(){
        return trueText;
    }

    public void setTrueText(String newTrueText){
        trueText = newTrueText;
    }

    public String getFalseText(){
        return falseText;
    }

    public void setFalseText(String newFalseText){
        falseText = newFalseText;
    }

    public ArrayList<CheckpointQuery> getCheckpointsRequired(){
        return checkpointsRequired;
    }

    public void setCheckpointsRequired(ArrayList<CheckpointQuery> newCheckpointsRequired){
        checkpointsRequired = newCheckpointsRequired;
    }
}