#include QMK_KEYBOARD_H

#define _BASE 0
#define _RAISE 1
#define _LOWER 2
// Fillers to make layering more clear

/* #define RAISE MO(_RAISE) */
#define LOWER MO(_LOWER)

#define ____ KC_TRNS

#define SFT_ENT MT(MOD_LSFT, KC_ENT)
#define ALT_ESC MT(MOD_LALT, KC_ESC)

#define MOD_TAB MT(MOD_LGUI, KC_TAB)
#define NUM_SPC LT(_LOWER, KC_SPC)

#define NUM_BSPC LT(_LOWER, KC_BSPC)
#define MOD_SPC MT(MOD_LGUI, KC_SPC)

#define CTL_SCLN MT(MOD_LCTL, KC_SCLN)
#define CTL_LBRC MT(MOD_LCTL, KC_LBRC)

#define CTL_ENT MT(MOD_LCTL, KC_ENT)
#define SFT_SLSH MT(MOD_LSFT, KC_SLSH)
#define CTL_Q MT(MOD_LCTL, KC_Q)

/* #define CTL_Z MT(MOD_LCTL, KC_Z) */
/* #define KC_ML KC_MS_LEFT */
/* #define KC_MR KC_MS_RIGHT */
/* #define KC_MU KC_MS_UP */
/* #define KC_MD KC_MS_DOWN */
/* #define KC_MB1 KC_MS_BTN1 */
/* #define KC_MB2 KC_MS_BTN2 */

const uint16_t PROGMEM DF[] = {KC_D, KC_F, COMBO_END};
const uint16_t PROGMEM JK[] = {KC_J, KC_K, COMBO_END};
const uint16_t PROGMEM KL[] = {KC_K, KC_L, COMBO_END};
const uint16_t PROGMEM UI[] = {KC_U, KC_I, COMBO_END};
const uint16_t PROGMEM SD[] = {KC_S, KC_D, COMBO_END};
const uint16_t PROGMEM WE[] = {KC_W, KC_E, COMBO_END};
const uint16_t PROGMEM IO[] = {KC_I, KC_O, COMBO_END};
const uint16_t PROGMEM SF[] = {KC_S, KC_F, COMBO_END};
const uint16_t PROGMEM JL[] = {KC_L, KC_J, COMBO_END};
const uint16_t PROGMEM EF[] = {KC_E, KC_F, COMBO_END};
const uint16_t PROGMEM DV[] = {KC_D, KC_V, COMBO_END};
const uint16_t PROGMEM RG[] = {KC_R, KC_G, COMBO_END};
const uint16_t PROGMEM KM[] = {KC_K, KC_M, COMBO_END};
const uint16_t PROGMEM CV[] = {KC_V, KC_C, COMBO_END};
const uint16_t PROGMEM Mc[] = {KC_M, KC_COMM, COMBO_END};
const uint16_t PROGMEM XC[] = {KC_X, KC_C, COMBO_END};
const uint16_t PROGMEM dc[] = {KC_DOT, KC_COMMA, COMBO_END};
const uint16_t PROGMEM FG[] = {KC_G, KC_F, COMBO_END};
const uint16_t PROGMEM JH[] = {KC_H, KC_J, COMBO_END};
const uint16_t PROGMEM ER[] = {KC_E, KC_R, COMBO_END};
/* const uint16_t PROGMEM QW[] = {KC_Q, KC_W, COMBO_END}; */
const uint16_t PROGMEM AZ[] = {KC_A, KC_Z, COMBO_END};
const uint16_t PROGMEM UO[] = {KC_U, KC_O, COMBO_END};
const uint16_t PROGMEM TwoThree[] = {KC_2, KC_3, COMBO_END};
/* const uint16_t PROGMEM JI[] = {KC_I, KC_J, COMBO_END}; */
/* const uint16_t PROGMEM IL[] = {KC_I, KC_L, COMBO_END}; */
/* const uint16_t PROGMEM Jc[] = {KC_COMM, KC_J, COMBO_END}; */
/* const uint16_t PROGMEM cL[] = {KC_COMM, KC_L, COMBO_END}; */

combo_t key_combos[COMBO_COUNT] = {
    COMBO(DF, KC_BSPC),
    COMBO(JK, KC_QUOT),
    COMBO(KL, KC_DQUO),
    COMBO(UI, KC_PLUS),
    COMBO(SD, KC_MINUS),
    COMBO(WE, KC_UNDS),
    COMBO(IO, KC_EQL),
    COMBO(SF, KC_PERC),
    COMBO(JL, KC_TILD),
    COMBO(EF, KC_DLR),
    COMBO(DV, KC_HASH),
    COMBO(ER, KC_ASTR),
    COMBO(KM, KC_SPC),
    COMBO(CV, KC_PIPE),
    COMBO(Mc, KC_EXLM),
    COMBO(XC, KC_AMPR),
    COMBO(dc, KC_AT),
    COMBO(FG, KC_GRV),
    COMBO(JH, KC_CIRC),
    COMBO(RG, KC_DEL),
    /* COMBO(QW, KC_ESC), */
    COMBO(AZ, KC_LCTL),
    COMBO(UO, KC_BSLS),
    COMBO(TwoThree, KC_BSPC),
    /* COMBO(JI, KC_UP), */
    /* COMBO(IL, KC_RIGHT), */
    /* COMBO(Jc, KC_LEFT), */
    /* COMBO(cL, KC_DOWN), */
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

    [_BASE] = LAYOUT( \
  CTL_Q, KC_W, KC_E, KC_R, KC_T, KC_Y, KC_U, KC_I, KC_O, KC_P,
  KC_A, KC_S, KC_D, KC_F, KC_G, KC_H, KC_J, KC_K, KC_L, CTL_SCLN,
  KC_Z, KC_X, KC_C, KC_V, KC_B, KC_N, KC_M, KC_COMM, KC_DOT, SFT_SLSH,
      CTL_LBRC, KC_RBRC, KC_MINS, KC_QUOT,
      SFT_ENT, ALT_ESC, MOD_TAB, NUM_SPC,
      MOD_SPC, ____, ____, CTL_ENT,
      ____, ____, ____, ____),

[_LOWER] = LAYOUT( \

    CMB_TOG,  KC_LCBR,  KC_LPRN,  KC_LBRC,  ____,             ____,    KC_RBRC,  KC_RPRN,  KC_RCBR, KC_PSCREEN,
    KC_0,     KC_1,     KC_2,     KC_3,     KC_4,             KC_LEFT, KC_DOWN,  KC_UP,    KC_RIGHT, ____,
    KC_5,     KC_6,     KC_7,     KC_8,     KC_9,             ____,    ____,     ____,     ____,    KC_BSLS,
    ____,  ____,                                                                 KC_PGDN,  KC_PGUP,
                                             ____, ____,  ____, ____,
                                             ____, ____,  ____, ____,
                                             ____, ____,  ____, ____
)
};

void persistent_default_layer_set(uint16_t default_layer) {
    eeconfig_update_default_layer(default_layer);
    default_layer_set(default_layer);
}
