// GtkDrawingArea - A widget for custom user interface elements
// http://library.gnome.org/devel/gtk/unstable/GtkDrawingArea.html

use gtk
import gtk/[Gtk, Widget]

DrawingAreaStruct: cover from GtkDrawingArea

/**
 * A simple Gtk window
 */
DrawingArea: cover from DrawingAreaStruct* extends Widget {
	
	/**
	 * Create a new drawing area
	 */
	new: extern(gtk_drawing_area_new) static func -> This
  
  // TODO: Goes in GtkWidget
  
  setSizeRequest: extern(gtk_widget_set_size_request) func (width, height: GInt)
}
