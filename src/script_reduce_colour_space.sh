#!/bin/bash
convert ../resources/map_plan.png +dither -remap ../resources/colour-pallete.png png8:../resources/map_reduced.png
