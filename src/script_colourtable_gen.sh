#!/bin/bash
convert                        \
     -size 60x60                \
	  -alpha on \
		xc:"srgb(0, 0, 0, 0)" \
		xc:"rgb(109, 0, 26)" \
		xc:"rgb(190, 0, 57)" \
		xc:"rgb(255, 69, 0)" \
		xc:"rgb(255, 168, 0)" \
		xc:"rgb(255, 214, 53)" \
		xc:"rgb(255, 248, 184)" \
		xc:"rgb(0, 163, 104)" \
		xc:"rgb(0, 204, 120)" \
		xc:"rgb(126, 237, 86)" \
		xc:"rgb(0, 117, 111)" \
		xc:"rgb(0, 158, 170)" \
		xc:"rgb(0, 204, 192)" \
		xc:"rgb(36, 80, 164)" \
		xc:"rgb(54, 144, 234)" \
		xc:"rgb(81, 233, 244)" \
		xc:"rgb(73, 58, 193)" \
		xc:"rgb(106, 92, 255)" \
		xc:"rgb(148, 179, 255)" \
		xc:"rgb(129, 30, 159)" \
		xc:"rgb(180, 74, 192)" \
		xc:"rgb(228, 171, 255)" \
		xc:"rgb(222, 16, 127)" \
		xc:"rgb(255, 56, 129)" \
		xc:"rgb(255, 153, 170)" \
		xc:"rgb(109, 72, 47)" \
		xc:"rgb(156, 105, 38)" \
		xc:"rgb(255, 180, 112)" \
		xc:"rgb(0, 0, 0)" \
		xc:"rgb(81, 82, 82)" \
		xc:"rgb(137, 141, 144)" \
		xc:"rgb(212, 215, 217)" \
		xc:"rgb(255, 255, 255)" \
		+append                    \
		png8:../resources/colour-pallete.png
