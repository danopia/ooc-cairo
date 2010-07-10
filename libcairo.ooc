use cairo
include cairo

CairoT: cover

Cairo: cover from CairoT* {
  
  // Context
  ////////////
  
  setSource: extern(cairo_set_source_rgb) func~RGB (red, green, blue: Double)
  setSource: extern(cairo_set_source_rgba) func~RGBA (red, green, blue, alpha: Double)
  
  save: extern(cairo_save) func
  restore: extern(cairo_restore) func
  
  paint: extern(cairo_paint) func
  paint: extern(cairo_paint_with_alpha) func~alpha (alpha: Double)
  
  stroke: extern(cairo_stroke) func
  
  destroy: extern(cairo_destroy) func
  
  // Paths
  ////////////
  
  moveTo: extern(cairo_move_to) func (x, y: Double)
  lineTo: extern(cairo_line_to) func (x, y: Double)
  
  relMoveTo: extern(cairo_rel_move_to) func (dx, dy: Double)
  relLineTo: extern(cairo_rel_line_to) func (dx, dy: Double)
  
  // Text
  ////////////
  
  showText: extern(cairo_show_text) func (utf8: String)
  
  selectFontFace: extern(cairo_select_font_face) func (family: String, slant: Slant, weight: Weight)
  
  fontSize: Double {
    set: extern(cairo_set_font_size)
  }
}

Slant: enum {
  normal: extern(CAIRO_FONT_SLANT_NORMAL)
  italic: extern(CAIRO_FONT_SLANT_ITALIC)
  oblique: extern(CAIRO_FONT_SLANT_OBLIQUE)
}

Weight: enum {
  normal: extern(CAIRO_FONT_WEIGHT_NORMAL)
  bold: extern(CAIRO_FONT_WEIGHT_BOLD)
}
