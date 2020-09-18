static const char norm_fg[] = "#e9e9e9";
static const char norm_bg[] = "#2a1d17";
static const char norm_border[] = "#4f362b";

static const char sel_fg[] = "#e9e9e9";
static const char sel_bg[] = "#3ea250";
static const char sel_border[] = "#e9e9e9";

static const char urg_fg[] = "#e9e9e9";
static const char urg_bg[] = "#da1657";
static const char urg_border[] = "#da1657";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
