static const char norm_fg[] = "#f5f5f5";
static const char norm_bg[] = "#151515";
static const char norm_border[] = "#505050";

static const char sel_fg[] = "#f5f5f5";
static const char sel_bg[] = "#acc267";
static const char sel_border[] = "#f5f5f5";

static const char urg_fg[] = "#f5f5f5";
static const char urg_bg[] = "#fb9fb1";
static const char urg_border[] = "#fb9fb1";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
