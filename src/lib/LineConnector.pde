class LineConnector {

    ArrayList<PVector> allPoints;

    LineConnector() {
        allPoints = new ArrayList<PVector>();
    }

    void addPoint(PVector pnt) {
        allPoints.add(pnt);
    }

}