//@SuppressWarnings("resource")
HashMap<String, Scene> Scenes = new HashMap<String, Scene>();
HashMap<String, Boolean> CheckPoints = new HashMap<String, Boolean>();
String currentSceneName;
String filename;
String [] lines = new String[22];
String input = "";
String error = "";
Game newGame;
int timer = -1;
int scene = 0;

void setup()
{  
  size(800, 800);

  for (int i=0; i<lines.length; i++)
    lines[i] = "";
}
void keyTyped()
{
  if (key == ENTER || key == TAB)
  {
    if (scene == 0)
      fileInput();
    else if (scene == 1)
      gameInput();
  } else if (key==DELETE || key == BACKSPACE)
  {
    if (input.length() > 0)
      input = input.substring(0, input.length() -1);
  } else if ((key >='a' && key <='z') || 
    (key >='A' && key <='Z')|| (key >='0' && key <='9'))
  {
    input += key;
  }
}
void fileInput()
{
  filename=input;

  ReadJSONFile parser = new ReadJSONFile(filename+".json");
  input="";
  if (error.length()==0)
  {
    printLine("File loaded!");
    printLine("");

    currentSceneName = parser.getFirstScene();
    CheckPoints = parser.getCheckpoints();
    Scenes = parser.getScenes();

    newGame = new Game(Scenes, CheckPoints, currentSceneName);
    scene=1;
    newGame.step();
  }
}
void gameInput()
{
  newGame.processInput();
  input="";
  if (error.length() == 0 && !newGame.isGameOver())
    newGame.step();
}
void draw()
{
  background(0);
  if (scene == 0)
  {
    fill(255);
    textSize(40);
    text("The Ultimate Text Adventure Game", 40, 100);
    fill(#19FA26);
    textSize(20);
    text("Enter your filename: "+input+".json", 50, 300);
    fill(#FA1219);
    text(error, 50, 350);
    fill(255);
    text("Read the story...make your choices...", 50, 400);
    text("Type \'exit\' to exit", 50, 430);
  }
  if (scene == 1)
  {
    fill(#19FA26);
    textSize(40);
    text(filename+" Text Adventure", 100, 42);
    textSize(14);
    fill(255);
    for (int i=0; i<lines.length; i++)
      text(lines[i], 30, 720 - i*30);
    fill(#19FA26);
    text("Enter choice: "+input, 30, 750);
    fill(#FA1219);
    text(error, 30, 780);
    if (newGame.isGameOver() && timer == -1)
      timer = 175;
    if (timer > 0)
      timer--;
    else if (timer == 0)
      exit();
  }
}

void printLine(String str)
{
  String [] iln = split(str, '\n');
  int icnt = iln.length;
  for (int i=lines.length-1; i>=icnt; i--)
    lines[i] = lines[i-icnt];
  for (int i=icnt-1; i>=0; i--)
    lines[i] = iln[icnt-1-i];
}

void printError(String str)
{
  error = str;
}
