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
#define CTL_QUOT MT(MOD_LCTL, KC_QUOT)
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

const uint16_t PROGMEM _BSPC[] = {KC_D, KC_F, COMBO_END};
const uint16_t PROGMEM _QUOT[] = {KC_J, KC_K, COMBO_END};
const uint16_t PROGMEM _DQUO[] = {KC_K, KC_L, COMBO_END};
const uint16_t PROGMEM _PLUS[] = {KC_U, KC_I, COMBO_END};
const uint16_t PROGMEM _MINUS[] = {KC_S, KC_D, COMBO_END};
const uint16_t PROGMEM _UNDS[] = {KC_W, KC_E, COMBO_END};
const uint16_t PROGMEM _EQL[] = {KC_I, KC_O, COMBO_END};
const uint16_t PROGMEM _PERC[] = {KC_S, KC_F, COMBO_END};
const uint16_t PROGMEM _TILD[] = {KC_L, KC_J, COMBO_END};
const uint16_t PROGMEM _DLR[] = {KC_E, KC_F, COMBO_END};
const uint16_t PROGMEM _HASH[] = {KC_D, KC_V, COMBO_END};
const uint16_t PROGMEM _DEL[] = {KC_R, KC_G, COMBO_END};
const uint16_t PROGMEM _SPC[] = {KC_K, KC_M, COMBO_END};
const uint16_t PROGMEM _PIPE[] = {KC_V, KC_C, COMBO_END};
const uint16_t PROGMEM _EXLM[] = {KC_M, KC_COMM, COMBO_END};
const uint16_t PROGMEM _AMPR[] = {KC_X, KC_C, COMBO_END};
const uint16_t PROGMEM _AT[] = {KC_DOT, KC_COMMA, COMBO_END};
const uint16_t PROGMEM _GRV[] = {KC_G, KC_F, COMBO_END};
const uint16_t PROGMEM _CIRC[] = {KC_H, KC_J, COMBO_END};
const uint16_t PROGMEM _ASTR[] = {KC_E, KC_R, COMBO_END};
const uint16_t PROGMEM _LCTL[] = {KC_A, KC_Z, COMBO_END};
const uint16_t PROGMEM _BSLS[] = {KC_U, KC_O, COMBO_END};
const uint16_t PROGMEM _BSPCNUM[] = {KC_2, KC_3, COMBO_END};
const uint16_t PROGMEM _COLN[] = {KC_W, KC_R, COMBO_END};
/* const uint16_t PROGMEM QW[] = {KC_Q, KC_W, COMBO_END}; */
/* const uint16_t PROGMEM JI[] = {KC_I, KC_J, COMBO_END}; */
/* const uint16_t PROGMEM IL[] = {KC_I, KC_L, COMBO_END}; */
/* const uint16_t PROGMEM Jc[] = {KC_COMM, KC_J, COMBO_END}; */
/* const uint16_t PROGMEM cL[] = {KC_COMM, KC_L, COMBO_END}; */

combo_t key_combos[COMBO_COUNT] = {
    COMBO(_BSPC, KC_BSPC),
    COMBO(_QUOT, KC_QUOT),
    COMBO(_DQUO, KC_DQUO),
    COMBO(_PLUS, KC_PLUS),
    COMBO(_MINUS, KC_MINUS),
    COMBO(_UNDS, KC_UNDS),
    COMBO(_EQL, KC_EQL),
    COMBO(_PERC, KC_PERC),
    COMBO(_TILD, KC_TILD),
    COMBO(_DLR, KC_DLR),
    COMBO(_HASH, KC_HASH),
    COMBO(_ASTR, KC_ASTR),
    COMBO(_SPC, KC_SPC),
    COMBO(_PIPE, KC_PIPE),
    COMBO(_EXLM, KC_EXLM),
    COMBO(_AMPR, KC_AMPR),
    COMBO(_AT, KC_AT),
    COMBO(_GRV, KC_GRV),
    COMBO(_CIRC, KC_CIRC),
    COMBO(_DEL, KC_DEL),
    COMBO(_LCTL, KC_LCTL),
    COMBO(_BSLS, KC_BSLS),
    COMBO(_BSPCNUM, KC_BSPC),
    COMBO(_COLN, KC_COLN),
    /* COMBO(QW, KC_ESC), */
    /* COMBO(JI, KC_UP), */
    /* COMBO(IL, KC_RIGHT), */
    /* COMBO(Jc, KC_LEFT), */
    /* COMBO(cL, KC_DOWN), */
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

    [_BASE] = LAYOUT( \
  CTL_Q, KC_W, KC_E, KC_R, KC_T, KC_Y, KC_U, KC_I, KC_O, KC_P,
  KC_A, KC_S, KC_D, KC_F, KC_G, KC_H, KC_J, KC_K, KC_L, CTL_QUOT,
  KC_Z, KC_X, KC_C, KC_V, KC_B, KC_N, KC_M, KC_COMM, KC_DOT, SFT_SLSH,
      CTL_LBRC, KC_RBRC, KC_MINS, KC_SCLN,
      SFT_ENT, ALT_ESC, MOD_TAB, NUM_SPC,
      KC_LGUI, ____, ____, KC_LCTRL,
      ____, ____, ____, ____),

[_LOWER] = LAYOUT( \

    ____,     KC_LCBR,  KC_LPRN,  KC_LBRC,  KC_LT,            KC_GT,   KC_RBRC,  KC_RPRN,  KC_RCBR,  KC_PSCREEN,
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
