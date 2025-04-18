/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 5;       /* gap pixel between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
/*  Display modes of the tab bar: never shown, always shown, shown only in  */
/*  monocle mode in the presence of several windows.                        */
/*  Modes after showtab_nmodes are disabled.                                */
enum showtab_modes { showtab_never, showtab_auto, showtab_nmodes, showtab_always};
static const int showtab			= showtab_auto;        /* Default tab bar show mode */
static const int toptab				= False;               /* False means bottom tab bar */
static const Bool viewontag         = True;     /* Switch view on tag switch */
static const int user_bh            = 25;        /* 0 means that dwm will calculate bar height, >= 1 means dwm will user_bh as bar height */
static const char *fonts[]          = { "FantasqueSansMono:style=bold:size=12", "JoyPixels:pixelsize=14", "siji:pixelsize=14", "fontAwesome:size=14" };
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char col_black[]       = "#000000";
static const char col_red[]         = "#008080";
static const char col_yellow[]      = "#ffff00";
static const char col_white[]       = "#ffffff";
static const char col_grn[]         = "#589072";
static const char col_grn2[]        = "#10713c";
static const char col_blu[]         = "#008080";
    static const char *colors[][4]      = {
           /*               fg         bg         border     float */
    [SchemeNorm] = { col_gray3, col_black, col_gray1, col_black },
    [SchemeSel] =  { col_red, col_black,  col_red, col_blu }, 	
    [SchemeTitle]  = { col_blu, col_black,  col_black  },
};

typedef struct {
	const char *name;
	const void *cmd;
} Sp;

const char *spcmd1[] = {"st", "-n", "spterm", "-g", "120x34", NULL };
const char *spcmd2[] = {"st", "-n", "splogout", "-g", "60x35", "-e", "./.local/bin/scripts/logout.sh", NULL };
const char *spcmd3[] = {"st", "-n", "spvsp2", "-g", "120x35", "-e", "/home/georg/.local/bin/scripts/vsp2", NULL };
const char *spcmd4[] = {"st", "-n", "menu", "-g", "110x34", "-e", "./.local/bin/launch.sh", NULL };
static Sp scratchpads[] = {
   /* name          cmd  */
   {"spterm",      spcmd1},
   {"splogout",    spcmd2},
	{"spvsp2",      spcmd3},
	{"menu",        spcmd4},
};

/* tagging */
static const char *tags[] = { "\uf269", "\uf19d", "\uf121", "\uf07c", "\uf03d", "\uf15c", "\uf120", "\uf0e0", "\uf296" };
static const char *tagsalt[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance            title     tags mask        isfloating      monitor */
	{ "Subl",	        NULL,			  NULL,	  1 << 7,				   0,			    -1 },
	{ "Brave-browser",  NULL,			  NULL,	  1,			            0,			    -1 },
   { "Thunar",         NULL,          NULL,    1 << 1,               0,           -1 },
   { "Thunderbird",    NULL,          NULL,    1 << 8,               0,           -1 },
	{ NULL,		  "spterm",		  NULL,		  SPTAG(0),		            1,			    -1 },
	{ NULL,		  "splogout",	  NULL,		  SPTAG(1),		            1,			    -1 },
	{ NULL,		  "spvsp2",      NULL,		  SPTAG(2),		            1,			    -1 },
   { NULL,       "menu",        NULL,       SPTAG(3),                1,           -1 },
   
};

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "TTT",      bstack },
	{ "===",      bstackhoriz },
	{ NULL,       NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask

#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *termcmd[]  = { "alacritty", NULL };
static const char *filecmd[]  = { "thunar", NULL };
static const char *webcmd[]   = { "firefox", NULL };
static const char *webcmd1[]   = { "brave-browser-stable", NULL };
static const char *mailcmd[]  = { "thunderbird", NULL };

static const char *us_layout[] = {"setxkbmap", "us", NULL};
static const char *de_layout[] = {"setxkbmap", "de", NULL};
static const char *gr_layout[] = {"setxkbmap", "gr", NULL};
static const char *layoutmenu_cmd = "dmenu -i -p 'Layout: '";
static char dmenumon[2] = "0"; /* Monitor für dmenu */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, NULL };

	static const Key keys[] = {
	/* modifier                     key            function                argument */
	/*{ MODKEY,                       XK_p,          spawn,          {.v = fmenu } }, */
	{ MODKEY|ShiftMask,             XK_Return,     spawn,          {.v = filecmd } },
   { MODKEY,                       XK_Return,     spawn,          {.v = termcmd } },
   { MODKEY|ShiftMask,             XK_m,          spawn,          {.v = mailcmd } },
   { MODKEY,                       XK_w,          spawn,          {.v = webcmd1 } },
   { Mod1Mask,                     XK_w,          spawn,          {.v = webcmd } },

	{ MODKEY|ControlMask,           XK_w,          togglebar,      {0} },
	{ MODKEY,                       XK_w,          tabmode,        {-1} },
	{ MODKEY,                       XK_j,          focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,          focusstack,     {.i = -1 } },
	{ MODKEY|ControlMask,           XK_i,          incnmaster,     {.i = +1 } },
	{ MODKEY|ControlMask,           XK_d,          incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,          setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,          setmfact,       {.f = +0.05} },
	{ MODKEY|ControlMask,           XK_Return,     zoom,           {0} },
	{ MODKEY,                       XK_Tab,        view,           {0} },
	{ MODKEY,                       XK_q,          killclient,     {0} },
	/* { MODKEY|ShiftMask,             XK_q,          quit,           {0} },*/
	/* { MODKEY|ControlMask|ShiftMask, XK_q,          quit,           {1} },*/
	{ MODKEY,                       XK_t,          setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,          setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,          setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_u,          setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_o,          setlayout,      {.v = &layouts[4]} },
    { MODKEY|ControlMask,		    XK_comma,       cyclelayout,    {.i = -1 } },
	{ MODKEY|ControlMask,           XK_period,     cyclelayout,    {.i = +1 } },
	{ MODKEY,                       XK_space,      setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,      togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_f,          togglefullscr,  {0} },
	{ MODKEY,                       XK_0,          view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,          tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,      focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period,     focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,      tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,     tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_Left,       viewtoleft,           {0} },
   { MODKEY,                       XK_Right,      viewtoright,          {0} },
   { MODKEY|ShiftMask,             XK_Left,       tagtoleft,            {0} },
   { MODKEY|ShiftMask,             XK_Right,      tagtoright,           {0} },
   { MODKEY,                       XK_n,          togglealttag,         {0} },
   { MODKEY,            			  XK_s,          togglescratch,  {.ui = 0 } },
	{ MODKEY,            			  XK_r,          togglescratch,  {.ui = 1 } },
   { Mod1Mask,                     XK_v,          togglescratch,  {.ui = 2 } },    /* sh -c 'nmtui'\", floating enable, resize set 600 600, move position center */
   { MODKEY|ShiftMask,             XK_d,          togglescratch,  {.ui = 3 } },
   { MODKEY,                       XK_F1,         spawn,          {.v = us_layout } },
   { MODKEY,                       XK_F2,         spawn,          {.v = de_layout } },
   { MODKEY,                       XK_F3,         spawn,          {.v = gr_layout } },
	TAGKEYS(                        XK_1,                                 0)
	TAGKEYS(                        XK_2,                                 1)
	TAGKEYS(                        XK_3,                                 2)
	TAGKEYS(                        XK_4,                                 3)
	TAGKEYS(                        XK_5,                                 4)
	TAGKEYS(                        XK_6,                                 5)
	TAGKEYS(                        XK_7,                                 6)
	TAGKEYS(                        XK_8,                                 7)
	TAGKEYS(                        XK_9,                                 8)
	{ MODKEY|ShiftMask,             XK_c,      quit,                     {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        layoutmenu,     {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button1,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	{ ClkTabBar,            0,              Button1,        focuswin,       {0} },
};

