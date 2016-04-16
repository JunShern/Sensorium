import numpy as np
import cv2

def pixelize(img, numCols, numRows) :
    rectW = frame.shape[1] / numCols
    rectH = frame.shape[0] / numRows
    # CHANGE LATER - this method is very slow! Don't use loops, do vectorized maths
    for i in range(width):
        for j in range(height):
            color = small[j,i]
            pixelImg = cv2.rectangle(img, (i*rectW,j*rectH), ((i+1)*rectW,(j+1)*rectH), int(color), -1)
            font = cv2.FONT_HERSHEY_SIMPLEX
            cv2.putText(pixelImg, str(color), (i*rectW+1,(j+1)*rectH-3), font, 0.3, (255,255,255), 1, cv2.LINE_AA)
    return pixelImg

width = 3
height = 3

cap = cv2.VideoCapture(0)
#cap = cv2.VideoCapture('video.mp4')
w = cap.get(3) # 3 is the video width
h = cap.get(4) # 4 is the video height
# Reduce resolution - but there is a minimum. We want the minimum so we set size=1
# On this laptop webcam, the default is 640x480 and minimum is 160x120
cap.set(3, 960) 
cap.set(4, 720)

while (cap.isOpened()):
    # Read frame - if read end of video, ret is false
    ret, frame = cap.read()
    frame = cv2.flip(frame,1) # Flip horizontal makes it mirror-like
    
    # Convert to grayscale
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    # Shrink
    small = cv2.resize(gray, (width, height), interpolation=cv2.INTER_AREA)

    pixelImg = pixelize(gray, width, height)
    
    #ret, threshImg = cv2.threshold(pixelImg,127,255,cv2.THRESH_BINARY)
    
    cv2.imshow('Pixelized', threshImg)

    # 'q' is for Quit
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()


