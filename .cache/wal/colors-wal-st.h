const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#211e18", /* black   */
  [1] = "#a6977b", /* red     */
  [2] = "#61ba96", /* green   */
  [3] = "#a1c2bb", /* yellow  */
  [4] = "#7fa7a2", /* blue    */
  [5] = "#5875ab", /* magenta */
  [6] = "#ab393d", /* cyan    */
  [7] = "#c7c6c5", /* white   */

  /* 8 bright colors */
  [8]  = "#585651",  /* black   */
  [9]  = "#a6977b",  /* red     */
  [10] = "#61ba96", /* green   */
  [11] = "#a1c2bb", /* yellow  */
  [12] = "#7fa7a2", /* blue    */
  [13] = "#5875ab", /* magenta */
  [14] = "#ab393d", /* cyan    */
  [15] = "#c7c6c5", /* white   */

  /* special colors */
  [256] = "#211e18", /* background */
  [257] = "#c7c6c5", /* foreground */
  [258] = "#c7c6c5",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
