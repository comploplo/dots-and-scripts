const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#2a1d17", /* black   */
  [1] = "#da1657", /* red     */
  [2] = "#3ea250", /* green   */
  [3] = "#e3d33d", /* yellow  */
  [4] = "#3ea290", /* blue    */
  [5] = "#ff850d", /* magenta */
  [6] = "#8c16da", /* cyan    */
  [7] = "#e9e9e9", /* white   */

  /* 8 bright colors */
  [8]  = "#4f362b",  /* black   */
  [9]  = "#da1657",  /* red     */
  [10] = "#3ea250", /* green   */
  [11] = "#e3d33d", /* yellow  */
  [12] = "#3ea290", /* blue    */
  [13] = "#ff850d", /* magenta */
  [14] = "#8c16da", /* cyan    */
  [15] = "#e9e9e9", /* white   */

  /* special colors */
  [256] = "#000000", /* background */
  [257] = "#ffffff", /* foreground */
  [258] = "#da4375",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
