'''
  SPDX-License-Identifier: Apache-2.0
  This file is part of termux-container.

  Copyright (c) 2023 Moe-hacker

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
  
'''
import matplotlib.pyplot as pyplot
import matplotlib.patches as patches
import math
import sys
# Set image parameters.
figure, axes = pyplot.subplots(dpi=200, figsize=(8, 4))
pyplot.box(False)
pyplot.xticks([])
pyplot.yticks([])
pyplot.subplots_adjust(bottom=0.2,top=1)
axes.set_aspect(1)
# Draw the hexagons, unnecessary because patches.Wedge() draws it as well.
pyplot.plot([math.sqrt(3) * 3, 0], [3, 6], linewidth=2, color='#fee4d0',linestyle="--")
pyplot.plot([math.sqrt(3) * 3 * (-1), math.sqrt(3) * 3 * (-1)], [3, -3], linewidth=2, color='#fee4d0',linestyle="--")
pyplot.plot([math.sqrt(3) * 3, math.sqrt(3) * 3], [3, -3], linewidth=2, color='#fee4d0',linestyle="--")
pyplot.plot([math.sqrt(3) * 3, 0], [-3, -6], linewidth=2, color='#fee4d0',linestyle="--")
pyplot.plot([math.sqrt(3) * 3 * (-1), 0], [3, 6], linewidth=2, color='#fee4d0',linestyle="--")
pyplot.plot([math.sqrt(3) * 3 * (-1), 0], [-3, -6], linewidth=2, color='#fee4d0',linestyle="--")
# Draw the diagonals.
pyplot.plot([-0.003, -0.003], [-6, 0], linewidth=2, color='#fee4d0',linestyle="--")
pyplot.plot([0,math.sqrt(3) * 3*(-1)], [0,3], linewidth=2, color='#fee4d0',linestyle="--")
pyplot.plot([0,math.sqrt(3) * 3], [0, 3], linewidth=2, color='#fee4d0',linestyle="--")
pyplot.xlim(-8, 8)
pyplot.ylim(-8, 8)
# Draw the title.
'''
pyplot.title("r u r i", color='#fee4d0', y=-0.05, x=0.475, fontsize=39, fontweight="normal")
pyplot.text(-0.12, -0.12, "Linux containers, simple & secure", fontsize=16,fontweight="black", transform=axes.transAxes, color='#fee4d0')
'''
# Save as logo.png.
pyplot.show()
#pyplot.savefig('logo.png', transparent=True)
