#include "ofApp.h"
#include <algorithm>


//--------------------------------------------------------------
void ofApp::setup(){	
    soundPlayer.load("crash.wav");
    myfont.load("Comicsans.ttf", 8);
    
    
    
    centerX = ofGetWidth()/2;
    centerY = ofGetHeight()/2;
    
    //cout << "1: CenterX: " <<  centerX << " CenterY: " << centerY << endl;
    //cout << "2: CenterX: " <<  centerX/2 << " CenterY: " << centerY/2 << endl;
    ofSetFrameRate(60);
    ofBackground(0);
    coreMotion.setupAccelerometer();
    
    lastTime = ofGetElapsedTimef();
    frameRateForCapture = 300;
    
    touchPoint.set(0, 0);
    radius = 50;
    counter = 0.0;
    
    minI = 0;
    maxI = 100;
    distanceOfSquares = 125;
    lineInterval = 4;
    
    int textWordSize = 5;
    
    ofSetRectMode(OF_RECTMODE_CENTER);
    
    removeDupWord(beeMovieText);
    for (int i = 0; i < s.size(); i++) {
        if(i % textWordSize == 0){
            string word;
            if( i + textWordSize < s.size()){
                for (int j = 0; j < textWordSize; j++) {
                    word = word + s[i+j] + " ";
                    if (j % 3 == 0) {
                        //word = word + "\n";
                    }
                }
                sn.push_back(word);
            }
        }
    }
    int arraySize = sn.size();
   
    string temp;
    for (int i = 0; i < arraySize/2; ++i) {
        //temp = sn[arraySize-i-1];
        //sn[arraySize-i-1] = sn[i];
        //sn[i] = temp;
    }
    
    
    mySizeTrans = 250;
    
    
}

//--------------------------------------------------------------
void ofApp::update(){
    coreMotion.update();
    counter = counter + 0.029f;
    //highCounter = pow(1.16, highCounter);
}

//--------------------------------------------------------------
void ofApp::draw(){
    //ofDrawCircle(touchPoint,radius);
    ofVec3f a = coreMotion.getAccelerometerData();
    //ofPushMatrix();
    
        //
        //myfont.drawString(mText, 0 - mTextWidth/2, mTextHeight/2);
    
    //y = ((x / 99.0) * 2) - 1
    
    
    
    ofPushMatrix();
        ofTranslate(centerX, ofGetHeight());
    //cout << mySizeTrans << endl;
    mySizeTrans = ofMap(mySizeTrans, 0, 500, 0.1, 1.5);
    //ofScale(mySizeTrans, mySizeTrans);
    float k = 0;
    float newColor, newBGColor;
    float newSize;
        for (int i = minI; i < maxI; i++) {
        //counter = counter / i;
        
        
            
        ofPushMatrix();
            float yRot =   (touchPoint.y - centerY);
            float xRot =   (touchPoint.x - centerX);
            float degreeToAdd =  atan2(yRot,xRot);
            //cout << degreeToAdd << endl;
            
            ofRotateZDeg(180);
            
            newSize = ofMap(i, minI, maxI, 0.2, 3);
            ofScale(newSize, newSize);
            float posX = imagePoint.x;
            posX = ofMap(imagePoint.x, ofGetWidth(), 0, -170, 170);
            float posY = imagePoint.y;
            posY = ofMap(imagePoint.y, ofGetHeight(), 0, 1.1, 1.2);
            //cout << "1: CenterX: " <<  posX << " CenterY: " << posXTest << endl;
            
    
        float height = sin(counter + k);
        float heightLive = 0;//sin(counter + k);
        height += 1.0;
        height *= 40;
        heightLive *= 40;
        float finalYPos = pow(posY, i);
        ofTranslate(posX, finalYPos);
            //cout << "1: CenterX: " <<  finalYPos << " CenterY: " << posY << endl;
    
        newBGColor = ofMap(i, minI, maxI, 5, 125);
        ofSetColor(100, 0, 100, newBGColor);
        ofDrawRectangle(0, 0, 250, -height);
    
    
        newColor = ofMap(i, minI, maxI, 0, 255);
        //posY = ofMap(i-pow(1.5, i), 35, 0, 0, ofGetHeight());
        
            if (i % lineInterval == 0) {
                ofSetColor(0, newColor, newColor);
                ofDrawRectangle(0, 0, distanceOfSquares*3, 15);
            } else {
                ofSetColor(newColor, newColor, 0);
                ofDrawRectangle(distanceOfSquares, 0, 25, 15);
                ofDrawRectangle(-distanceOfSquares, 0, 25, 15);
            }
            ofSetColor(255);
            mText = sn[maxI - (i + 1)];
            mTextWidth = myfont.stringWidth(mText);
            mTextHeight = myfont.stringHeight(mText);
            myfont.drawString(mText, 0 - mTextWidth/2,0 + mTextHeight/2);
            k += 0.7  ;
        ofPopMatrix();
        }
    ofPopMatrix();
        
}
//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    //soundPlayer.play();
    if(touch.id==0 && touch.id != 1){
        dragVector=imagePoint-touch;
    }
    if(touch.id==1 && touched){
        //f=touchPoint.distance(touch);
    }
    
    
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    if(touch.id==0 && touch.id != 1){
        touchPoint.set(touch);
        imagePoint=touch+dragVector;
    }
    if(touch.id==1 && touched){
        mySizeTrans=touchPoint.distance(touch);
    }
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    touched = false;
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}

void ofApp::removeDupWord(string str){
    string word = "";
    for (auto x : str){
        if (x == ' '){
            s.push_back(word);
            word = "";
        }
        else{
            word = word + x;
        }
    }

}
