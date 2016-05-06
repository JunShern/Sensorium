import SimpleOpenNI.*;

SimpleOpenNI cam1;
SimpleOpenNI cam2;

int numPixels = 640*480;
int[] sceneM1 = new int[numPixels];
int[] sceneM2 = new int[numPixels];
PImage scene1,scene2;

void setup()
{
  size(640 * 2, 480); 

  // start OpenNI, loads the library
  SimpleOpenNI.start();

  // init the cameras
  cam1 = new SimpleOpenNI(0,this);
  cam2 = new SimpleOpenNI(1,this);

  // set the camera generators ** HAD TO REVERSE ORDER FOR BOTH KINECTS TO WORK
  cam1.enableDepth();
  cam2.enableDepth();
}

void draw()
{
  // update the cams
  SimpleOpenNI.updateAll();

  image(cam1.depthImage(),0,0);
  image(cam2.depthImage(),640,0);

}

