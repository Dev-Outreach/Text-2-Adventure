public class CheckpointQuery{
    private String checkpointName;
    private boolean wantedValue;

    public CheckpointQuery(String cN, boolean wV){
        checkpointName = cN;
        wantedValue = wV;
    }

    public String getCheckpointName(){
        return checkpointName;
    }

    public void setCheckpointName(String newCheckpointName){
        checkpointName = newCheckpointName;
        return;
    }

    public boolean getWantedValue(){
        return wantedValue;
    }

    public void setWantedValue(boolean newWantedValue){
        wantedValue = newWantedValue;
        return;
    }
}