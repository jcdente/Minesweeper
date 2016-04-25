import de.bezier.guido.*;
private MSButton[][] buttons; 
private ArrayList <MSButton> bombs = new ArrayList <MSButton>();
int NUM_ROWS=20;
int NUM_COLS=20;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    

    Interactive.make( this );
buttons = new MSButton[20][20];    
for(int r=0; r<NUM_ROWS; r++){
    for(int c=0; c< NUM_COLS; c++){
        buttons[r][c]=new MSButton(r,c);
    }
 }   
    
    
    setBombs();
}
public void setBombs()
{  
    if(bombs.size()<40)
    {
int r= (int)(Math.random()*20);
int c= (int)(Math.random()*20);
if (!bombs.contains(buttons[r][c]))
        {
    bombs.add(buttons[r][c]);
        }
    }
}

public void draw()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
            setBombs();
}
public boolean isWon()
{
    for(int i=0;i<NUM_ROWS;i++){
        for(int j=0;j<NUM_COLS;j++){
            if(buttons[i][j].isMarked()==false&&bombs.contains(buttons[i][j])){
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
  for(int r=0;r<NUM_ROWS;r++){
        for(int c=0;c<NUM_COLS;c++){
            if(!buttons[r][c].isClicked()&&bombs.contains(buttons[r][c])){
                buttons[r][c].marked=false;
                buttons[r][c].clicked=true;
                    buttons[0][0].setLabel("R");
                    buttons[0][1].setLabel("e");
                    buttons[0][2].setLabel("k");
                    buttons[0][3].setLabel("t");
                    buttons[0][4].setLabel("e");
                    buttons[0][5].setLabel("r");
                    buttons[0][6].setLabel("o");
                    buttons[0][7].setLabel("o");
                    buttons[0][8].setLabel("n");
                    buttons[0][9].setLabel("i");
                    buttons[0][10].setLabel("e");
                    buttons[0][11].setLabel("d");

            }
        }
    }
}
public void displayWinningMessage()
{
                    buttons[0][0].setLabel("Y");
                    buttons[0][1].setLabel("o");
                    buttons[0][2].setLabel("u");
                    buttons[0][3].setLabel(" ");
                    buttons[0][4].setLabel("w");
                    buttons[0][5].setLabel("o");
                    buttons[0][6].setLabel("n");
                    buttons[0][7].setLabel("n");
                    buttons[0][8].setLabel("e");
                    buttons[0][9].setLabel("r");
                    buttons[0][10].setLabel("e");
                    buttons[0][11].setLabel("d");
                    buttons[0][12].setLabel("!");

}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this );
    }
    public boolean isMarked()
    {
    
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager

    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton==RIGHT)
        { 
            fill(0);
            marked = !marked;
        }
        else if (bombs.contains(this)&&clicked == true){
            displayLosingMessage();
        }
        else if(countBombs(r,c)>0){
            label=""+countBombs(r,c);
        }
            else
        {
           if(isValid(r-1,c) && !buttons[r-1][c].clicked)
              buttons[r-1][c].mousePressed();
           if(isValid(r+1,c) && !buttons[r+1][c].clicked)
              buttons[r+1][c].mousePressed();
           if(isValid(r,c-1) && !buttons[r][c-1].clicked)
              buttons[r][c-1].mousePressed();
           if(isValid(r,c+1) && !buttons[r][c+1].clicked)
              buttons[r][c+1].mousePressed();
           if(isValid(r-1,c+1) && !buttons[r-1][c+1].clicked)
              buttons[r-1][c+1].mousePressed();
           if(isValid(r+1,c+1) && !buttons[r+1][c+1].clicked)
              buttons[r+1][c+1].mousePressed();
           if(isValid(r-1,c-1) && !buttons[r-1][c-1].clicked)
              buttons[r-1][c-1].mousePressed();
           if(isValid(r+1,c-1) && !buttons[r+1][c-1].clicked)
              buttons[r+1][c-1].mousePressed();
        }
    }
    public void draw () 
    {    
        if (marked)
            fill(0);
       else if( clicked==true && bombs.contains(this)) {
        displayLosingMessage();
             fill(255,0,0);
         }
        else if(clicked==true)
            fill( 200 );

        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
       if(r>=0&&r<NUM_ROWS&&c>=0&&c<NUM_COLS){
        return true;
    }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row-1,col) && bombs.contains(buttons[row-1][col]))
            numBombs++;
        if(isValid(row+1,col) && bombs.contains(buttons[row+1][col]))
            numBombs++;
        if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1]))
            numBombs++;
        if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1]))
            numBombs++;
        if(isValid(row,col-1) && bombs.contains(buttons[row][col-1]))
            numBombs++;
        if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1]))
            numBombs++;
        if(isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1]))
            numBombs++;
        if(isValid(row,col+1) && bombs.contains(buttons[row][col+1]))
            numBombs++;

        return numBombs;

    }
}
