import de.fhpotsdam.unfolding.UnfoldingMap;
import de.fhpotsdam.unfolding.geo.Location;
import de.fhpotsdam.unfolding.utils.*;

UnfoldingMap map;
Location boundTopLeft = new Location(52.8, 12.6);
Location boundBottomRight = new Location(52.0, 14.5);

public void setup() {
  size(800, 600);
  map = new UnfoldingMap(this);
  map.zoomAndPanTo(new Location(52.5, 13.4f), 10);
  map.setZoomRange(10, 12);
  MapUtils.createDefaultEventDispatcher(this, map);
}

public void draw() {
  checkBoundingBox();
  map.draw();
}

public void checkBoundingBox() {
  Location mapTopLeft = map.getTopLeftBorder();
  Location mapBottomRight = map.getBottomRightBorder();
  ScreenPosition mapTopLeftPos = map.getScreenPosition(mapTopLeft);
  ScreenPosition boundTopLeftPos = map.getScreenPosition(boundTopLeft);
  if (boundTopLeft.getLon() > mapTopLeft.getLon()) {
    map.panBy(mapTopLeftPos.x - boundTopLeftPos.x, 0);
  }
  if (boundTopLeft.getLat() < mapTopLeft.getLat()) {
    map.panBy(0, mapTopLeftPos.y - boundTopLeftPos.y);
  }
  ScreenPosition mapBottomRightPos = map.getScreenPosition(mapBottomRight);
  ScreenPosition boundBottomRightPos = map.getScreenPosition(boundBottomRight);
  if (boundBottomRight.getLon() < mapBottomRight.getLon()) {
    map.panBy(mapBottomRightPos.x - boundBottomRightPos.x, 0);
  }
  if (boundBottomRight.getLat() > mapBottomRight.getLat()) {
    map.panBy(0, mapBottomRightPos.y - boundBottomRightPos.y);
  }
}

