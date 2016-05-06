
public class LEDwall 
{
  OPC opc;
  
  LEDwall(OPC opc, int numHorizontalPanels, int numVerticalPanels) {
    this.opc = opc;
    
    int panelWidth = width/numHorizontalPanels;
    int panelHeight = height/numVerticalPanels;
    int panelNumber = 0;
    for (int j=0; j<numVerticalPanels; j++) {
      for (int i=0; i<numHorizontalPanels; i++) {
        int panelStartingIndex = panelNumber * 512;
        int panelCenterX = panelWidth/2 + i*panelWidth;
        int panelCenterY = panelHeight/2 + j*panelHeight;
        initLEDpanel(panelStartingIndex, panelCenterX, panelCenterY, panelWidth, panelHeight);
        panelNumber++;
      }
    }
  }
  
  void initLEDpanel(int panelStartingIndex, int panelCenterX, int panelCenterY, int panelWidth, int panelHeight) {
    // ledStrip(index, numLEDs, x, y, xSpacing, angle, reversed)
    int numLEDsPerRow = 18;
    int numberOfRows = 24;
    int xSpacing = panelWidth / numLEDsPerRow;
    int ySpacing = panelHeight / numberOfRows;
    int angle = 0;
    int x = panelCenterX;
    int rowNumber = 0;
    // Channel by channel
    for (int channelNum=0; channelNum<8; channelNum++) {
      int channelIndex = channelNum * 64; 
      // Three rows per channel
      for (int r = 0; r < 3; r++) {
        int index = panelStartingIndex + channelIndex + r * (numLEDsPerRow+1); // +1 index because of strip bending
        if (rowNumber > 0 && rowNumber % 8 == 0) index -= 2; // skip 1 LED and 1 bend at the start of a new strip
        if (rowNumber == 17) index -= 2;
        int y = panelCenterY - panelHeight/2 + ySpacing/2 + rowNumber * ySpacing;
        boolean reversed = boolean(rowNumber % 2);
        this.opc.ledStrip(index, numLEDsPerRow, x, y, xSpacing, angle, reversed);
        rowNumber++;
        // Make sure the bent LED stays off
        this.opc.setPixel(index+numLEDsPerRow, color(0)); // Turn off at the end of the row
      } 
    }
  }
}

