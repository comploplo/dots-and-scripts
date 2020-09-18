const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#151515", /* black   */
  [1] = "#fb9fb1", /* red     */
  [2] = "#acc267", /* green   */
  [3] = "#ddb26f", /* yellow  */
  [4] = "#6fc2ef", /* blue    */
  [5] = "#e1a3ee", /* magenta */
  [6] = "#12cfc0", /* cyan    */
  [7] = "#d0d0d0", /* white   */

  /* 8 bright colors */
  [8]  = "#505050",  /* black   */
  [9]  = "#fb9fb1",  /* red     */
  [10] = "#acc267", /* green   */
  [11] = "#ddb26f", /* yellow  */
  [12] = "#6fc2ef", /* blue    */
  [13] = "#e1a3ee", /* magenta */
  [14] = "#12cfc0", /* cyan    */
  [15] = "#f5f5f5", /* white   */

  /* special colors */
  [256] = "#151515", /* background */
  [257] = "#d0d0d0", /* foreground */
  [258] = "#d0d0d0",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
