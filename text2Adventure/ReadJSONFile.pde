import java.io.FileNotFoundException;
public class ReadJSONFile {
  private JSONObject json;
  
  public ReadJSONFile(String filename){
    printError("");
     try {json = loadJSONObject(filename);
     }
    catch(Exception e) { printError("bad file");}
  }
  
  public String getFirstScene(){
    String firstScene = (String) json.getString("StartingScene");
    return firstScene;
  }  
  
  public HashMap<String, Boolean> getCheckpoints(){
    HashMap<String, Boolean> checkPointsList = new HashMap<String, Boolean>();
    JSONArray array = json.getJSONArray("CheckpointNames");
    
    for (int i = 0; i < array.size(); i++) { //get the list of checkpoints and their values
      JSONObject entry = array.getJSONObject(i);
      checkPointsList.put(entry.getString("Name"), entry.getBoolean("Value"));
    }  
    
    return checkPointsList;
  }
  
  public HashMap<String, Scene> getScenes(){
    HashMap<String, Scene> SceneList = new HashMap<String, Scene>();
    JSONArray sceneArray = json.getJSONArray("Scenes");
    JSONObject ChoiceFinder =json.getJSONObject("Choices");
    JSONObject TextFinder = json.getJSONObject("Text");
    
    JSONObject TextObject;
    JSONObject ChoiceObject;
    
    
    JSONArray TextArray;
    String textName;
    
    JSONArray ChoiceArray;
    
    ArrayList<Text> textList;
    ArrayList<Choice> choiceList;
    JSONObject scene;
    String name;
    
    String TrueText;
    String FalseText;
    
    ArrayList<CheckpointQuery> cpqList;
    JSONArray cpqArray;
    
    String checkPointName;
    Boolean checkPointValue;
    JSONObject cpqObj;
    
    String OptionText;
    String Desc;
    String Scene;
    ArrayList<String> cpqStringList;
    String ChoiceName;

    for (int i = 0; i < sceneArray.size(); i++) { //Here we parse the list of scenes.
      scene =  sceneArray.getJSONObject(i);
      TextArray =  scene.getJSONArray("Description");
      ChoiceArray =  scene.getJSONArray("Choices");
      
      name = (String) scene.getString("Name");
      
      cpqStringList = new ArrayList<String>();

      textList = new ArrayList<Text>();
      for (int j = 0; j < TextArray.size(); j++) { //Here we parse the list of Text objects for each scene.
        textName = (String) TextArray.getString(j);
        TextObject = (JSONObject) TextFinder.getJSONObject(textName);
        
        TrueText = (String) TextObject.getString("TrueText");
        FalseText = (String) TextObject.getString("FalseText");
        
        cpqArray = (JSONArray) TextObject.getJSONArray("Checkpoints");
        
        cpqList = new ArrayList<CheckpointQuery>();
        
        for (int k = 0; k < cpqArray.size(); k++) { //parses its checkpoints
          cpqObj = (JSONObject) cpqArray.getJSONObject(k);
          checkPointName = (String) cpqObj.getString("Name");
          checkPointValue = (Boolean) cpqObj.getBoolean("Value");
          cpqList.add(new CheckpointQuery(checkPointName, checkPointValue));
        }
        textList.add(new Text(TrueText, FalseText, cpqList));
      }
      
      
      choiceList = new ArrayList<Choice>();
      for (int j = 0; j < ChoiceArray.size(); j++) { //Parse list of choices
        ChoiceName = (String) ChoiceArray.getString(j);
        ChoiceObject = (JSONObject) ChoiceFinder.getJSONObject(ChoiceName);
        
        OptionText = (String) ChoiceObject.getString("OptionText");
        Desc = (String) ChoiceObject.getString("Description");
        Scene = (String) ChoiceObject.getString("Scene");
        
        cpqArray = (JSONArray) ChoiceObject.getJSONArray("Checkpoints");
        cpqList = new ArrayList<CheckpointQuery>();
        
        for (int k = 0; k < cpqArray.size(); k++) { //gets all the checkpoints needed for this choice.
          cpqObj = (JSONObject) cpqArray.getJSONObject(k);
          checkPointName = (String) cpqObj.getString("Name");
          checkPointValue = (Boolean) cpqObj.getBoolean("Value");
          cpqList.add(new CheckpointQuery(checkPointName, checkPointValue));
        }
        
        cpqArray = (JSONArray) ChoiceObject.getJSONArray("FlipCheckpoints");
        cpqStringList = new ArrayList<String>();
        
        for (int k = 0; k < cpqArray.size(); k++) { //gets flipcheckpoints
          cpqStringList.add((String) cpqArray.getString(k));
        }
        choiceList.add(new Choice(OptionText, Desc, cpqStringList, Scene, cpqList));
      }
      SceneList.put(name, new Scene(textList, choiceList));
    }
    
    
    return SceneList;
  }

}
