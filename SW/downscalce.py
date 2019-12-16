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

rows = 9 
cols = 8

out = np.zeros((rows,cols), dtype=np.int)
out_count = np.zeros((rows,cols), dtype=np.int)
factor_rows = rows / img.shape[0]
factor_cols = cols / img.shape[1]

for i in range(img.shape[0]):
	for j in range(img.shape[1]):
		pix = img[i][j]
		u = (i * factor_rows)
		v = (j * factor_cols)
		du = u - int(u)
		dv = v - int(v)

		out[int(u)]		[int(v)] 		+= (1 - du) * (1 - dv) * pix
		out_count[int(u)]		[int(v)] 		+= 1 
		if (u + 1 < rows):
			out_count[int(u + 1)]	[int(v)] 		+= 1
			out[int(u + 1)]	[int(v)] 		+= du * (1 - dv) * pix
		if (v + 1 < cols):
			out[int(u)]		[int(v + 1)] 	+= (1 - du) * dv * pix
			out_count[int(u)]		[int(v + 1)] 	+= 1
		if (u + 1 < rows  and v + 1 < cols):
			out[int(u + 1)]	[int(v + 1)] 	+= du * dv * pix
			out_count[int(u + 1)]	[int(v + 1)] 	+= 1

out = (out / np.mean(out_count) * 4).astype("uint8")
print(np.mean(out_count))

cv2.imshow("Original", img)
cv2.imshow("Downscaled", out)

cv2.imshow("CV2 Downscaled", cv2.resize(img, (cols,rows)))

cv2.waitKey()
