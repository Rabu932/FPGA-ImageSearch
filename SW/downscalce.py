import sys
import numpy as np
import cv2

"""
Proof of concept forward pass downscaling algorithm
Runs slow
"""

if (len(sys.argv) > 1):
	img = cv2.imread(sys.argv[1], cv2.IMREAD_GRAYSCALE)
else:
	img = cv2.imread("test.jpg", cv2.IMREAD_GRAYSCALE)

print(img.shape)
rows = 200 
cols = 200

out = np.zeros((rows,cols), dtype=np.int)
#out_count = np.zeros((rows,cols), dtype=np.int)
factor_rows = rows / img.shape[0]
factor_cols = cols / img.shape[1]

buff_u = 0
buff_v = 0

buff_00 = 0
buff_01 = 0
buff_10 = 0
buff_11 = 0

for i in range(img.shape[0]):
	for j in range(img.shape[1]):
		pix = img[i][j]
		u = (i * factor_rows)
		v = (j * factor_cols)
		if (int(u) != buff_u or int(v) != buff_v):
			out[buff_u][buff_v] 		= buff_00
			out[buff_u][buff_v + 1] 	= buff_01
			out[buff_u + 1][buff_v] 	= buff_10
			out[buff_u + 1][buff_v + 1] = buff_11

			buff_u = min(int(u), rows - 2)
			buff_v = min(int(v), cols - 2)
			buff_00 = out[buff_u][buff_v]
			buff_01 = out[buff_u][buff_v + 1]
			buff_10 = out[buff_u + 1][buff_v]
			buff_11 = out[buff_u + 1][buff_v + 1]
		du = u - int(u)
		dv = v - int(v)

		buff_00 		+= (1 - du) * (1 - dv) * pix
		#out_count[int(u)][int(v)] 		+= 1 
		if (u + 1 < rows):
		#	out_count[int(u + 1)]	[int(v)] 		+= 1
			buff_10 	+= du * (1 - dv) * pix
		if (v + 1 < cols):
			buff_01 	+= (1 - du) * dv * pix
		#	out_count[int(u)][int(v + 1)] 	+= 1
		if (u + 1 < rows  and v + 1 < cols):
			buff_11 	+= du * dv * pix
		#	out_count[int(u + 1)][int(v + 1)] 	+= 1

out = (out / 236 * 4).astype("uint8")
#print((out_count))

cv2.imshow("Original", img)
cv2.imshow("Downscaled", out)

cv2.imshow("CV2 Downscaled", cv2.resize(img, (cols,rows)))

cv2.waitKey()
