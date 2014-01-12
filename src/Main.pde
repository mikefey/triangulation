toxi.physics2d.VerletPhysics2D physics;
int[][] points;
ArrayList<Particle> particles;
int[] triangles;
ArrayList<color> triangleColors;
int numPoints = 100;
boolean mouseIsDown = true;
Particle activeParticle;
LineConnector lineConnector;

void setup() {
    onResize();
    setupPoints();
}

void setupPoints() {
    console.log(toxi);
    physics = new toxi.physics2d.VerletPhysics2D();
    physics.addBehavior(new toxi.physics2d.behaviors.GravityBehavior(new toxi.geom.Vec2D(0, 0)));
    physics.setWorldBounds(new toxi.geom.Rect(0,0,width,height));
    points = new int[numPoints];
    triangleColors = new ArrayList<color>();
    particles = new ArrayList<Particle>();
    lineConnector = new LineConnector();

    for (int i = 0; i < numPoints; i++) {
        int[] pointPositions = new int[2];
        pointPositions[0] = random(0, width);
        pointPositions[1] = random(0, height);
        points[i] = pointPositions;
    }

    for (int i = 0; i < points.length; i++) {
        PVector position = new toxi.geom.Vec2D(points[i][0], points[i][1]);
        Particle p = new Particle(position, i);
        physics.addParticle(p.tlParticle);
        p.tlParticle.lock();
        particles.add(p);
    }

    triangles = Delaunay.triangulate(points);

    for (var i = 0; i < triangles.length; i++) {
        color from = color(204, 102, 0);
        color to = color(0, 102, 153);
        color randColor = color(random(255),random(255),random(255));
        triangleColors.add(randColor);
    }
}

void drawConnections() {
    //stroke(255, 32, 40);
    //fill(0, 0, 0);
    noFill();
    noStroke();

    for(int i = triangles.length; i;) {
        beginShape();
        fill(triangleColors.get(i));
        i--; vertex(points[triangles[i]][0], points[triangles[i]][1]);
        i--; vertex(points[triangles[i]][0], points[triangles[i]][1]);
        i--; vertex(points[triangles[i]][0], points[triangles[i]][1]);
        endShape();
    }
}

void mousePressed() {
    for (int i = 0; i < particles.size(); i++) {
        if(MouseUtils.hitTest(particles.get(i).tlParticle.x, particles.get(i).tlParticle.y, 32, 32)) {
            activeParticle = particles.get(i);
        }
    }
}

void mouseDragged() {
    if (activeParticle) {
        activeParticle.tlParticle.x = mouseX;
        activeParticle.tlParticle.y = mouseY;

        points[activeParticle.iteration][0] = mouseX;
        points[activeParticle.iteration][1] = mouseY;
    }
}

void mouseReleased() {
    activeParticle = null;
}

void draw() {
    background(255, 255, 255);

    //triangles = Delaunay.triangulate(points);
    drawConnections();

    for (int i = 0; i < particles.size(); i++) {
        particles.get(i).display();
    }

    physics.update();
}

void onResize() {
    size($(window).width(), $(window).height(), P2D);
}