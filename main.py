import numpy as np
import cv2

def pixelize(img) :
    cv2.resize(img, (10,10), interpolation=cv2.INTER_AREA);
    #cv2.resize(img, (640, 480), interpolation=cv2.INTER_LINEAR);
    return 

width = 16
height = 12

cap = cv2.VideoCapture(0)
#cap = cv2.VideoCapture('video.mp4')
w = cap.get(3) # 3 is the video width
h = cap.get(4) # 4 is the video height
# Reduce resolution - but there is a minimum. We want the minimum so we set size=1
# On this laptop webcam, the default is 640x480 and minimum is 160x120
#cap.set(3, 1) 
#cap.set(4, 1)

while (cap.isOpened()):
    # Read frame - if read end of video, ret is false
    ret, frame = cap.read()
    frame = cv2.flip(frame,1) # Flip horizontal makes it mirror-like
    #print frame.shape
    # Convert to grayscale
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    # Shrink
    small = cv2.resize(gray, (width, height), interpolation=cv2.INTER_AREA)

    pixelImg = gray
    rectW = frame.shape[1] / width
    rectH = frame.shape[0] / height
    # CHANGE LATER - this method is very slow! Don't use loops, do vectorized maths
    for i in range(width):
        for j in range(height):
            color = small[j,i]
            pixelImg = cv2.rectangle(pixelImg, (i*rectW,j*rectH), ((i+1)*rectW,(j+1)*rectH), int(color), -1)
            font = cv2.FONT_HERSHEY_SIMPLEX
            cv2.putText(pixelImg, str(color), (i*rectW,(j+1)*rectH), font, 0.4, (255,255,255), 1, cv2.LINE_AA)


    cv2.imshow('Pixelized', pixelImg)
    #cv2.waitKey(25) # Frame duration for recorded videos

    # 'q' is for Quit
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()


