import numpy as np
import cv2

cap = cv2.VideoCapture(0)
#cap = cv2.VideoCapture('video.mp4')

while (cap.isOpened()):
	# Read frame - if read end of video, ret is false
	ret, frame = cap.read()
	frame = cv2.flip(frame,1) # Flip horizontal makes it mirror-like
	# Convert to grayscale
	gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

	cv2.imshow('frame', gray)
	#cv2.waitKey(25) # Frame duration for recorded videos

	# 'q' is for Quit
	if cv2.waitKey(1) & 0xFF == ord('q'):
		break

cap.release()
cv2.destroyAllWindows()


