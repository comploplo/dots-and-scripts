static const char norm_fg[] = "#c7c6c5";
static const char norm_bg[] = "#211e18";
static const char norm_border[] = "#585651";

static const char sel_fg[] = "#c7c6c5";
static const char sel_bg[] = "#61ba96";
static const char sel_border[] = "#c7c6c5";

static const char urg_fg[] = "#c7c6c5";
static const char urg_bg[] = "#a6977b";
static const char urg_border[] = "#a6977b";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
