/*  hello world for gtk with cairo support, by Ã˜vyind KolÃ¥s
 */

use gtk
import gtk/[Gtk, Window, Widget]
import gtkDrawingArea

use gdk
import gdk/Drawable

use cairo
import libcairo

DEFAULT_WIDTH := 400
DEFAULT_HEIGHT := 200

gtk_main_quit: extern func

main: func {
  // create a new top level window
  window := Window new()
  window setTitle("Hello World from Cairo")

  // make the gtk terminate the process the close button is pressed
  window connect("delete_event", gtk_main_quit)

  // create a new drawing area widget
  canvas := DrawingArea new()

  // set a requested (minimum size) for the canvas
  canvas setSizeRequest(DEFAULT_WIDTH, DEFAULT_HEIGHT)

  // connect our drawing method to the "expose" signal
  canvas connect("expose-event", paint)

  // pack canvas widget into window
  window add(canvas)

  // show window and all it's children (just the canvas widget)
  window showAll()
 
  // enter main loop
  Gtk main()
}

RegionStruct: cover
Region: cover from RegionStruct* {
  new: extern(gdk_region_new) static func -> This
  //new: extern(gdk_region_polygon) static func~polygon (GdkPoint *points, nPoints: GInt, fillRule: GdkFillRule-> This
}

RectangleStruct: cover from GdkRectangle {
  x, y, width, height: extern GInt
} 

EventExposeStruct: cover from GdkEventExpose {
  type: extern GInt // TODO: http://library.gnome.org/devel/gdk/stable/gdk-Events.html#GdkEventType
  window: extern Window
  send_event: extern GInt8
  area: extern RectangleStruct
  region: extern Region
  count: extern GInt /* If non-zero, how many more events follow. */
}
EventExpose: cover from EventExposeStruct*

GdkCairoCreate: extern(gdk_cairo_create) func (drawable: Drawable) -> Cairo

/* the actual function invoked to paint the canvas
 * widget, this is where most cairo painting functions
 * will go
 */
paint: func (widget: Widget, eev: EventExpose, data: Pointer) {
  width  := widget@ allocation width
  height := widget@ allocation height
  
  cr := GdkCairoCreate(widget@ window as Drawable)

  // clear background
  cr setSource(1, 1, 1)
  cr paint()

  cr selectFontFace("Sans", Slant normal, Weight bold)

  // enclosing in a save/restore pair since we alter the font size
  cr save()
  cr fontSize = 40
  cr moveTo(40, 60)
  cr setSource(0, 0, 0)
  cr showText("Hello World")
  cr restore()

  cr setSource(1, 0, 0)
  cr fontSize = 20
  cr moveTo(50, 100)
  cr showText("greetings from gtk and cairo")

  cr setSource(0, 0, 1)
  cr moveTo(0, 150)
  for (i in 0..(width / 10)) {
    cr relLineTo(5,  10)
    cr relLineTo(5, -10)
  }
  cr stroke()

  cr destroy()
}
