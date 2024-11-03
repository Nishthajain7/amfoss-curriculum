#include <termios.h>
#include <time.h>
#ifndef STRUCT_H
#define STRUCT_H

typedef struct erow {
  int size;
  int rsize;
  char *chars;
  char *render;
  unsigned char *hl;
  int idx;
} erow;

struct editorConfig {
  int cx, cy;
  int rx;
  int rowoff;
  int coloff;
  int screenrows;
  int screencols;
  int numrows;
  erow *row;
  char *filename;
  char statusmsg[80];
  time_t statusmsg_time;
  int dirty;
  struct termios orig_termios;
  struct editorSyntax *syntax;
}; 

extern struct editorConfig E;

enum editorKey {
  ENTER = 13,
  BACKSPACE = 127,
  ARROW_LEFT = 1000,
  ARROW_RIGHT,
  ARROW_UP,
  ARROW_DOWN,
  PAGE_UP,
  PAGE_DOWN,
  DEL_KEY,
  CTRL_H = 8,
  ESC = 27,
};

enum editorHighlight {
  HL_NORMAL = 0,
  HL_NUMBER,
  HL_MATCH
};

#endif