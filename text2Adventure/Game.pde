import java.util.Map;

public class Game {

  private Map<String, Scene> Scenes = new HashMap<String, Scene>();
  private Map<String, Boolean> CheckPoints = new HashMap<String, Boolean>();
  private boolean gameOver;
  private Scene currentScene;
  private  int userIn;
  private  Choice runChoice;
  private  ArrayList<String> flipList;


  public Game(Map<String, Scene> ScenesArg, Map<String, Boolean> CheckPointsArg, String CurrentScene) {
    setScenes(ScenesArg);
    setCheckPoints(CheckPointsArg);
    currentScene = Scenes.get(CurrentScene);
  }


  public Scene getStartScene(String Name) {
    return this.Scenes.get(Name);
  }

  public Map<String, Scene> getScenes() {
    return this.Scenes;
  }

  public void setScenes(Map<String, Scene> Scenes) {
    this.Scenes = Scenes;
    return;
  }

  public void setCheckPoints(Map<String, Boolean> CheckPoints) {
    this.CheckPoints = CheckPoints;
    return;
  }

  public Map<String, Boolean> getCheckPoints() {
    return this.CheckPoints;
  }

  public boolean isGameOver() {
    return this.gameOver;
  }

  public void endGame() {
    this.gameOver = true;
    printLine("");
    printLine("Closing game. Thanks for playing!");
    printLine("");
    return;
  }

  public boolean CheckPointAvaliable(String Name) {
    return this.CheckPoints.get(Name);
  }

  public String getTextString(Text text) {
    ArrayList<CheckpointQuery> checkList = text.getCheckpointsRequired();
    CheckpointQuery check;
    boolean checkVal = true;
    for (int j = 0; j < checkList.size(); j++) {
      check = checkList.get(j);
      if (check.getWantedValue() != CheckPoints.get(check.getCheckpointName())) {
        checkVal = false;
      }
    }
    if (checkVal) {
      return text.getTrueText();
    } else {
      return text.getFalseText();
    }
  }

  public Boolean checkValidChoice(Choice choice) {
    ArrayList<CheckpointQuery> checkList = choice.getCheckpoints();
    CheckpointQuery check;
    boolean checkVal = true;
    for (int j = 0; j < checkList.size(); j++) {
      check = checkList.get(j);
      if (! (check.getWantedValue() == CheckPoints.get(check.getCheckpointName()))) {
        checkVal = false;
      }
    }
    return checkVal;
  }

  public void printChoice(Choice choice, int choiceNumber) {
    if (checkValidChoice(choice)) {
      printLine(""+choiceNumber+") "+choice.getOptionText());
    }
    return;
  }

  public void printSceneChoicesText() {
    ArrayList<Choice> choiceList = currentScene.getChoices();
    for (int i = 0; i < choiceList.size(); i++) {
      printChoice(choiceList.get(i), i);
    }
    return;
  }

  public String getSceneDescription(Scene scene) {
    String returnString = "";
    Text text;
    ArrayList<Text> description = scene.getDescription();

    for (int currentLine = 0; currentLine < description.size(); currentLine++) {
      text = description.get(currentLine);
      String temp = getTextString(text);
      if (temp.length()>0)
      {
        if (currentLine > 0)
          returnString += "\n";
        returnString += temp;
      }
    }
    return returnString;
  }

  public void flipValues(ArrayList<String> flipList) {
    String currentCheckpoint;
    for (int i = 0; i < flipList.size(); i++) {
      currentCheckpoint = flipList.get(i);
      if (CheckPoints.get(currentCheckpoint)) {
        CheckPoints.replace(currentCheckpoint, false);
      } else {
        CheckPoints.replace(currentCheckpoint, true);
      }
    }
    return;
  }

  public int getUserInput(ArrayList<Choice> choiceList) {
    int number;

    String choice = input;
    if (choice.equals("exit")) {
      return -1;
    } else {
      try {
        number = Integer.parseInt(choice);
      } 
      catch (Exception e) {
        return -2;
      }
      if (number >= choiceList.size() || number < 0) {
        return -2;
      }
      if (checkValidChoice(choiceList.get(number))) {
        return number;
      } else {
        return -2;
      }
    }
  }

  public void step() {
    //printLine("----------------------------------------------------------");
    printLine(getSceneDescription(currentScene));
    printSceneChoicesText();
  }
  public void processInput()
  {
    printError("");
    userIn = getUserInput(currentScene.getChoices());
    if (userIn == -1) {
      endGame();
    } else if (userIn == -2) {
      printError("Please enter a valid choice.");
    } else {
      runChoice = currentScene.getChoices().get(userIn);
      printLine(runChoice.getDescription());
      flipList = runChoice.getFlipCheckpoints();
      flipValues(flipList);
      currentScene = Scenes.get(runChoice.getScene());
    }
  }
}
