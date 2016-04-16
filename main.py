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

def calibrate(event, x, y, flags, param):
    if event == cv2.EVENT_LBUTTONDBLCLK: # Double-click
        print "Hello! I was clicked at ", x, y
        global backgroundImg
        backgroundImg = currentImg

def naiveSubtract(currentImg, backgroundImg):
    diff = currentImg - backgroundImg
    #ret, threshImg = cv2.threshold(pixelImg,127,255,cv2.THRESH_TOZERO)
    ret, threshImg = cv2.threshold(diff,250,255,cv2.THRESH_TOZERO_INV)
    return threshImg

# Mouse input
cv2.namedWindow('Difference')
cv2.setMouseCallback('Difference', calibrate)

# Video setup
width = 16
height = 12
cap = cv2.VideoCapture(0)
#cap = cv2.VideoCapture('video.mp4')
w = cap.get(3) # 3 is the video width
h = cap.get(4) # 4 is the video height
# Reduce resolution - but there is a minimum. We want the minimum so we set size=1
# On this laptop webcam, the default is 640x480 and minimum is 160x120
w = 640
h = 480
cap.set(3, w) #960) 
cap.set(4, h) #720)
backgroundImg = np.zeros((h,w),np.uint8)

while (cap.isOpened()):
    # Read frame - if read end of video, ret is false
    ret, frame = cap.read()
    frame = cv2.flip(frame,1) # Flip horizontal makes it mirror-like
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    currentImg = gray.copy()
    cv2.imshow('Current', currentImg)

    # Shrink
    small = cv2.resize(gray, (width, height), interpolation=cv2.INTER_AREA)
    # Pixellate
    pixelImg = pixelize(gray, width, height)
    #cv2.imshow('Grayscale Pixels', pixelImg)
    
    # Difference
    diffImg = naiveSubtract(currentImg, backgroundImg)
    cv2.imshow('Difference', diffImg)
    
    # 'q' is for Quit
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()


