import numpy as np
import cv2
import serial

def pixelize(img, numCols, numRows) :
    rectW = frame.shape[1] / numCols
    rectH = frame.shape[0] / numRows
    small = cv2.resize(img, (width, height), interpolation=cv2.INTER_AREA)
    # CHANGE LATER - this method is very slow! Don't use loops, do vectorized maths
    for i in range(width):
        for j in range(height):
            color = small[j,i]
            pImg = cv2.rectangle(img, (i*rectW,j*rectH), ((i+1)*rectW,(j+1)*rectH), int(color), -1)
            #font = cv2.FONT_HERSHEY_SIMPLEX
            #cv2.putText(pImg, str(color), (i*rectW+1,(j+1)*rectH-3), font, 0.3, (255,100,255), 1, cv2.LINE_AA)
    return pImg

def calibrate(event, x, y, flags, param):
    if event == cv2.EVENT_LBUTTONDBLCLK: # Double-click
        print "Hello! I was clicked at ", x, y
        global backgroundImg
        backgroundImg = currentImg

def naiveSubtract(currentImg, backgroundImg):
    diff = currentImg - backgroundImg
    ret, tImg = cv2.threshold(diff,250,255,cv2.THRESH_TOZERO_INV)
    return tImg

# Mouse input
cv2.namedWindow('Difference')
cv2.setMouseCallback('Difference', calibrate)
cv2.setMouseCallback('Difference Pixels', calibrate) # doesn't seem to work?

# Video setup
width = 64
height = 48
cap = cv2.VideoCapture(0)
#cap = cv2.VideoCapture('video.mp4')
w = cap.get(3) # 3 is the video width
h = cap.get(4) # 4 is the video height
# Reduce resolution - but there is a minimum. We want the minimum so we set size=1
# On this laptop webcam, the default is 640x480 and minimum is 160x120
w = 1280
h = 960
cap.set(3, w) #960) 
cap.set(4, h) #720)

# BG subtraction setup
backgroundImg = np.zeros((h,w),np.uint8)
#fgbg = cv2.createBackgroundSubtractorMOG2()

# Serial
#ser = serial.Serial('COM12', 9600)

while (cap.isOpened()):
    # Read frame - if read end of video, ret is false
    ret, frame = cap.read()
    frame = cv2.flip(frame,1) # Flip horizontal makes it mirror-like
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    currentImg = gray.copy()
    cv2.imshow('Current', currentImg)

    # Pixellate
    pixelImg = pixelize(gray, width, height)
    cv2.imshow('Grayscale Pixels', pixelImg)
    
    # Difference
    diffImg = naiveSubtract(currentImg, backgroundImg)
    #diffImg = fgbg.apply(frame) # Has an error about numpy:allocate :(
    #cv2.imshow('Difference', diffImg)

    # Pixellate Difference
    diffPixelImg = pixelize(diffImg, width, height)
    ret, diffPixelImg = cv2.threshold(diffPixelImg,50,255,cv2.THRESH_BINARY)
    cv2.imshow('Difference Pixels', diffPixelImg)
    """
    small = cv2.resize(currentImg, (width, height), interpolation=cv2.INTER_AREA)
    ret, small = cv2.threshold(small,50,255,cv2.THRESH_BINARY)
    for i in range(width):
        for j in range(height):
            ser.write(str(small[j,i]))
            print str(small[j,i])
    """
    # 'q' is for Quit
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()


