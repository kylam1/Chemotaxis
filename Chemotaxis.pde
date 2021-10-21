int laneHeight = 50;
Walker[] racers = new Walker[10];
int firstPlace, secondPlace, thirdPlace, fourthPlace, fifthPlace, sixthPlace, seventhPlace, eighthPlace, ninthPlace, tenthPlace;
boolean gameStart = false;
int balance = 500; String totalBalance = "Your current balance is: " + balance + " coins";
boolean betOne = false; boolean betTwo = false; boolean betThree = false; boolean betFour = false; boolean betFive = false;
int selectedRacer = 10; //void selection until racer is selected through mousePressed()
boolean getFirst = true; boolean getSecond = true; boolean getThird = true; boolean getFourth = true; boolean getFifth = true; boolean getSixth = true; boolean getSeventh = true; boolean getEighth = true; boolean getNinth = true; boolean getTenth = true;
float firstTime, secondTime, thirdTime, fourthTime, fifthTime, sixthTime, seventhTime, eighthTime, ninthTime, tenthTime;
float raceStartTime = 0;
boolean gameEnd = false;
int totalWon = 0;
boolean poorButtonShown = false; boolean poorButtonPressed = false; boolean chance;
float leverY; int speed;

void setup()
{
  size(1100,500);
  background(0);
  frameRate(20);
  textAlign(CENTER); //All text is centered at x = 575
  firstPlace = 0; secondPlace = 1; thirdPlace = 2; fourthPlace = 3; fifthPlace = 4; sixthPlace = 5; seventhPlace = 6; eighthPlace = 7; ninthPlace = 8; tenthPlace = 9;
  firstTime = secondTime = thirdTime = fourthTime = fifthTime = sixthTime = seventhTime = eighthTime = ninthTime = tenthTime = 0;
  //Array initialization
  int r = 255; int g = 0; int b = 0;
  int racerY = 25;
  for(int i = 0; i < racers.length; i++) {
    color dotColor = color(r,g,b);
    racers[i] = new Walker(25,racerY,dotColor);
    racerY+=50;
    if(i == 2 || i == 3)
      r-=127.5;
    if(i == 8)
      r+=127.5;
    if(i == 0 || i == 1)
      g+=127.5;
    if(i == 6 || i == 7)
      g-=127.5;
    if(i == 4 || i == 5)
      b+=127.5;   
  } // End of Array initialization
  leverY = 385;
}

/////////////////////////////////////

void draw()
{
if(gameStart == true && raceStart == false && startPressed == true && gameEnd == false) {
  //Lever
  fill(255);
  rect(1035, 100, 30, 300, 30);
  strokeWeight(1);
  if(mousePressed == true && (mouseX>=1020 && mouseX<=1080)) { //Horizontal limiter
    if(leverY == 115) { //top of slider
      if(mouseY>=115 && mouseY<=130)
        leverY = mouseY;
    }
    else if(leverY == 385) { //bottom of slider
      if(mouseY<=385 && mouseY>370)
        leverY = mouseY;
    }
    else if((leverY>115 && leverY<385) && (mouseY > leverY - 40 && mouseY < leverY + 40)) { //Middle of slider
      leverY = mouseY;
    }
    else if (mouseY<115 && mouseY>100) //Gives a bit of leeway for dragging up
      leverY = 115;
    else if (mouseY>385 && mouseY<400) //Gives a bit of leeway for dragging down
      leverY = 385;
  } 
  if(leverY < 115) //Top backup reset
    leverY = 115;
  if(leverY > 385)  //Bottom backup reset
    leverY = 385;
  fill(100);
  ellipse(1050, leverY, 30, 30);
  speed = Math.abs(485 - (int)leverY) / 20;
  textAlign(CENTER);
  textSize(15);
  fill(255);
  strokeWeight(1);
  text("Speed Control", 1035, 75);
  //End of Lever
}
  
if(gameStart == false && startPressed == false) {
  //Race Lanes
  strokeWeight(2);
  stroke(200);
  for(int laneY = 0; laneY<=500; laneY+=laneHeight)
    line(0, laneY, 900, laneY);
  //End of Race Lanes
  
  //Racers
  for(int i = 0; i < racers.length; i++) {
    racers[i].noOutline();
    racers[i].show();
  }
  //End of Racers
  
  //Start screen
  fill(0);
  rect(150, 0, 850, 500);
  fill(255);
  textSize(50);
  text("Welcome to Horse Racing!", 575, 100);
  textSize(45);
  text("Make your bet!", 575, 175);
  textSize(30);
  text(totalBalance, 575, 250);
//////////////////////////////////// 
    noStroke();
    if(betOne == true) {
      strokeWeight(3);
      stroke(17, 140, 79); 
    }
  rect(225, 350, 100, 50); //100 Bet
    noStroke();
    if(betTwo == true) {
      strokeWeight(3);
      stroke(17, 140, 79);
    }
  rect(375, 350, 100, 50); //200 Bet 
    noStroke();
    if(betThree == true) {
      strokeWeight(3);
      stroke(17, 140, 79);
    }
  rect(525, 350, 100, 50); //300 Bet
    noStroke();
    if(betFour == true) {
      strokeWeight(3);
      stroke(17, 140, 79);
    }
  rect(675, 350, 100, 50); //400 Bet
    noStroke();
    if(betFive == true) {
      strokeWeight(3);
      stroke(17, 140, 79);
    }
  rect(825, 350, 100, 50); //500 Bet
//////////////////////////////////// 
  textSize(15);
  fill(0);
  text("100 coins", 275, 380);
  text("200 coins", 425, 380);
  text("300 coins", 575, 380);
  text("400 coins", 725, 380);
  text("500 coins", 875, 380);
  
  if(balance < 100) {
    poorButtonShown = true;
    fill(207, 27, 27);
    rect(875, 425, 100, 50);
    fill(0);
    text("I'm Poor :(", 925, 455);
  }
  //End of Start screen
  
  //Poor button screen
  if(poorButtonPressed == true) {
    background(0);
    textAlign(CENTER);
    fill(210, 0, 0);
    strokeWeight(1);
    stroke(200);
    rect(450, 300, 100, 50);
    fill(255);
    textSize(20);
    text("Return", 500, 330);
    noStroke();
    fill(255);
    textSize(40);
    if(chance == true) {  
      text("FINE. HAVE 100 COINS FOR FREE >:|", 500, 150);
      textSize(30);
      text("IT WON'T HAPPEN AGAIN.", 500, 250);
    }
    else {
      text("HAHA. TOO BAD!!!", 500, 150);
      textSize(30);
      text("YOU'LL GET NOTHING FROM ME! >:)", 500, 250);
    }
  }
  //End of Poor button screen
  
  //Bet selected
  if(betSelected == true) {
    for(int a = 0; a < racers.length; a++) {
      if(a == selectedRacer)
        backwardsArrow(150, racers[a].myY, true);
      else
        backwardsArrow(150, racers[a].myY, false);
    }
    fill(255);
    textSize(30);
    text("Now select your 'horse'!", 575, 305);
    textSize(20);
    text("You can still change your bet :)", 575, 450);
  } //End of bet Selected

  //Start button
  if(betSelected == true && racerSelected == true) {
    fill(0);
    noStroke();
    rect(300, 275, 700, 50); //Replace the "Now select your horse" text
    strokeWeight(1);
    stroke(200, 200, 200);
    fill(210, 0, 0);
    rect(425, 275, 300, 50); //The Start button
    fill(255);
    textSize(20);
    text("GET STARTED!!", 575, 305);
  } //End of Start button

} //End of gameStart == false

////////////////////////////////////

if(gameStart == true && raceStart == true && gameEnd == false) {
  background(0);
  
  //Race Lanes
  strokeWeight(2);
  stroke(200);
  for(int laneY = 0; laneY<=500; laneY+=laneHeight)
    line(0, laneY, 900, laneY);
  //End of Race Lanes
  
  //Finish Line
  stroke(255);
  strokeWeight(3);
  line(900, 0, 900, 500);
  line(960, 0, 960, 500);          //FINISH LINE ENDS AT X=960
  boolean whiteSquare = true;
  noStroke();
  for(int finishX = 900; finishX<=950; finishX+=10) {
    for(int finishY = 0; finishY<=500; finishY+=10) {
      if(whiteSquare == true)
        fill(255);
      else
        fill(0);
      rect(finishX, finishY, 10, 10);
      whiteSquare = !whiteSquare;
    }
  }
  //End of Finish Line
  
  //Racers
  for(int i = 0; i<racers.length; i++) {
    racers[i].noOutline();
    racers[i].walk();
    racers[i].show();
  }
  //End of Racers

//////////////////////////////////// 
  //Check placements
  boolean checkForFirst = true;
  int oldFirst = firstPlace;
  for(int checkFinish = 0; checkFinish < racers.length; checkFinish++) { //Checks if the _ place racer has finished the race and should not update
    if(racers[checkFinish].myX >= 960)
      checkForFirst = false;
  }  
  if(checkForFirst == true) {
    for(int firstCheck = 0; firstCheck < racers.length; firstCheck++) {
      if(racers[firstPlace].myX <= racers[firstCheck].myX)
        firstPlace = firstCheck;
    } 
  }  //End check for First place
  
  boolean checkForSecond = true;
  int oldSecond = secondPlace;
  for(int checkFinish = 0; checkFinish < racers.length; checkFinish++) { //Checks if the _ place racer has finished the race and should not update
    if(checkFinish != firstPlace && racers[checkFinish].myX >= 960)
      checkForSecond = false;
  }
  if(checkForSecond == true) {
    for(int secondCheck = 0; secondCheck < racers.length; secondCheck++) {
      if(secondCheck != firstPlace && racers[secondPlace].myX <= racers[secondCheck].myX)
        secondPlace = secondCheck;
      else if(secondPlace == firstPlace)
        secondPlace = oldFirst;       
    } 
  } //End check for second place
    
  boolean checkForThird = true;
  int oldThird = thirdPlace;
  for(int checkFinish = 0; checkFinish < racers.length; checkFinish++) { //Checks if the _ place racer has finished the race and should not update
    if(checkFinish != firstPlace && checkFinish != secondPlace && racers[checkFinish].myX >= 960)
      checkForThird = false;
  }
  if(checkForThird == true) {
    for(int thirdCheck = 0; thirdCheck < racers.length; thirdCheck++) {
      if((thirdCheck != firstPlace) && (thirdCheck != secondPlace) && (racers[thirdPlace].myX <= racers[thirdCheck].myX))
        thirdPlace = thirdCheck;
      if(thirdPlace == secondPlace)
        thirdPlace = oldSecond;
      if(thirdPlace == firstPlace)
        thirdPlace = oldFirst;
    } 
  } //End check for third place
  
  boolean checkForFourth = true;
  int oldFourth = fourthPlace;
  for(int checkFinish = 0; checkFinish < racers.length; checkFinish++) { //Checks if the _ place racer has finished the race and should not update
    if(checkFinish != firstPlace && checkFinish != secondPlace && checkFinish != thirdPlace && racers[checkFinish].myX >= 960)
      checkForFourth = false;
  }
  if(checkForFourth == true) {
    for(int fourthCheck = 0; fourthCheck < racers.length; fourthCheck++) {
      if((fourthCheck != firstPlace) && (fourthCheck != secondPlace) && (fourthCheck != thirdPlace) && (racers[fourthPlace].myX <= racers[fourthCheck].myX))
        fourthPlace = fourthCheck;
      if(fourthPlace == thirdPlace)
        fourthPlace = oldThird;
      if(fourthPlace == secondPlace)
        fourthPlace = oldSecond;
      if(fourthPlace == firstPlace)
        fourthPlace = oldFirst;
    } 
  } //End check for fourth place  
  
  boolean checkForFifth = true;
  int oldFifth = fifthPlace;
  for(int checkFinish = 0; checkFinish < racers.length; checkFinish++) { //Checks if the _ place racer has finished the race and should not update
    if(checkFinish != firstPlace && checkFinish != secondPlace && checkFinish != thirdPlace && checkFinish != fourthPlace && racers[checkFinish].myX >= 960)
      checkForFifth = false;
  }
  if(checkForFifth == true) {
    for(int fifthCheck = 0; fifthCheck < racers.length; fifthCheck++) {
      if((fifthCheck != firstPlace) && (fifthCheck != secondPlace) && (fifthCheck != thirdPlace) && (fifthCheck != fourthPlace) && (racers[fifthPlace].myX <= racers[fifthCheck].myX))
        fifthPlace = fifthCheck;
    if(fifthPlace == fourthPlace)
      fifthPlace = oldFourth;
    if(fifthPlace == thirdPlace)
      fifthPlace = oldThird;
    if(fifthPlace == secondPlace)
      fifthPlace = oldSecond;
    if(fifthPlace == firstPlace)
      fifthPlace = oldFirst;
    } 
  } //End check for fifth place
  
  boolean checkForSixth = true;
  int oldSixth = sixthPlace;
  for(int checkFinish = 0; checkFinish < racers.length; checkFinish++) { //Checks if the _ place racer has finished the race and should not update
    if(checkFinish != firstPlace && checkFinish != secondPlace && checkFinish != thirdPlace && checkFinish != fourthPlace && checkFinish != fifthPlace && racers[checkFinish].myX >= 960)
      checkForSixth = false;
  }
  if(checkForSixth == true) {
    for(int sixthCheck = 0; sixthCheck < racers.length; sixthCheck++) {
      if((sixthCheck != firstPlace) && (sixthCheck != secondPlace) && (sixthCheck != thirdPlace) && (sixthCheck != fourthPlace) && (sixthCheck != fifthPlace) && (racers[sixthPlace].myX <= racers[sixthCheck].myX))
        sixthPlace = sixthCheck;
      if(sixthPlace == fifthPlace)
        sixthPlace = oldFifth;
      if(sixthPlace == fourthPlace)
        sixthPlace = oldFourth;
      if(sixthPlace == thirdPlace)
        sixthPlace = oldThird;
      if(sixthPlace == secondPlace)
        sixthPlace = oldSecond;
      if(sixthPlace == firstPlace)
        sixthPlace = oldFirst;
    } 
  } //End check for sixth place 
  
  boolean checkForSeventh = true;
  int oldSeventh = seventhPlace;
  for(int checkFinish = 0; checkFinish < racers.length; checkFinish++) { //Checks if the _ place racer has finished the race and should not update
    if(checkFinish != firstPlace && checkFinish != secondPlace && checkFinish != thirdPlace && checkFinish != fourthPlace && checkFinish != fifthPlace && checkFinish != sixthPlace && racers[checkFinish].myX >= 960)
      checkForSeventh = false;
  }
  if(checkForSeventh == true) {
    for(int seventhCheck = 0; seventhCheck < racers.length; seventhCheck++) {
      if((seventhCheck != firstPlace) && (seventhCheck != secondPlace) && (seventhCheck != thirdPlace) && (seventhCheck != fourthPlace) && (seventhCheck != fifthPlace) && (seventhCheck != sixthPlace) && (racers[seventhPlace].myX <= racers[seventhCheck].myX))
        seventhPlace = seventhCheck;
      if(seventhPlace == sixthPlace)
        seventhPlace = oldSixth;
      if(seventhPlace == fifthPlace)
        seventhPlace = oldFifth;
      if(seventhPlace == fourthPlace)
        seventhPlace = oldFourth;
      if(seventhPlace == thirdPlace)
        seventhPlace = oldThird;
      if(seventhPlace == secondPlace)
        seventhPlace = oldSecond;
      if(seventhPlace == firstPlace)
        seventhPlace = oldFirst;
    }  
  } //End check for seventh place
  
  boolean checkForEighth = true;
  int oldEighth = eighthPlace;
  for(int checkFinish = 0; checkFinish < racers.length; checkFinish++) { //Checks if the _ place racer has finished the race and should not update
    if(checkFinish != firstPlace && checkFinish != secondPlace && checkFinish != thirdPlace && checkFinish != fourthPlace && checkFinish != fifthPlace && checkFinish != sixthPlace && checkFinish != seventhPlace && racers[checkFinish].myX >= 960)
      checkForEighth = false;
  }
  if(checkForEighth == true) {
    for(int eighthCheck = 0; eighthCheck < racers.length; eighthCheck++) {
      if((eighthCheck != firstPlace) && (eighthCheck != secondPlace) && (eighthCheck != thirdPlace) && (eighthCheck != fourthPlace) && (eighthCheck != fifthPlace) && (eighthCheck != sixthPlace) && (eighthCheck != seventhPlace) && (racers[eighthPlace].myX <= racers[eighthCheck].myX))
        eighthPlace = eighthCheck;
      if(eighthPlace == seventhPlace)
        eighthPlace = oldSeventh;
      if(eighthPlace == sixthPlace)
        eighthPlace = oldSixth;
      if(eighthPlace == fifthPlace)
        eighthPlace = oldFifth;
      if(eighthPlace == fourthPlace)
        eighthPlace = oldFourth;
      if(eighthPlace == thirdPlace)
        eighthPlace = oldThird;
      if(eighthPlace == secondPlace)
        eighthPlace = oldSecond;
      if(eighthPlace == firstPlace)
        eighthPlace = oldFirst;
      }
   } //End check for eighth place
   
  boolean checkForNinth = true;
  int oldNinth = ninthPlace;
  for(int checkFinish = 0; checkFinish < racers.length; checkFinish++) { //Checks if the _ place racer has finished the race and should not update
    if(checkFinish != firstPlace && checkFinish != secondPlace && checkFinish != thirdPlace && checkFinish != fourthPlace && checkFinish != fifthPlace && checkFinish != sixthPlace && checkFinish != seventhPlace && checkFinish != eighthPlace && racers[checkFinish].myX >= 960)
      checkForNinth = false;
  }
  if(checkForNinth == true) {
    for(int ninthCheck = 0; ninthCheck < racers.length; ninthCheck++) {
      if((ninthCheck != firstPlace) && (ninthCheck != secondPlace) && (ninthCheck != thirdPlace) && (ninthCheck != fourthPlace) && (ninthCheck != fifthPlace) && (ninthCheck != sixthPlace) && (ninthCheck != seventhPlace) && (ninthCheck != eighthPlace) && (racers[ninthPlace].myX <= racers[ninthCheck].myX))
        ninthPlace = ninthCheck;
      if(ninthPlace == eighthPlace)
        ninthPlace = oldEighth;
      if(ninthPlace == seventhPlace)
        ninthPlace = oldSeventh;
      if(ninthPlace == sixthPlace)
        ninthPlace = oldSixth;
      if(ninthPlace == fifthPlace)
        ninthPlace = oldFifth;
      if(ninthPlace == fourthPlace)
        ninthPlace = oldFourth;
      if(ninthPlace == thirdPlace)
        ninthPlace = oldThird;
      if(ninthPlace == secondPlace)
        ninthPlace = oldSecond;
      if(ninthPlace == firstPlace)
        ninthPlace = oldFirst;
    }
  } //End check for ninth place
  
  boolean checkForTenth = true; 
  for(int checkFinish = 0; checkFinish < racers.length; checkFinish++) { //Checks if the _ place racer has finished the race and should not update
    if(checkFinish != firstPlace && checkFinish != secondPlace && checkFinish != thirdPlace && checkFinish != fourthPlace && checkFinish != fifthPlace && checkFinish != sixthPlace && checkFinish != seventhPlace && checkFinish != eighthPlace && checkFinish != ninthPlace && racers[checkFinish].myX >= 960)
      checkForTenth = false;
  }
  if(checkForTenth == true) {
    for(int tenthCheck = 0; tenthCheck < racers.length; tenthCheck++) {
      if((tenthCheck != firstPlace) && (tenthCheck != secondPlace) && (tenthCheck != thirdPlace) && (tenthCheck != fourthPlace) && (tenthCheck != fifthPlace) && (tenthCheck != sixthPlace) && (tenthCheck != seventhPlace) && (tenthCheck != eighthPlace) && (tenthCheck != ninthPlace) && (racers[tenthPlace].myX <= racers[tenthCheck].myX))
        tenthPlace = tenthCheck;
      if(tenthPlace == ninthPlace)
        tenthPlace = oldNinth;
      if(tenthPlace == eighthPlace)
        tenthPlace = oldEighth;
      if(tenthPlace == seventhPlace)
        tenthPlace = oldSeventh;
      if(tenthPlace == sixthPlace)
        tenthPlace = oldSixth;
      if(tenthPlace == fifthPlace)
        tenthPlace = oldFifth;
      if(tenthPlace == fourthPlace)
        tenthPlace = oldFourth;
      if(tenthPlace == thirdPlace)
        tenthPlace = oldThird;
      if(tenthPlace == secondPlace)
        tenthPlace = oldSecond;
      if(tenthPlace == firstPlace)
        tenthPlace = oldFirst;
    }
  } //End check for tenth (last) place
  //System.out.println(firstPlace + ", " + secondPlace + ", " + thirdPlace + ", " + fourthPlace + ", " + fifthPlace + ", " + sixthPlace + ", " + seventhPlace + ", " + eighthPlace + ", " + ninthPlace + ", " + tenthPlace);  

//////////////////////////////////// End of check placements

  //Racer "medals"
  color gold = color(247,201,56);
  color silver = color(210);
  color bronze = color(205,127,50);
  racers[firstPlace].outline(gold);
  racers[firstPlace].show();
  racers[secondPlace].outline(silver);
  racers[secondPlace].show();
  racers[thirdPlace].outline(bronze);
  racers[thirdPlace].show();
  //End of racer "medals"
  
  //Leading line
  strokeWeight(1);
  stroke(255);
  line(racers[firstPlace].myX+15, 0, racers[firstPlace].myX+15, 500);
  //End of Leading line
  
  //Points at selected racer
  if(racers[selectedRacer].myX < 960)
    arrow(racers[selectedRacer].myX-20, racers[selectedRacer].myY);
  if(racers[selectedRacer].myX >= 960) {
    fill(255);
    textAlign(CENTER);
    textSize(20);
    text("YOU", 800, racers[selectedRacer].laneY + 6);
  }  
  //End of pointer at selected racer
  
  //Final placement
  color offPodium = color(61, 132, 255);
  textAlign(LEFT);
  textSize(20);
  if(racers[firstPlace].myX >= 960) {
    fill(gold);
    if(getFirst == true)
       firstTime = (float)millis()/1000 - raceStartTime;
       getFirst = false;
    String first = "1st Place" + " - " + (int(firstTime*1000))/1000.;
    text(first, 50, racers[firstPlace].laneY + 5);
  }
  if(racers[secondPlace].myX >= 960) {
    fill(silver);
    if(getSecond == true)
      secondTime = (float)millis()/1000 - raceStartTime;
      getSecond = false;
    String second = "2nd Place" + " - " + (int(secondTime*1000))/1000.;
    text(second, 50, racers[secondPlace].laneY + 5);
  }
  if(racers[thirdPlace].myX >= 960) {
    fill(bronze);
    if(getThird == true)
      thirdTime = (float)millis()/1000 - raceStartTime;
      getThird = false;
    String third = "3rd Place" + " - " + (int(thirdTime*1000))/1000.;
    text(third, 50, racers[thirdPlace].laneY + 5);
  }
  if(racers[fourthPlace].myX >= 960) {
    fill(offPodium);
    if(getFourth == true)
      fourthTime = (float)millis()/1000 - raceStartTime;
      getFourth = false;
    String fourth = "4th Place" + " - " + (int(fourthTime*1000))/1000.;
    text(fourth, 50, racers[fourthPlace].laneY + 5);
  }
  if(racers[fifthPlace].myX >= 960) {
    fill(offPodium);
    if(getFifth == true)
      fifthTime = (float)millis()/1000 - raceStartTime;
      getFifth = false;
    String fifth = "5th Place" + " - " + (int(fifthTime*1000))/1000.;
    text(fifth, 50, racers[fifthPlace].laneY + 5);
  }
  if(racers[sixthPlace].myX >= 960) {
    fill(offPodium);
    if(getSixth == true)
      sixthTime = (float)millis()/1000 - raceStartTime;
      getSixth = false;
    String sixth = "6th Place" + " - " + (int(sixthTime*1000))/1000.;
    text(sixth, 50, racers[sixthPlace].laneY + 5);
  }
  if(racers[seventhPlace].myX >= 960) {
    fill(offPodium);
    if(getSeventh == true)
      seventhTime = (float)millis()/1000 - raceStartTime;
      getSeventh = false;
    String seventh = "7th Place" + " - " + (int(seventhTime*1000))/1000.;
    text(seventh, 50, racers[seventhPlace].laneY + 5);
  }
  if(racers[eighthPlace].myX >= 960) {
    fill(offPodium);
    if(getEighth == true)
      eighthTime = (float)millis()/1000 - raceStartTime;
      getEighth = false;
    String eighth = "8th Place" + " - " + (int(eighthTime*1000))/1000.;
    text(eighth, 50, racers[eighthPlace].laneY + 5);
  }
  if(racers[ninthPlace].myX >= 960) {
    fill(offPodium);
    if(getNinth == true)
      ninthTime = (float)millis()/1000 - raceStartTime;
      getNinth = false;
    String ninth = "9th Place" + " - " + (int(ninthTime*1000))/1000.;
    text(ninth, 50, racers[ninthPlace].laneY + 5);
  }
  if(racers[tenthPlace].myX >= 960) {
    fill(offPodium);
    if(getTenth == true)
      tenthTime = (float)millis()/1000 - raceStartTime;
      getTenth = false;
    String tenth = "10th Place" + " - " + (int(tenthTime*1000))/1000.;
    text(tenth, 50, racers[tenthPlace].laneY + 5);
  }
  //End of Final placement
  
  //Game ending
  if(racers[0].myX >= 985 && racers[1].myX >= 985 && racers[2].myX >= 985 && racers[3].myX >= 985 && racers[4].myX >= 985 && racers[5].myX >= 985 && racers[6].myX >= 985 && racers[7].myX >= 985 && racers[8].myX >= 985 && racers[9].myX >= 985) {
    gameEnd = true;
    raceStart = false;
   
    //Finish button
    textAlign(CENTER);
    strokeWeight(1);
    stroke(200, 200, 200);
    fill(210, 0, 0);
    rect(380, 225, 140, 50);
    fill(255);
    textSize(20);
    text("Finish", 450, 255);
    //End of Finish button
  } //End of game ending
  
} //End of gameStart == true
} //End of void draw()

////////////////////////////////////  START OF MOUSEPRESSED()

boolean loop = false;
boolean betSelected = false;
boolean racerSelected = false;
boolean startPressed = false; boolean raceStart = false;
boolean getStartTime = true;
boolean finishPressed = false;
boolean updateBalance = true;
int bet = 0;
void mousePressed() {
if(gameStart == false) {
  if(mouseY >= 350 && mouseY <= 400) { //Y position of bet selection buttons
    if(mouseX >= 225 && mouseX <= 325 && balance >= 100) { //Bet 100
      betOne = true;
      betTwo = betThree = betFour = betFive = false;
      betSelected = true;
      bet = 100;
    }
    if(mouseX >= 375 && mouseX <= 475 && balance >= 200) { //Bet 200
      betTwo = true;
      betOne = betThree = betFour = betFive = false;
      betSelected = true;
      bet = 200;
    }
    if(mouseX >= 525 && mouseX <= 625 && balance >= 300) { //Bet 300
      betThree = true;
      betOne = betTwo = betFour = betFive = false;
      betSelected = true;
      bet = 300;
    }
    if(mouseX >= 675 && mouseX <= 775 && balance >= 400) { //Bet 400
      betFour = true;
      betOne = betTwo = betThree = betFive = false;
      betSelected = true;
      bet = 400;
    }
    if(mouseX >= 825 && mouseX <= 925 && balance >= 500) { //Bet 500
      betFive = true;
      betOne = betTwo = betThree = betFour = false;
      betSelected = true;
      bet = 500;
    }
  } //End of check Y position of bet selection buttons
  
  //I'M POOR BUTTON
  if(mouseX >= 875 && mouseX <= 975 && mouseY >= 425 && mouseY <= 475 && poorButtonShown == true) {
    chance = Math.random() > 0.5;
    if(chance == true)
      balance += 100;
    totalBalance = "Your current balance is: " + balance + " coins";
    poorButtonPressed = true;
    poorButtonShown = false;
  }
  if(mouseX >= 450 && mouseX <= 550 && mouseY >= 300 && mouseY <= 350 && poorButtonPressed == true) {
    poorButtonPressed = false;
  }//End of I'm Poor button
  
  //Racer selection
  if(betSelected == true) {
    if(mouseX >= 0 && mouseX <= 150) { //X position of selecting racers
      int lowerCheck = 0; int higherCheck = 50;
      for(int check = 0; check < racers.length; check++) {
        if(mouseY >= lowerCheck && mouseY < higherCheck) {
          selectedRacer = check;
          racerSelected = true;
        }
        lowerCheck+=50;
        higherCheck+=50;
      }
    } 
  } //End of Racer selection
  
  //Race button
  if(startPressed == false && betSelected == true && racerSelected == true && mouseX >=425 && mouseX <= 725 && mouseY >= 275 && mouseY <= 325) {
    startPressed = true;
    gameStart = true;
    loop = true;
    background(0);
  
  //Race Lanes
  strokeWeight(2);
  stroke(200);
  for(int laneY = 0; laneY<=500; laneY+=laneHeight)
    line(0, laneY, 900, laneY);
  //End of Race Lanes

  //Finish Line
  stroke(255);
  strokeWeight(3);
  line(900, 0, 900, 500);
  line(960, 0, 960, 500);          //FINISH LINE ENDS AT X=960
  boolean whiteSquare = true;
  noStroke();
  for(int finishX = 900; finishX<=950; finishX+=10) {
    for(int finishY = 0; finishY<=500; finishY+=10) {
      if(whiteSquare == true)
        fill(255);
      else
        fill(0);
      rect(finishX, finishY, 10, 10);
      whiteSquare = !whiteSquare;
    }
  }
  //End of Finish Line
  
  //Racers
  for(int i = 0; i<racers.length; i++) {
    racers[i].noOutline();
    racers[i].show();
  }
  //End of Racers
  
  //Leading line
  strokeWeight(1);
  stroke(255);
  line(racers[firstPlace].myX+15, 0, racers[firstPlace].myX+15, 500);
  //End of Leading line
  
  //Points at selected racer
  if(racers[selectedRacer].myX < 960)
    arrow(racers[selectedRacer].myX-20, racers[selectedRacer].myY);
  //End of pointer at selected racer
  
  //Race button
    strokeWeight(1);
    stroke(200, 200, 200);
    fill(210, 0, 0);
    rect(380, 225, 140, 50);
    fill(255);
    textSize(20);
    text("Start Race!", 450, 255);  
  } //End of Race button

} //End of gameStart == false

////////////////////////////////////  

if(gameStart == true) {
  
  //Begin Race
  getStartTime = true;
  if(gameStart == true && mouseX >= 380 && mouseX <= 520 && mouseY >= 225 && mouseY <= 275) {
    raceStart = true;
    if(getStartTime == true) {
      getStartTime = false;
      raceStartTime = millis()/1000;
      System.out.println(raceStartTime);
    }
  } //End of Begin Race
} //End of gameStart == true

  //Pause function
  if(raceStart == true && gameEnd == false) {  
    //Pause function
    loop = !loop;
    if(loop == true)
      noLoop();
    else
      loop(); 
  } //End of Pause function
  
  //End screen
  if(gameEnd == true && raceStart == true) {
    if(mouseX >= 380 && mouseX <= 520 && mouseY >= 225 && mouseY <= 275 && finishPressed == false) {
      finishPressed = true;
      fill(0);
      noStroke();
      rect(0, 0, 775, 500); //Black rectangle on top of everything :)
      rect(750, racers[selectedRacer].laneY - 20, 100, 40);  //Covers the text saying "YOU" in your lane after racer finishes
      
      //Finish Screen
      if(selectedRacer == firstPlace || selectedRacer == secondPlace || selectedRacer == thirdPlace) {
        textSize(40);
        strokeWeight(1);
        textAlign(CENTER);
        fill(255);
        text("CONGRATULATIONS!!!", 387.5, 60);
        if(selectedRacer == firstPlace) {
          String firstPlaceEnd = "You got first place with a time of " + firstTime;
          textSize(30);
          text(firstPlaceEnd, 387.5, 125);         
          totalWon = (int)(bet * 2); //First place gets 200% of their bet as a prize
        }
        if(selectedRacer == secondPlace) {
          String secondPlaceEnd = "You got second place with a time of " + secondTime;
          textSize(30);
          text(secondPlaceEnd, 387.5, 125);         
          totalWon = (int)(bet*1.5); //Second place 150% of bet
        }
        if(selectedRacer == thirdPlace) {
          String thirdPlaceEnd = "You got third place with a time of " + thirdTime;
          textSize(30);
          text(thirdPlaceEnd, 387.5, 125);          
          totalWon = (int)(bet*1); //Third place 100% of bet
        }
      }
      else if(selectedRacer == fourthPlace || selectedRacer == fifthPlace || selectedRacer == sixthPlace) {
        textSize(40);
        strokeWeight(1);
        textAlign(CENTER);
        fill(255);
        text("You did well!", 387.5, 60);
        if(selectedRacer == fourthPlace) {
          String fourthPlaceEnd = "You got fourth place with a time of " + fourthTime;
          textSize(30);
          text(fourthPlaceEnd, 387.5, 125);          
          totalWon = (int)(bet*0.5); //4th place 50% of bet
        }
        if(selectedRacer == fifthPlace) {
          String fifthPlaceEnd = "You got fifth place with a time of " + fifthTime;
          textSize(30);
          text(fifthPlaceEnd, 387.5, 125);
          totalWon = (int)(bet*0.25); //5th place 25% of bet
        }
        if(selectedRacer == sixthPlace) {
          String sixthPlaceEnd = "You got sixth place with a time of " + sixthTime;
          textSize(30);
          text(sixthPlaceEnd, 387.5, 125);
          totalWon = (int)(bet*0); //6th place gain nothing, lose nothing
        }
      }
      else {
        textSize(40);
        strokeWeight(1);
        textAlign(CENTER);
        fill(255);
        text("Better luck next time :(", 387.5, 60);
        if(selectedRacer == seventhPlace) {
          String seventhPlaceEnd = "You got seventh place with a time of " + seventhTime;
          textSize(30);
          text(seventhPlaceEnd, 387.5, 125); 
          totalWon = (int)(bet*-0.25); //7th place lose 25% of bet
        }
        if(selectedRacer == eighthPlace) {
          String eighthPlaceEnd = "You got eighth place with a time of " + eighthTime;
          textSize(30);
          text(eighthPlaceEnd, 387.5, 125);
          
            totalWon = (int)(bet*-0.5); //8th place lose 50% of bet
        }
        if(selectedRacer == ninthPlace) {
          String ninthPlaceEnd = "You got ninth place with a time of " + ninthTime;
          textSize(30);
          text(ninthPlaceEnd, 387.5, 125);
          totalWon = (int)(bet*-0.75); //9th place lose 75% of bet
        }
        if(selectedRacer == tenthPlace) {
          String tenthPlaceEnd = "You got tenth place with a time of " + tenthTime;
          textSize(30);
          text(tenthPlaceEnd, 387.5, 125);
          totalWon = (int)(bet*-1); //10th place lose 100% of bet
        }
      }
      
      fill(247,201,56);
      String coinsWon;
      if(selectedRacer == seventhPlace || selectedRacer == eighthPlace || selectedRacer == ninthPlace || selectedRacer == tenthPlace)
        coinsWon = "You lost " + -(totalWon) + " coins";
      else
        coinsWon = "You won " + totalWon + " coins!";
      text(coinsWon, 387.5, 190);
      fill(255);
      textSize(25);
      if(updateBalance == true)
        balance += totalWon;  //NEW BALANCE AFTER MONEY MADE FROM BETTING
      String newBalance = "You now have " + balance + " coins";
      text(newBalance, 387.5, 240);
      
      stroke(200, 200, 200);
      fill(210, 0, 0);
      rect(160, 345, 125, 50);
      fill(255);
      textSize(15);
      text("One more race!", 222.5, 375);
      fill(210, 0, 0);
      rect(500, 345, 125, 50);
      fill(255);
      text("Return to race", 562.5, 375);
      //End of Finish screen
    }
  } //End of End screen

  if(finishPressed == true) {
    //Return button
    if(mouseX >= 500 && mouseX <= 625 && mouseY >= 345 && mouseY <= 395 && gameEnd == true) {
      finishPressed = false;
      gameEnd = false;
      updateBalance = false;
    } //End of "Return" button
    
    //"One more race!" reset button
    if(mouseX >= 160 && mouseX <= 285 && mouseY >= 345 && mouseY <= 395 && gameEnd == true) {
      background(0);
      finishPressed = false;
      gameStart = gameEnd = false;
      betOne = betTwo = betThree = betFour = betFive = false;
      selectedRacer = 10;
      loop = false;
      betSelected = false;
      racerSelected = false;
      startPressed = false; raceStart = false;
      finishPressed = false;
      updateBalance = true;
      bet = 0;
      firstPlace = 0; secondPlace = 1; thirdPlace = 2; fourthPlace = 3; fifthPlace = 4; sixthPlace = 5; seventhPlace = 6; eighthPlace = 7; ninthPlace = 8; tenthPlace = 9;
      firstTime = secondTime = thirdTime = fourthTime = fifthTime = sixthTime = seventhTime = eighthTime = ninthTime = tenthTime = 0;
      getFirst = getSecond = getThird = getFourth = getFifth = getSixth = getSeventh = getEighth = getNinth = getTenth = true;
      getStartTime = true;
      totalBalance = "Your current balance is: " + balance + " coins";
      //Array initialization
      int r = 255; int g = 0; int b = 0;
      int racerY = 25;
      for(int i = 0; i < racers.length; i++) {
        color dotColor = color(r,g,b);
        racers[i] = new Walker(25,racerY,dotColor);
        racerY+=50;
        if(i == 2 || i == 3)
          r-=127.5;
        if(i == 8)
          r+=127.5;
        if(i == 0 || i == 1)
          g+=127.5;
        if(i == 6 || i == 7)
          g-=127.5;
        if(i == 4 || i == 5)
          b+=127.5;   
      } // End of Array initialization
    } //End of reset button
    
  } //End of finishPressed == true  
} //End of mousePressed()

////////////////////////////////////

class Walker
{
  int myX, myY, laneY;
  color myColor;
  
  Walker(int x, int y, color racerColor) 
  {
    myX = x;
    myY = y;
    laneY = y;
    myColor = racerColor;
  }
  
  void walk()
  {
    if(myX <= 985){ 
      myX+= (int)(Math.random()*speed); //Speed of racers
      if (myY >= laneY+(laneHeight/4)) //Lower limit of lane
        myY-= 3;
      else if (myY <= laneY - (laneHeight/4)) //Upper limit of lane
        myY+= 3;
      else
        myY+= (int)(Math.random()*3)-1; //Regular y movement
    }        
  }
  
  void outline(color outlineColor)
  {
    strokeWeight(5);
    stroke(outlineColor);
  }
  void noOutline()
  {
    noStroke();
  }
  
  void show()
  {
    fill(myColor);
    ellipse(myX, myY, 25, 25);
  }
}

////////////////////////////////////
void arrow(float x, float y) 
{
  strokeWeight(1);
  stroke(255);
  line(x-30, y, x, y);
  line(x-10, y-5, x, y);
  line(x-10, y+5, x, y);
}
void backwardsArrow(float x, float y, boolean selected)
{
  strokeWeight(1);
  if(selected == true)
    stroke(17, 140, 79);
  else
    stroke(255);
  line(x, y, x+30, y);
  line(x, y, x+10, y-5);
  line(x, y, x+10, y+5);
}
